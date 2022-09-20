//
//  SymbolSearch.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/15.
//

import Foundation

struct SearchedStock {
    let symbol: String
    let instrumentName: String
    let country: String
    let logoURLString: String
}

struct SymbolSearch: Decodable {
    let symbolSearchInfos: [SymbolSearchInfo]

    enum CodingKeys: String, CodingKey {
        case symbolSearchInfos = "data"
    }
}

struct SymbolSearchInfo: Decodable {
    let symbol: String
    let instrumentName: String
    let country: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case instrumentName = "instrument_name"
        case country
    }
}

enum InstrumentType: Decodable {
    case closedEndFund
    case commonStock
    case etf
    case preferredStock
}

struct Logo: Decodable {
    let url: String
}
