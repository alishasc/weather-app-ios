//
//  LocationModel.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

import Foundation
import SwiftData

// MARK:   LocationModel class to be used with SwiftData - database to store places information
@Model
class LocationModel: Identifiable {
    // MARK:  list of attributes to manage locations
    @Attribute(.unique) var locationName: String  // no duplicate locations
    var latitude: Double
    var longitude: Double
    
    init(locationName: String, latitude: Double, longitude: Double) {
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }
}
