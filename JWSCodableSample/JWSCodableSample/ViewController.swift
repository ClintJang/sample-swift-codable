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
        
        // Struct
        sampleStructData01()
        sampleStructData02()
        sampleStructData03()
        
        // Request
        sampleRequest01()
    }
}

// MARK: - Sample Struct
extension ViewController {
    func sampleStructData01() {
        print("===============================")
        print("== \(#function)")
        
        let dataJsonString = """
        {
            "id": "test@gmail.com",
            "code": "abcdefg1234",
            "order": 1
        }
        """.data(using: .utf8)!
        
        let sample = try! JSONDecoder().decode(SampleStructData01.self, from: dataJsonString)
        print(sample)
        print("===============================\n\n")
    }

    func sampleStructData02() {
        print("===============================")
        print("== \(#function)")
        
        let dataJsonString = """
        {
            "code": "poiuytrewq",
            "data": {
                "id": "test@gmail.com",
                "code": "abcdefg1234",
                "order": 1
            }
        }
        """.data(using: .utf8)!
        
        let sample = try! JSONDecoder().decode(SampleStructData02.self, from: dataJsonString)
        print(sample)
        print("===============================\n\n")
    }
    
    func sampleStructData03() {
        print("===============================")
        print("== \(#function)")
        
        let dataJsonString = """
        {
            "id": "test@gmail.com",
            "code": "abcdefg1234",
            "order_test": 1
        }
        """.data(using: .utf8)!
        
        let sample = try! JSONDecoder().decode(SampleStructData03.self, from: dataJsonString)
        print(sample)
        print("===============================\n\n")
    }
}

// MARK: - Sample enum
extension ViewController {
    
}

// MARK: - Sample Request
extension ViewController {
    func sampleRequest01(){
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

