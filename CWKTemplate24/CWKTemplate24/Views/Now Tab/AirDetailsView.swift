//
//  AirDetailsView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 16/12/2024.
//

// extra info when press air quality buttons

import SwiftUI

struct AirDetailsView: View {
    @Environment(\.dismiss) var dismiss
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(image)
                    .cornerRadius(5)
                Text(description)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AirDetailsView(image: "so2", title: "SO\u{2082}", description: "Sulfur dioxide, a colorless gas with a sharp odor, is produced naturally and through human activities. It contributes to acid rain and poses health risks, necessitating emission control for environmental and human health.")
}
