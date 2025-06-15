//
//  CurrentWeatherView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// Now tab

import SwiftUI

struct CurrentWeatherView: View {
    // MARK:  set up the @EnvironmentObject for WeatherMapPlaceViewModel
    @EnvironmentObject var weatherMapPlaceViewModel: WeatherMapPlaceViewModel
    
    // MARK:  set up local @State variable to support this view
    @State private var showGraph = false
    
    var body: some View {
        if let current = weatherMapPlaceViewModel.current,
           let daily = weatherMapPlaceViewModel.daily.first,
           let timezone = weatherMapPlaceViewModel.timezone {
            ZStack {
                Image("sky")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.5)
                
                ScrollViewReader { scrollView in
                    ScrollView(.vertical) {
                        VStack(spacing: 25) {
                            // title
                            Text(weatherMapPlaceViewModel.newLocation)
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .fontWeight(.medium)
                            
                            Text(DateFormatterUtils.formattedDateWithTimezone(from: TimeInterval(current.dateAndTime), timezone: timezone))
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            // images with current weather info
                            CurrentDetailsView(icon: current.icon, description: current.summary, feelsLike: current.feelsLike ?? 0.0, maxTemp: daily.maxTemp ?? 0.0, minTemp: daily.minTemp ?? 0.0, windSpeed: current.windSpeed, humidity: current.humidity, pressure: current.pressure)
                            
                            Spacer()
                            
                            // air quality info
                            if let airQuality = weatherMapPlaceViewModel.airQuality {
                                AirQualityView(location: weatherMapPlaceViewModel.newLocation, so2: airQuality.so2, no: airQuality.no, voc: airQuality.pm2_5, pm: airQuality.pm10)
                            }
                            
                            // graph
                            Button {
                                showGraph.toggle()
                            } label: {
                                Label("Graph", systemImage: "chart.xyaxis.line")
                            }
                            
                            if showGraph {
                                GraphView(graphPlots: weatherMapPlaceViewModel.graphPlots)
                                    .id("graph")
                                    .onAppear {
                                        withAnimation {
                                            // scroll to bottom of page
                                            scrollView.scrollTo("graph", anchor: .bottom)
                                        }
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

//#Preview {
//    CurrentWeatherView()
//}
