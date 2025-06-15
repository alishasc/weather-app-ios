//
//  AirQualityView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 05/12/2024.
//

// Now tab - current air quality info in bottom frame

import SwiftUI
import Foundation

struct AirQualityView: View {
    // sheet views with extra info
    @State private var isSO2SheetPresented = false
    @State private var isNOSheetPresented = false
    @State private var isVOCSheetPresented = false
    @State private var isPMSheetPresented = false
    var location: String
    var so2: Double
    var no: Double
    var voc: Double
    var pm: Double
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Current Air Quality in \(location)")
                .multilineTextAlignment(.center)
                .bold()
                .padding(.leading, 20)
            
            // compound images and labels
            VStack {
                HStack(spacing: 40) {
                    // so2
                    ViewTemplates.compoundButtonWithLabel(image: "so2", compoundValue: so2, isSheetPresented: $isSO2SheetPresented)
                        .sheet(isPresented: $isSO2SheetPresented) {
                            AirDetailsView(image: "so2", title: "SO\u{2082}", description: "Sulfur dioxide, a colorless gas with a sharp odor, is produced naturally and through human activities. It contributes to acid rain and poses health risks, necessitating emission control for environmental and human health.")
                                .presentationDetents([.medium])
                        }
                    // no
                    ViewTemplates.compoundButtonWithLabel(image: "no", compoundValue: no, isSheetPresented: $isNOSheetPresented)
                        .sheet(isPresented: $isNOSheetPresented) {
                            AirDetailsView(image: "no", title: "NO\u{2093}", description: "Nitrogen monoxide (NO), formed naturally and by human activities, reacts with oxygen to form nitrogen dioxide (NO₂), a key component of air pollution. NO is also vital in the body as a signaling molecule.")
                                .presentationDetents([.medium])
                        }
                    // voc
                    ViewTemplates.compoundButtonWithLabel(image: "voc", compoundValue: voc, isSheetPresented: $isVOCSheetPresented)
                        .sheet(isPresented: $isVOCSheetPresented) {
                            AirDetailsView(image: "voc", title: "VOC", description: "Volatile organic compounds (VOCs) are a group of organic chemicals that easily evaporate into the air at room temperature, contributing to air pollution. They are emitted from natural sources like plants and human activities such as vehicle emissions, industrial processes, and the use of products like paints, cleaning agents, and adhesives.")
                                .presentationDetents([.medium])
                        }
                    // pm
                    ViewTemplates.compoundButtonWithLabel(image: "pm", compoundValue: pm, isSheetPresented: $isPMSheetPresented)
                        .sheet(isPresented: $isPMSheetPresented) {
                            AirDetailsView(image: "pm", title: "PM\u{2081}\u{2080}", description: "Particulate matter (PM), originating from natural and human sources, poses health risks and environmental damage.  Reducing PM emissions is crucial for protecting public health and the environment.")
                                .presentationDetents([.medium])
                        }
                }
                .background(
                    Image("BG")
                        .resizable()
                )
            }
        }
    }
}

#Preview {
    AirQualityView(location: "London", so2: 8.70, no: 0.16, voc: 2.05, pm: 1.74)
}
