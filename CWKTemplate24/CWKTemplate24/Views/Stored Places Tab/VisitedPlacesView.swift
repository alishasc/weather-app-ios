//
//  VisitedPlacesView.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

// Stored Placed on nav bar - locations and coords saved in database

import SwiftUI
import SwiftData

struct VisitedPlacesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var locations: [LocationModel]
    
    var body: some View {
        ZStack {
            Image("sky")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack(spacing: 30) {
                Text("Weather Locations in Database")
                    .multilineTextAlignment(.center)
                    .bold()
                
                List {
                    ForEach(locations) { location in
                        VisitedPlacesRowView(location: location)
                            .swipeActions {
                                Button(role: .destructive) {
                                    // delete from database
                                    modelContext.delete(location)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        Text("")
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
            .padding()
        }
    }
}

//#Preview {
//    VisitedPlacesView()
//}
