//
//  MarsProperty.swift
//  Mars Real Estate
//
//  Created by Levent YADIRGA on 3.08.2021.
//

import Foundation
//MODEL
struct MarsProperty: Identifiable, Decodable  {
    let id: String
    let imgSrcUrl: String
    let type: String
    let price: Double
    var isRental: Bool {type == "rent"}
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case imgSrcUrl = "img_src"
        case type = "type"
        case price = "price"
     }
}
