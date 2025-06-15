//
//  WeatherMapPlaceViewModel.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

import Foundation
import CoreLocation
import MapKit
import SwiftData

@MainActor
class WeatherMapPlaceViewModel: ObservableObject {
    private var openWeatherAPIKey: String = "YOUR_OPEN_WEATHER_API_KEY_HERE"
    
    // MARK:   published variables section - add variables that you need here and note that default location must be London
    // data models
    @Published var timezone: String?
    @Published var current: WeatherDataModel?
    @Published var hourly: [WeatherDataModel] = []
    @Published var daily: [WeatherDataModel] = []
    @Published var airQuality: AirDataModel?
    // when decoding from API
    @Published var errorBool: Bool = false
    @Published var errorMessage: String = ""
    // getCoordinatesForCity()
    private var initialLoad: Bool = true  // flag for if app is running for first time
    private var oldLocation = ""  // before new search
    @Published var newLocation = "London"  // updates after using textfield
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var alertMessage = ""
    // setAnnotations()
    @Published var mapMarkers: [MKMapItem] = []  // points of interest on the map
    // setGraphPlots()
    @Published var graphPlots: [GraphModel] = []
    
    // MARK:  function to get coordinates safely for a place:
    func getCoordinatesForCity(locations: [LocationModel], modelContext: ModelContext) async throws {
        let geoCoder = CLGeocoder()
        
        // check if in database
        if let existingLocation = locations.first(where: { $0.locationName == newLocation }) {
            // update region lat/lon for setAnnotations() to work
            region.center.latitude = existingLocation.latitude
            region.center.longitude = existingLocation.longitude
            
            // fetch new API data
            try await fetchWeather(lat: existingLocation.latitude, lon: existingLocation.longitude)
            try await fetchAirQuality(lat: existingLocation.latitude, lon: existingLocation.longitude)
            try await setAnnotations()
            
            oldLocation = newLocation  // update oldLocation to latest search
            alertMessage = "\(newLocation) loaded from database"
        }
        // not found in database
        else if let placemarks = try? await geoCoder.geocodeAddressString(newLocation),
                let location = placemarks.first?.location?.coordinate {
            self.coordinates = location
            self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            // don't load default location to database on initial launch
            if initialLoad == false {
                // add to database
                let locationModel = LocationModel(locationName: newLocation, latitude: region.center.latitude, longitude: region.center.longitude)
                modelContext.insert(locationModel)
            }
            
            // refresh data and UI
            try await fetchWeather(lat: region.center.latitude, lon: region.center.longitude)
            try await fetchAirQuality(lat: region.center.latitude, lon: region.center.longitude)
            try await setAnnotations()
            
            oldLocation = newLocation
            initialLoad = false  // change to false after run app first time
            alertMessage = "\(newLocation) added to database"
        } else {
            // invalid input - revert back to location before last search
            alertMessage = "Invalid location: \(newLocation)"
            newLocation = oldLocation
            print("Error: Unable to find coordinates - getCoordinatesForCity()")
        }
    }
    
    // MARK:  function to fetch weather data safely from openweather using location coordinates
    func fetchWeather(lat: Double, lon: Double) async throws {
        guard let weatherUrl = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(openWeatherAPIKey)") else {
            fatalError("Invalid weather URL")
        }
        
        // check HTTP response and decode data from API
        do {
            // returns tuple
            let (data, response) = try await URLSession.shared.data(from: weatherUrl)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
                        
            // 200 = response was successful
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                
                // decode and update UI
                do {
                    // decode weather data
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    self.current = weatherResponse.current
                    self.hourly = weatherResponse.hourly
                    self.daily = weatherResponse.daily
                    self.timezone = weatherResponse.timezone
                    
                    self.errorBool = false
                    self.errorMessage = ""
                } catch {
                    // if can't decode weather
                    print("Error decoding JSON: \(error.localizedDescription)")
                    self.errorBool = true
                    self.errorMessage = "Failed to load weather data."
                }
            } else {
                // if http code != 200
                print("Error: HTTP \(httpResponse.statusCode)")
                self.errorBool = true
                self.errorMessage = "City not found or server error. Status code: \(httpResponse.statusCode)"
            }
        } catch {
            print("Network or decoding error: \(error.localizedDescription)")
            self.errorBool = true
            self.errorMessage = "Failed to fetch weather data."
        }
    }
    
    func fetchAirQuality(lat: Double, lon: Double) async throws {
        guard let airQualityUrl = URL(string: "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&units=metric&appid=\(openWeatherAPIKey)") else {
            fatalError("Invalid weather URL")
        }
        
        do {
            // returns tuple
            let (data, response) = try await URLSession.shared.data(from: airQualityUrl)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
                        
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                
                // decode data and update UI
                do {
                    let airData = try decoder.decode(AirDataModel.self, from: data)
                    self.airQuality = airData
                    
                    self.errorBool = false
                    self.errorMessage = ""
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    self.errorBool = true
                    self.errorMessage = "Failed to load air quality data."
                }
            } else {
                print("Error: HTTP \(httpResponse.statusCode)")
                self.errorBool = true
                self.errorMessage = "Air quality data not found or server error."
            }
        } catch {
            print("Network or decoding error: \(error.localizedDescription)")
            self.errorBool = true
            self.errorMessage = "Unable to fetch air quality data."
        }
        
        try await setGraphPlots()
    }
    
    // MARK:  function to get tourist places safely for a map region and store for use in showing them on a map
    func setAnnotations() async throws {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "tourist attractions"
        request.region = region
        
        let search = MKLocalSearch(request: request)
        if let response = try? await search.start() {
            let items = response.mapItems
            
            // reset array for new search
            self.mapMarkers = []
            
            for item in items {
                // only add 5 places to array
                if self.mapMarkers.count < 5 {
                    self.mapMarkers.append(item)
                } else {
                    break
                }
            }
        }
    }
    
    func setGraphPlots() async throws {
        if let airQuality = airQuality {
            let data = [airQuality.so2, airQuality.no, airQuality.pm2_5, airQuality.pm10]
            
            if let max = data.max(),
               let min = data.min() {
                // normalization formula - make between 0 and 1
                let normalizedData = data.map { ($0 - min) / (max - min) }
                
                let so2Plot = GraphModel(coord: CGPoint(x: 0.0, y: normalizedData[0]))
                let noPlot = GraphModel(coord: CGPoint(x: 0.33, y: normalizedData[1]))
                let vocPlot = GraphModel(coord: CGPoint(x: 0.67, y: normalizedData[2]))
                let pm10Plot = GraphModel(coord: CGPoint(x: 1.0, y: normalizedData[3]))
                
                graphPlots = [so2Plot, noPlot, vocPlot, pm10Plot]
            }
        }
    }
}
