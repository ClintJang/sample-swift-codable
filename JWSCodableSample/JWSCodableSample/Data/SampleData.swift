//
//  SampleData.swift
//  JWSCodableSample
//
//  Created by Clint on 14/11/2018.
//  Copyright © 2018 clintjang. All rights reserved.
//

import Foundation

struct SampleData { }

extension SampleData {
    struct Type1 : Codable {
        let id : String
        let code : String
        let order : Int
    }
}
