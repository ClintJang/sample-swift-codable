//
//  Response.swift
//  JWSCodableSample
//
//  Created by Clint on 13/11/2018.
//  Copyright © 2018 clintjang. All rights reserved.
//

import Foundation

struct Response { }

/**
 {
     userId: 1,
     id: 1,
     title: "delectus aut autem",
     completed: false
 }
 */
extension Response {
    struct todos: Codable {
        let userId:Int
        let id:Int
        let title: String?
        let completed:Bool?
        
        let testTrash:String?
    }
}
