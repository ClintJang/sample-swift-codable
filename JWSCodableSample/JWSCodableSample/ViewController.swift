//
//  ViewController.swift
//  JWSCodableSample
//
//  Created by Clint on 13/11/2018.
//  Copyright © 2018 clintjang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleDataType1()
        
        sampleRequestType1()
    }

    func sampleDataType1() {
        print("===============================")
        print("== \(#function)")
        
        let dataType1 = """
        {
            "id": "test@gmail.com",
            "code": "abcdefg1234",
            "order": 1
        }
        """.data(using: .utf8)!
        
        let sample = try! JSONDecoder().decode(SampleData.Type1.self, from: dataType1)
        print(sample)
        print("===============================\n\n")
    }

    func sampleRequestType1(){
        print("===============================")
        print("== \(#function)")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let error = error {
                print("== \(error)")
            } else {
                print("== success")
                
                guard let data = data else {
                    return
                }
                
                do {
                    let codableStruct = try JSONDecoder().decode(SampleResponse.todos.self, from: data)
                    print("\(codableStruct)")
                    print("== id : \(codableStruct.id)")
                } catch {
                    print("== err in codable")
                }
                
                print("===============================\n\n")
            }
        }).resume()
    }
}

