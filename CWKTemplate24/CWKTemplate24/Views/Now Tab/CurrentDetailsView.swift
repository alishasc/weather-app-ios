//
//  CurrentForecastView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 05/12/2024.
//

// Now tab - images with current weather info

import SwiftUI

struct CurrentDetailsView: View {
    var icon: String
    var description: String
    var feelsLike: Double
    var maxTemp: Double
    var minTemp: Double
    var windSpeed: Double
    var humidity: Int
    var pressure: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            // first row
            HStack(spacing: 50) {
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon).png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()  // loading icon
                }
                .frame(width: 50, height: 50)
                
                // description and feels like
                VStack {
                    Text("\(description.capitalized)")
                        .font(.title3)
                    Text("Feels Like: \(String(format: "%.0f", feelsLike))ºC")
                        .font(.title3)
                }
            }
            // rest
            ViewTemplates.weatherImageAndText(image: "temperature", text: "H: \(String(format: "%.0f", maxTemp))ºC", text2: "L: \(String(format: "%.0f", minTemp))ºC")
            ViewTemplates.weatherImageAndText(image: "windSpeed", text: "Wind Speed: \(String(format: "%.0f", windSpeed))m/s", text2: "")
            ViewTemplates.weatherImageAndText(image: "humidity", text: "Humidity: \(humidity)%", text2: "")
            ViewTemplates.weatherImageAndText(image: "pressure", text: "Pressure: \(pressure) hPa", text2: "")
        }
    }
}

#Preview {
    CurrentDetailsView(icon: "02d", description: "description", feelsLike: 0.0, maxTemp: 0.0, minTemp: 0.0, windSpeed: 0.0, humidity: 0, pressure: 0)
}
