//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Temiloluwa on 06-12-2025.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var saveFavoriteButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var viewModel: HomeViewModel!
    
    // MARK: - View lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        errorLabel.isHidden = true
        errorLabel.text = nil
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Auto-focus textfield for better UX
        if cityTextField.text?.isEmpty ?? true {
            cityTextField.becomeFirstResponder()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Dismiss keyboard when navigating away
        view.endEditing(true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup Methods
    
    private func setupViewModel() {
        // use DI from the container to achieve loose coupling
        viewModel = DependencyContainer.shared.makeHomeViewModel()
        
        // Set up callbacks
        viewModel.didUpdateCityName = { [weak self] city in
            
            DispatchQueue.main.async {
                
                self?.cityTextField.text = city
            }
        }
        
        viewModel.didUpdateLoading = { [weak self] isLoading  in
            
            DispatchQueue.main.async {
                
                if isLoading {
                    
                    self?.activityIndicator.startAnimating()
                    self?.searchButton.isEnabled = false
                    self?.searchButton.alpha = 0.5
                    self?.saveFavoriteButton.isEnabled = false
                }else {
                    self?.activityIndicator.stopAnimating()
                    self?.searchButton.isEnabled = true
                    self?.searchButton.alpha = 1.0
                    self?.saveFavoriteButton.isEnabled = true
                }
            }
        }
        
        viewModel.didUpdateError = { [weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error
                self?.errorLabel.isHidden = (error == nil)
            }
        }
        
        if !viewModel.cityName.isEmpty {
            cityTextField.text = viewModel.cityName
        }
    }
    
    private func setupUI() {
        
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //style UI buttons
        searchButton.layer.cornerRadius = 8
        saveFavoriteButton.layer.cornerRadius = 8
        
        //style textfield
        cityTextField.layer.cornerRadius = 8
        cityTextField.layer.borderWidth = 1
        cityTextField.layer.borderColor = UIColor.systemGray4.cgColor
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: cityTextField.frame.height))
        cityTextField.leftViewMode = .always
        
        cityTextField.delegate = self
        
        let placeholder = NSAttributedString(
            string: "Enter city name",
            attributes: [.foregroundColor: UIColor.systemGray]
        )
        cityTextField.attributedPlaceholder = placeholder
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else {
            showError(message: "Please enter a city name")
            return
        }
        
        viewModel.updateCityname(city)
        
        Task {
            if let weatherData = await viewModel.fetchWeather() {
                performSegue(withIdentifier: "showWeatherDetail", sender: weatherData)
            }
        }
    }
    
    @IBAction func saveAsFavoriteButtonTapped(_ sender: UIButton) {
        guard let city = cityTextField.text, !city.isEmpty else {
            showError(message: "Enter a city name to save as favorite")
            return
        }
        
        viewModel.updateCityname(city)
        viewModel.saveFavoriteCity()
        
        // Show confirmation with haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let alert = UIAlertController(
            title: "⭐ City Saved",
            message: "\(city) is now your favorite city. It will auto-fill on next launch.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        viewModel.updateCityname(sender.text ?? "")
        
        // Clear error when user starts typing
        if !(sender.text?.isEmpty ?? true) {
            errorLabel.isHidden = true
            errorLabel.text = nil
        }
    }
    
    private func showError(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        
        // Shake animation for error
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x - 5, y: errorLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: errorLabel.center.x + 5, y: errorLabel.center.y))
        errorLabel.layer.add(animation, forKey: "position")
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeatherDetail",
           let destination = segue.destination as? WeatherDetailViewController,
           let weatherData = sender as? WeatherData {
            
            let detailViewModel = DependencyContainer.shared.makeWeatherDetailViewModel(
                weatherData: weatherData
            )
            destination.viewModel = detailViewModel
        }
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButtonTapped(searchButton)
        return true
    }
}
