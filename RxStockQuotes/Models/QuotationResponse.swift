//
//  QuotationResponse.swift
//  RxStockQuotes
//
//  Created by Vladimir Svetlanov on 07/11/2018.
//  Copyright © 2018 Vladimir Svetlanov. All rights reserved.
//

import Foundation

struct QuotationResponse: Codable {
    let id: Int
    let last: String
    let lowestAsk: String
    let highestBid: String
    let percentChange: String
    let baseVolume: String
    let quoteVolume: String
    let isFrozen: String
    let high24Hr: String
    let low24Hr: String
    
    enum CodingKeys: String, CodingKey {
        case id, last, lowestAsk, highestBid, percentChange, baseVolume, quoteVolume, isFrozen
        case high24Hr = "high24hr"
        case low24Hr = "low24hr"
    }
    
    
}
