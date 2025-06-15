//
//  ForecastWeatherView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// 5-Day Weather tab

import SwiftUI

struct ForecastWeatherView: View {
    // MARK:  set up the @EnvironmentObject for WeatherMapPlaceViewModel
    @EnvironmentObject var weatherMapPlaceViewModel: WeatherMapPlaceViewModel
    
    var body: some View {
        ZStack {
            Image("sky")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack(spacing: 20) {
                Text("Hourly Forecast Weather for \(weatherMapPlaceViewModel.newLocation)")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // hourly forecast - top frame
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(weatherMapPlaceViewModel.hourly) { hourly in
                            HourlyWeatherView(dateAndTime: hourly.dateAndTime, icon: hourly.icon, temperature: hourly.temperature ?? 0.0, description: hourly.summary, timezone: weatherMapPlaceViewModel.timezone ?? "Europe/London")
                        }
                    }
                }
                
                Text("8 Day Forecast for \(weatherMapPlaceViewModel.newLocation)")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // daily forecast
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(weatherMapPlaceViewModel.daily) { daily in
                        DailyWeatherView(icon: daily.icon, dateAndTime: daily.dateAndTime, description: daily.summary, dayTemp: daily.dayTemp ?? 0.0, nightTemp: daily.nightTemp ?? 0.0, timezone: weatherMapPlaceViewModel.timezone ?? "Europe/London")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    ForecastWeatherView()
}
