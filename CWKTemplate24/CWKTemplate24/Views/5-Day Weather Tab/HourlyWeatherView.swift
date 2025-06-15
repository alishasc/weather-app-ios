//
//  HourlyWeatherView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// 5-Day Weather tab - hourly forecast

import SwiftUI

struct HourlyWeatherView: View {
    // MARK:  set up the @EnvironmentObject for WeatherMapPlaceViewModel
    var dateAndTime: Int
    var icon: String
    var temperature: Double
    var description: String
    var timezone: String
    
    var body: some View {
        VStack() {
            Text(DateFormatterUtils.formatHourlyWithTimezone(from: TimeInterval(dateAndTime), timezone: timezone))
                .fontWeight(.medium)
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon).png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()  // loading icon
            }
            .frame(width: 50, height: 50)
            
            Text("\(String(format: "%.0f", temperature))ºC")
            Text("\(description.capitalized)")
                .multilineTextAlignment(.center)
        }
        .frame(width: 180, height: 150)
        .background(.teal)
    }
}

#Preview {
    HourlyWeatherView(dateAndTime: 1735591958, icon: "02d", temperature: 0.0, description: "description", timezone: "Europe/London")
}
