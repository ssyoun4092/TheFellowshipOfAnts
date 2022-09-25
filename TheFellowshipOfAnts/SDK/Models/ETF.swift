//
//  ETF.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/02.
//

import Foundation

struct MajorETFs: Decodable {
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

struct ETF: CarouselCellType {
    var name: String
    var price: String
    var fluctuationRate: String
}

extension ETF {
    static let dummy: [ETF] = [
        ETF(name: "SPY", price: "$396.4", fluctuationRate: "-0.32%"),
        ETF(name: "SHY", price: "$82.13", fluctuationRate: "0.19%"),
        ETF(name: "TLT", price: "$109.59", fluctuationRate: "2.14%"),
        ETF(name: "VIX", price: "$25.33", fluctuationRate: "2.37%")
    ]
}
