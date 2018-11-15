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
- 제드님 블로그
	- [Swift ) 왕초보를 위한 Codable / JSON Encoding and Decoding](https://zeddios.tistory.com/373)

# Sample Source
> 이해를 돕기위해 셈플 소스를 추가해 봤습니다.

- [SampleData.swift](https://github.com/ClintJang/sample-swift-codable/blob/master/JWSCodableSample/JWSCodableSample/Data/SampleData.swift)

```
struct SampleData { }

extension SampleData {
    struct Type1 : Codable {
        let id : String
        let code : String
        let order : Int
    }
}
```

- [SampleResponse.swift](https://github.com/ClintJang/sample-swift-codable/blob/master/JWSCodableSample/JWSCodableSample/Data/SampleResponse.swift)

```
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
	- func sampleDataType1()
	
	```
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
	```

	- func sampleRequestType1()
	
	```
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
	```
	
