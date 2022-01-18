//
//  BaseViewModel.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation
import Combine

public class BaseViewModel: NSObject, ObservableObject {

    internal var subscriptions = Set<AnyCancellable>()
    
    deinit {
        subscriptions.forEach { subscription in
            subscription.cancel()
        }
    }
}

