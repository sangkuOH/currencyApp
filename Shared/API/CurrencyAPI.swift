//
//  CurrencyAPI.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation
import Combine
import Alamofire

enum CurrencyAPI {
    static let apiClient = APIClient()
    static let baseURL = "http://api.currencylayer.com/live"
    static let access_key = "490790b69d158fa803331b5f511c328a"
    static let format = 1
    static var session: Session {
        return apiClient.session
    }
    
    static func getBattleTabData() -> AnyPublisher<Currency, APIError> {
        let params: Parameters = [
            "access_key": self.access_key,
            "format": self.format
        ]
        
        let request = AF.request(baseURL,
                                 method: .get,
                                 parameters: params,
                                 encoding: URLEncoding(destination: .queryString)
        )
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    }

