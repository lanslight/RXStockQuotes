//
//  QuotationModel.swift
//  RxStockQuotes
//
//  Created by Vladimir Svetlanov on 07/11/2018.
//  Copyright © 2018 Vladimir Svetlanov. All rights reserved.
//

import Foundation

struct QuotationModel {
    let id: Int
    let name: String
    let last: Double
    let lowestAsk: Double
    let highestBid: Double
    let percentChange: Double
    let baseVolume: Double
    let quoteVolume: Double
    let isFrozen: Bool
    let high24Hr: Double
    let low24Hr: Double
}

extension QuotationModel {
    init?(id: Int,
        name: String,
        last: String,
        lowestAsk: String,
        highestBid: String,
        percentChange: String,
        baseVolume: String,
        quoteVolume: String,
        isFrozen: String,
        high24Hr: String,
        low24Hr: String) {
        guard let last = Double(last),
            let lowestAsk = Double(lowestAsk),
            let highestBid = Double(highestBid),
            let percentChange = Double(percentChange),
            let baseVolume = Double(baseVolume),
            let quoteVolume = Double(quoteVolume),
            let isFrozenInt = Int(isFrozen),
            let high24Hr = Double(high24Hr),
            let low24Hr = Double(low24Hr) else { return nil }
        
        self.id = id
        self.name = name
        self.last = last
        self.lowestAsk = lowestAsk
        self.highestBid = highestBid
        self.percentChange = percentChange
        self.baseVolume = baseVolume
        self.quoteVolume = quoteVolume
        self.isFrozen = isFrozenInt == 1
        self.high24Hr = high24Hr
        self.low24Hr = low24Hr
    }
}
