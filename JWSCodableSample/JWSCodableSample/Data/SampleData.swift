//
//  SampleData.swift
//  JWSCodableSample
//
//  Created by Clint on 14/11/2018.
//  Copyright © 2018 clintjang. All rights reserved.
//

import Foundation

struct SampleStructData01: Codable {
    let id: String
    let code: String
    let order: Int
}

struct SampleStructData02: Codable {
    let code: String
    let data: SampleStructData02SubData
    
    struct SampleStructData02SubData: Codable {
        let id : String
        let code : String
        let order : Int
    }
}

struct SampleStructData03 : Codable{
    var id : String
    var code : String
    var order : Date
    enum CodingKeys : String, CodingKey{
        case id
        case code
        case order = "order_test"
    }
}





