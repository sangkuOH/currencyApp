//
//  ViewModel.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation

class CurrencyViewModel: BaseViewModel {
    static let shared = CurrencyViewModel()
    @Published var data: Currency?
    @Published var sentUSD = ""
    

    func getData() {
        CurrencyAPI.getBattleTabData()
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished successfully")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { currency in
                print("success!")
                print(currency)
                self.data = currency
            }
            .store(in: &subscriptions)
    }
    
    func currentCurrency(_ to: Sent) -> Double {
        guard let data = data else {
            return 0
        }

        switch to {
        case .KOREA:
            return data.quotes.USDKRW
        case .PHILIPPINES:
            return data.quotes.USDPHP
        case .JAPAN:
            return data.quotes.USDJPY
        }
    }
    
    func calculatedMoney(_ to: Sent) -> Double {
        guard let data = data,
              let sentUSDDouble = Double(self.sentUSD) else {
            return 0
        }
        
        switch to {
        case .KOREA:
            return sentUSDDouble * data.quotes.USDKRW
        case .PHILIPPINES:
            return sentUSDDouble * data.quotes.USDPHP
        case .JAPAN:
            return sentUSDDouble * data.quotes.USDJPY
        }
    }
}
