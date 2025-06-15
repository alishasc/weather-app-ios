//
//  MapView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// Place Map on nav bar

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    // MARK:  set up the @EnvironmentObject for WeatherMapPlaceViewModel
    @EnvironmentObject var weatherMapPlaceViewModel: WeatherMapPlaceViewModel
    @State private var position: MapCameraPosition = .automatic  // show all markers in frame
    
    var body: some View {
        ZStack {
            Image("sky")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack {
                if weatherMapPlaceViewModel.coordinates != nil {
                    Map(position: $position) {
                        ForEach(weatherMapPlaceViewModel.mapMarkers, id: \.self) { place in
                            Marker(item: place)
                        }
                    }
                    .frame(height: 300)
                    .onChange(of: weatherMapPlaceViewModel.mapMarkers) {
                        position = .automatic
                    }
                    
                    Text("Top 5 Tourist Attractions in \(weatherMapPlaceViewModel.newLocation)")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    // tourist attraction name/address
                    List {
                        ForEach(weatherMapPlaceViewModel.mapMarkers, id: \.self) { place in
                            MapListView(placeName: place.name, address: place.placemark.title)
                        }
                        .listRowBackground(Color.clear)
                    }
                    .padding(.horizontal)
                    .listStyle(.plain)
                }
            }
        }
    }
}

//#Preview {
//    MapView()
//}
