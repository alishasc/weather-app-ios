//
//  WeatherDataModel.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let timezone: String
    let current: WeatherDataModel
    let hourly: [WeatherDataModel]
    let daily: [WeatherDataModel]
}

struct WeatherDataModel: Decodable, Identifiable {
    // common keys
    var id: UUID = UUID()
    let dateAndTime: Int
    let summary: String
    let icon: String
    let windSpeed: Double
    let humidity: Int
    let pressure: Int
    
    // not in 'daily'
    let temperature: Double?
    let feelsLike: Double?
    
    // only in 'daily' - inside temp{}
    let dayTemp: Double?
    let nightTemp: Double?
    let minTemp: Double?
    let maxTemp: Double?
    
    enum CodingKeys: String, CodingKey {
        case dateAndTime = "dt"
        case weather  // nested array with description and icon
        case summary = "description"
        case icon
        case windSpeed = "wind_speed"
        case humidity, pressure
        
        // optional keys - not in 'daily'
        case temperature = "temp"
        case feelsLike = "feels_like"
        
        // optional keys - only in 'daily'
        case dayTemp = "day"
        case nightTemp = "night"
        case minTemp = "min"
        case maxTemp = "max"
    }
    
    init(from decoder: any Decoder) throws {
        // outer container
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // non-optional keys
        dateAndTime = try container.decode(Int.self, forKey: .dateAndTime)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        humidity = try container.decode(Int.self, forKey: .humidity)
        pressure = try container.decode(Int.self, forKey: .pressure)
        
        // decode weather array
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let weather = try weatherArray.nestedContainer(keyedBy: CodingKeys.self)
        summary = try weather.decode(String.self, forKey: .summary)
        icon = try weather.decode(String.self, forKey: .icon)
        
        // optional keys - not in 'daily'
        temperature = try? container.decodeIfPresent(Double.self, forKey: .temperature) ?? nil
        feelsLike = try? container.decodeIfPresent(Double.self, forKey: .feelsLike) ?? nil
        
        // only in 'daily' - inside temp container
        if let tempContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .temperature) {
            dayTemp = try tempContainer.decode(Double.self, forKey: .dayTemp)
            nightTemp = try tempContainer.decode(Double.self, forKey: .nightTemp)
            minTemp = try tempContainer.decode(Double.self, forKey: .minTemp)
            maxTemp = try tempContainer.decode(Double.self, forKey: .maxTemp)
        } else {
            dayTemp = nil
            nightTemp = nil
            minTemp = nil
            maxTemp = nil
        }
    }
}
