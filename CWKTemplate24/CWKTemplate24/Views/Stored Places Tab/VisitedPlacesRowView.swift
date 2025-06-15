//
//  VisitedPlacesRowView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 08/12/2024.
//

// each row of Stored Places tab

import SwiftUI

struct VisitedPlacesRowView: View {
    var location: LocationModel
    
    var body: some View {
        HStack {
            Text(location.locationName)
            Spacer()
            Text("(\(location.latitude), \(location.longitude))")
        }
    }
}

#Preview {
    VisitedPlacesRowView(location: .init(locationName: "London", latitude: 51.5072, longitude: 0.1276))
}
