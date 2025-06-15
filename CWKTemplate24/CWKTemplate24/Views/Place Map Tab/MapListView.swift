//
//  MapListView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 04/01/2025.
//

// tourist attractions list

import SwiftUI
import MapKit

struct MapListView: View {
    var placeName: String?
    var address: String?
    
    var body: some View {
        HStack(spacing: 20) {
            // pin and place names            
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 35))
                .foregroundStyle(.red)
            VStack(alignment: .leading) {
                Text(placeName ?? "Unknown Place")
                    .fontWeight(.medium)
                Text(address ?? "Unknown Address")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    MapListView()
}
