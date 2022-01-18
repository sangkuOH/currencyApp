//
//  APIClient.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation
import Combine
import Alamofire

struct EmptyAPIResponse: Codable { }

struct APIError: Codable, Error {
    var message: String
}

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    var session: Session = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.Session(configuration: configuration)
    }()
    
    func run<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, APIError> {
        return request
            .validate()
            .publishData(emptyResponseCodes: [200, 201, 204, 205])
            .tryMap { result -> Response<T> in
                if let error = result.error {
                    if let errorData = result.data {
                        print(String(describing: errorData.prettyPrintedJSONString))
                        let value = try decoder.decode(APIError.self, from: errorData)
                        throw value
                    } else {
                        throw error
                    }
                }
                if let  data = result.data {
//                    print(String(describing: data.prettyPrintedJSONString))
                    let value = try! decoder.decode(T.self, from: data)
                    return Response(value: value, response: result.response!)
                } else {
                    return Response(value: EmptyAPIResponse() as! T, response: result.response!)
                }
            }
            .mapError({ error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError(message: "unKnown Error")
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
