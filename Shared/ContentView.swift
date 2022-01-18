//
//  ContentView.swift
//  Shared
//
//  Created by 오상구 on 2022/01/18.
//

import SwiftUI
import AlamofireNetworkActivityLogger

enum Sent: CaseIterable {
    
    case KOREA
    case PHILIPPINES
    case JAPAN
    
    var nation: String {
        switch self {
        case .KOREA:
            return "한국"
        case .PHILIPPINES:
            return "필리핀"
        case .JAPAN:
            return "일본"
        }
    }
    var currency: String {
        switch self {
        case .KOREA:
            return "KRW"
        case .PHILIPPINES:
            return "PHP"
        case .JAPAN:
            return "JPY"
        }
    }
    
}
struct ContentView: View {
    
    @StateObject var viewModel = CurrencyViewModel.shared
    @State var sentTo: Sent = .KOREA
    
    init() {
        NetworkActivityLogger.shared.startLogging()
    }
    
    var body: some View {
        NavigationView {
            if viewModel.data == nil {
                ProgressView()
            } else {
                List {
                    Section {
                        VStack(alignment: .leading) {
                            Text("송금국가: 미국(USD)")
                            HStack {
                                Text("수취국가:")
                                Picker(selection: $sentTo) {
                                    ForEach(Sent.allCases, id: \.self) { item in
                                        Text("\(item.nation)(\(item.currency))")
                                    }
                                } label: {
                                    Text("Currency")
                                }
                                .pickerStyle(.menu)
                            }
                        }
                    } header: {
                        Text("Transfer")
                    }
                    
                    Section {
                        Text("\(viewModel.currentCurrency(self.sentTo).formattingDouleValue)(\(self.sentTo.currency))")
                    } header: {
                        Text("환율")
                    }
                    Section {
                        TextField("USD", text: $viewModel.sentUSD)
                            .keyboardType(.numberPad)
                    } header: {
                        Text("송금액")
                    }
                    
                    Section {
                        Text("\(viewModel.calculatedMoney(self.sentTo).formattingDouleValue) \(self.sentTo.currency)")
                    } header: {
                        Text("수취금액")
                    }
                }
                .navigationTitle(Text("Currency"))
            }
            
        }
        .onAppear {
            viewModel.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
