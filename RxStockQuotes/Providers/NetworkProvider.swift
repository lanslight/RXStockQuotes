//
//  NetworkProvider.swift
//  RxStockQuotes
//
//  Created by Vladimir Svetlanov on 07/11/2018.
//  Copyright © 2018 Vladimir Svetlanov. All rights reserved.
//

import Foundation
import RxSwift

class NetworkProvider {
    
    enum NetworkError: Error {
        case noData
    }
    
    func getQuotations() -> Observable<[QuotationModel]>? {
        guard let baseUrl = URL(string: "https://poloniex.com/public") else { return nil }
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [URLQueryItem(name: "command", value: "returnTicker")]
        guard let url = urlComponents?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return Observable<[QuotationModel]>.create({ (observer) -> Disposable in
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let responseModels = try JSONDecoder().decode([String: QuotationResponse].self, from: data)
                        let models = responseModels.compactMap({
                            return QuotationModel(id: $0.value.id,
                                                  name: $0.key,
                                                  last: $0.value.last,
                                                  lowestAsk: $0.value.lowestAsk,
                                                  highestBid: $0.value.highestBid,
                                                  percentChange: $0.value.percentChange,
                                                  baseVolume: $0.value.baseVolume,
                                                  quoteVolume: $0.value.quoteVolume,
                                                  isFrozen: $0.value.isFrozen,
                                                  high24Hr: $0.value.high24Hr,
                                                  low24Hr: $0.value.low24Hr)
                        })
                        observer.onNext(models)
                    } catch {
                        observer.onError(error)
                    }
                } else {
                    observer.onError(NetworkError.noData)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create(with: {
                task.cancel()
            })
        })
    }
    
}
