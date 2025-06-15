//
//  DailyWeatherView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// 5-Day Weather tab - daily forecast

import SwiftUI

struct DailyWeatherView: View {
    var icon: String
    var dateAndTime: Int
    var description: String
    var dayTemp: Double
    var nightTemp: Double
    var timezone: String
    
    var body: some View {
        HStack {
            // icon
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon).png")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()  // loading icon
            }
            .frame(width: 80, height: 80)
            
            Spacer()
            
            // date and description
            VStack {
                Text(DateFormatterUtils.formatDailyWithTimezone(from: TimeInterval(dateAndTime), timezone: timezone))
                    .fontWeight(.medium)
                Text("\(description.capitalized)")
            }
            
            Spacer()
            
            // day temperature
            VStack {
                Text("Day")
                    .fontWeight(.medium)
                Text("\(String(format: "%.0f", dayTemp))ºC")
            }
            
            // night temperature
            VStack {
                Text("Night")
                    .fontWeight(.medium)
                Text("\(String(format: "%.0f", nightTemp))ºC")
            }
        }
        .padding(.horizontal)  // inside row
        .background(
            Rectangle()
                .foregroundStyle(.gray)
                .cornerRadius(10)
                .opacity(0.10)
        )
    }
}

#Preview {
    DailyWeatherView(icon: "10d", dateAndTime: 1733396400, description: "Light Rain", dayTemp: 16, nightTemp: 12, timezone: "Europe/London")
}
