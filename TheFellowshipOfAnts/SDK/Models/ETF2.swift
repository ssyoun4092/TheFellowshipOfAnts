//
//  ETF.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/02.
//

import Foundation

struct MajorETFs2: Decodable {
    let SPY, TLT, SHY, VIX: ETFInfos
}

struct ETFInfos: Decodable {
    let basic: ETFBasic
    let details: [ETFDetail]
    let status: String

    enum CodingKeys: String, CodingKey {
        case basic = "meta"
        case details = "values"
        case status
    }
}

struct ETFBasic: Decodable {
    let symbol: String
}

struct ETFDetail: Decodable {
    let close: String
}

struct ETF2: CarouselCellType {
    var name: String
    var price: String
    var fluctuationRate: String
}

extension ETF2 {
    static let dummy: [ETF2] = [
        ETF2(name: "SPY", price: "$396.4", fluctuationRate: "-0.32%"),
        ETF2(name: "SHY", price: "$82.13", fluctuationRate: "0.19%"),
        ETF2(name: "TLT", price: "$109.59", fluctuationRate: "2.14%"),
        ETF2(name: "VIX", price: "$25.33", fluctuationRate: "2.37%")
    ]
}
