# Sample Swift Codable
Swift Codable Sample 입니다.

# Codable
- Swift4에서 Codable이라는 프로토콜이 추가되었습니다. 
	- Swift Standard Library
	- Xcode 9.0+
- https://developer.apple.com/documentation/swift/codable

```
Type Alias

Codable
A type that can convert itself into and out of an external representation.

Declaration
typealias Codable = Decodable & Encodable

Discussion
Codable is a type alias for the Encodable and Decodable protocols. When you use Codable as a type or a generic constraint, it matches any type that conforms to both protocols.
```

이라 설명이 되어있습니다.

```
Codable 은 Type Alias 입니다.

Codable
외부 표현으로 변환하거나 외부 표현으로 변환할 수 있는 유형입니다.

선언
typealias Codable = Decodable & Encodable

Discussion
Codable은 Encodable 및 Decodable 프로토콜의 typealias입니다.
Codable을 사용하면 두 프로토콜을 모두 준수해야 되지요.
```

통상 사용할 때는 디코딩을 할때 사용하는 것 같습니다.

## 설명이 잘 되어있는 링크
- 민소네님 블로그
	- [Codable, 현실의 Codable 그리고 Extension](http://minsone.github.io/programming/swift-codable-and-exceptions-extension)
- 제드님 블로그
	- [Swift ) 왕초보를 위한 Codable / JSON Encoding and Decoding](https://zeddios.tistory.com/373)


# Sample Source
> 이해를 돕기위해 셈플 소스를 추가해 봤습니다.

- [SampleData.swift](https://github.com/ClintJang/sample-swift-codable/blob/master/JWSCodableSample/JWSCodableSample/Data/SampleData.swift)

```swift
struct SampleStructData01: Codable {
    let id: String
    let code: String
    var order: Int?
    var test: Int?
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

struct SampleStructData03 : Codable {
    let id : String
    var code : String?
    var order : Int
    enum CodingKeys : String, CodingKey{
        case id
        case code
        case order = "order_test"
    }
}

struct SampleStructData04 : Codable {
    let id : String
    let code : String
    let order : Int
}

/// https://github.com/yonaskolb/Codability
struct SampleAnyCodableData01 : Codable {
    let id : AnyCodable
    let code : String
}
```

- [SampleResponse.swift](https://github.com/ClintJang/sample-swift-codable/blob/master/JWSCodableSample/JWSCodableSample/Data/SampleResponse.swift)

```swift
struct SampleResponse { }

/**
 {
     userId: 1,
     id: 1,
     title: "delectus aut autem",
     completed: false
 }
 */
extension SampleResponse {
    struct todos: Codable {
        let userId:Int
        let id:Int
        let title: String?
        let completed:Bool?
        
        let testTrash:String?
    }
}

```

- [ViewController.swift](https://github.com/ClintJang/sample-swift-codable/blob/master/JWSCodableSample/JWSCodableSample/ViewController.swift)
	- func sampleStructData01()
	
	```swift
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
	```
    
    - func sampleStructData02()
    
    ```swift
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
    ```
    
    - func sampleStructData03()
    
    ```swift
    func sampleStructData02() {
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
    ```
   
   - func sampleStructData04()
    
    ```swift
    func sampleStructData02() {
        print("===============================")
        print("== \(#function)")
        
        let dataJsonString = """
        [
            {
                "id": "aaaa@gmail.com",
                "code": "1234567890",
                "order": 1
            },
            {
                "id": "bbbb@gmail.com",
                "code": "abcdefghijklmn",
                "order": 2
            }
        ]
        """.data(using: .utf8)!
        
        do {
            let sample = try JSONDecoder().decode([SampleStructData04].self, from: dataJsonString)
            print(sample)
        } catch {
            print(error)
        }
        
        print("===============================\n\n")
    }
    ```

	- func sampleAnyCodableData01()
		- Codable을 사용하면서 Any 타입이 필요할 때.. 쉽지 않습니다. 그래서 라이브러리를 하나 사용해 봤습니다.
		- https://github.com/yonaskolb/Codability
	```
	func sampleAnyCodableData01() {
        print("===============================")
        print("== \(#function)")
        
        let dataJsonString = """
        [
            {
                "id": "aaaa@gmail.com",
                "code": "1234567890",
            },
            {
                "id": 1234,
                "code": "abcdefghijklmn",
            }
        ]
        """.data(using: .utf8)!
        
        do {
            let samples = try JSONDecoder().decode([SampleAnyCodableData01].self, from: dataJsonString)
            //
            _ = samples.enumerated().map { sample -> String in
                if sample.element.id.value is String {
                    print("index \(sample.offset) : id.value is String")
                } else if sample.element.id.value is Int {
                    print("index \(sample.offset) : id.value is Int")
                } else {
                    print("index \(sample.offset) : id.value is ?")
                }
                return ""
            }
            print(samples)
        } catch {
            print(error)
        }
        
        print("===============================\n\n")
    }
	```
	
	- func sampleRequest01()
	
	```swift
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
	```
	
## Result Log

```
===============================
== sampleStructData01()
SampleStructData01(id: "test@gmail.com", code: "abcdefg1234", order: Optional(1), test: nil)
===============================


===============================
== sampleStructData02()
SampleStructData02(code: "poiuytrewq", data: JWSCodableSample.SampleStructData02.SampleStructData02SubData(id: "test@gmail.com", code: "abcdefg1234", order: 1))
===============================


===============================
== sampleStructData03()
SampleStructData03(id: "test@gmail.com", code: Optional("abcdefg1234"), order: 1)
===============================


===============================
== sampleStructData04()
[JWSCodableSample.SampleStructData04(id: "aaaa@gmail.com", code: "1234567890", order: 1), JWSCodableSample.SampleStructData04(id: "bbbb@gmail.com", code: "abcdefghijklmn", order: 2)]
===============================


===============================
== sampleRequest01()
== success
todos(userId: 1, id: 1, title: Optional("delectus aut autem"), completed: Optional(false), testTrash: nil)
== id : 1
===============================
```
	
