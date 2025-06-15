//
//  AirDataModel.swift
//  CWKTemplate24
//
//  Created by girish lukka on 23/10/2024.
//

/* Code for AirDataModel Struct */

import Foundation

struct AirDataModel: Decodable, Identifiable {
    var id: UUID = UUID()
    let so2: Double
    let no: Double
    let pm2_5: Double  // for voc
    let pm10: Double
    
    enum CodingKeys: String, CodingKey {
        case list  // array
        case components  // object
        case so2, no, pm2_5, pm10
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // go in list array
        var listArray = try container.nestedUnkeyedContainer(forKey: .list)
        let list = try listArray.nestedContainer(keyedBy: CodingKeys.self)
        
        // go in components container
        let componentsContainer = try list.nestedContainer(keyedBy: CodingKeys.self, forKey: .components)
        so2 = try componentsContainer.decode(Double.self, forKey: .so2)
        no = try componentsContainer.decode(Double.self, forKey: .no)
        pm2_5 = try componentsContainer.decode(Double.self, forKey: .pm2_5)
        pm10 = try componentsContainer.decode(Double.self, forKey: .pm10)
    }
}
