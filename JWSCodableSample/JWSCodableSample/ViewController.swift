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
        
        requestSample()
    }


    func requestSample(){
        print("\(#function)")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let error = error {
                print("\(error)")
            } else {
                print("success")
                
                guard let data = data else {
                    return
                }
                
                do {
                    let codableStruct = try JSONDecoder().decode(Response.todos.self, from: data)
                    print(codableStruct)
                    print("id : \(codableStruct.id)")
                } catch {
                    print("err in codable")
                }
            }
        }).resume()
    }
}

