//
//  AirDataButtons.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 17/12/2024.
//

import SwiftUI

class ViewTemplates {
    static func compoundButtonWithLabel(image: String, compoundValue: Double, isSheetPresented: Binding<Bool>) -> some View {
        Button(action: {
            // wrappedValue = access and modify actual value of @Binding property
            isSheetPresented.wrappedValue = true
        }) {
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 70, height: 70)
                Text("\(String(format: "%.2f", compoundValue))")
                    .foregroundStyle(.black)
            }
        }
    }
    
    static func weatherImageAndText(image: String, text: String, text2: String) -> some View {
        HStack(spacing: 50) {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
            Text(text)
                .font(.title3)
            if text2 != "" {
                Text(text2)
                    .font(.title3)
            }
        }
    }
}
