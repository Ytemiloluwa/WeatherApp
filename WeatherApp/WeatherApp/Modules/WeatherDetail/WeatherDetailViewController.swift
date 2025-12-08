//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Temiloluwa on 06-12-2025.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var viewModel: WeatherDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        // Style labels
        cityLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        temperatureLabel.font = UIFont.systemFont(ofSize: 72, weight: .thin)
        descriptionLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        descriptionLabel.textColor = .secondaryLabel
        
        // Style detail labels
        feelsLikeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        humidityLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        windLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        // Weather icon
        weatherIconImageView.contentMode = .scaleAspectFit
        weatherIconImageView.tintColor = .systemYellow
        
    }
    
    private func updateUI() {
        
        cityLabel.text = viewModel.cityName
        temperatureLabel.text = viewModel.temperature
        descriptionLabel.text = viewModel.weatherDescription
        feelsLikeLabel.text = viewModel.feelsLikeTemperature
        humidityLabel.text = viewModel.humidity
        windLabel.text = viewModel.windspeed
        updateWeatherIcon()
        
    }
    
    private func updateWeatherIcon() {
        let iconName: String
        
        switch viewModel.weatherDescription.lowercased() {
        case let desc where desc.contains("clear"):
            iconName = "sun.max.fill"
        case let desc where desc.contains("cloud"):
            iconName = "cloud.fill"
        case let desc where desc.contains("rain"):
            iconName = "cloud.rain.fill"
        case let desc where desc.contains("snow"):
            iconName = "snow"
        case let desc where desc.contains("thunder"):
            iconName = "cloud.bolt.fill"
        default:
            iconName = "cloud.sun.fill"
        }
        
        weatherIconImageView.image = UIImage(systemName: iconName)
    }
}
