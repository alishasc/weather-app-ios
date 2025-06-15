//
//  NavBarView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

import SwiftUI
import SwiftData

struct NavBarView: View {
    // MARK:  Variable section - set up variable to use WeatherMapPlaceViewModel and SwiftData
    @EnvironmentObject var weatherMapPlaceViewModel: WeatherMapPlaceViewModel
    @Environment(\.modelContext) var modelContext
    @Query var locations: [LocationModel]
    @State private var newLocation: String = ""  // textfield input
    @State private var showAlert: Bool = false
    
    // MARK:  Configure the look of tab bar
    init() {
        // Customize TabView appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        VStack {
            // textfield and grey cloud bg
            VStack {
                // MARK:  Add view(s) that are common to all tabbed views e.g. - images, textfields, etc
                Image("BG")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, maxHeight: 5)
                
                // textfield and label
                HStack {
                    Text("Change Location")
                    TextField("Enter New Location", text: $newLocation)
                        .frame(width: 200)  // stop textfield width changing
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.words)  // capitalise each word entered
                        .onSubmit {
                            Task {
                                do {
                                    try await weatherMapPlaceViewModel.getCoordinatesForCity(locations: locations, modelContext: modelContext)
                                    
                                    showAlert = true
                                    newLocation = ""  // reset textfield
                                } catch {
                                    print("Error handling input: \(error)")
                                }
                            }
                            
                            // update newLocation in UI
                            weatherMapPlaceViewModel.newLocation = newLocation
                        }
                        // changes depending on if location invalid/loaded from db/added to db - viewModel var
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Alert"),
                                message: Text(weatherMapPlaceViewModel.alertMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
            }
            
            TabView {
                CurrentWeatherView()
                    .tabItem {
                        Label("Now", systemImage:  "sun.max.fill")
                    }
                ForecastWeatherView()
                    .tabItem {
                        Label("5-Day Weather", systemImage: "calendar")
                    }
                MapView()
                    .tabItem {
                        Label("Place Map", systemImage: "map")
                    }
                VisitedPlacesView()
                    .tabItem {
                        Label("Stored Places", systemImage: "globe")
                    }
            }
            .onAppear {
                // MARK:  Write code to manage what happens when this view appears
                Task {
                    try await weatherMapPlaceViewModel.getCoordinatesForCity(locations: locations, modelContext: modelContext)  // load data for default location - London
                }
            }
        }
    }
}

//#Preview {
//    NavBarView()
//}
