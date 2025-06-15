//
//  GraphModel.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 27/12/2024.
//

import Foundation
import CoreGraphics

struct GraphModel: Identifiable {
    var id: UUID = UUID()
    let coord: CGPoint
    
    init(coord: CGPoint) {
        self.coord = coord
    }
}
