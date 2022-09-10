//
//  StockOverview.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/05.
//

import Foundation

struct StockOverview: Decodable {

    let marketCap: String
    let PER: String
    let PBR: String
    let EPS: String
    let highIn52Weeks: String
    let lowIn52Weeks: String

    enum CodingKeys: String, CodingKey {
        case marketCap = "MarketCapitalization"
        case PER = "PERatio"
        case PBR = "BookValue"
        case highIn52Weeks = "52WeekHigh"
        case lowIn52Weeks = "52WeekLow"
        case EPS
    }
}

extension StockOverview {
    static let dummy = StockOverview(
        marketCap: "2506402038000",
        PER: "25.78",
        PBR: "3.61",
        EPS: "6.05",
        highIn52Weeks: "182.19",
        lowIn52Weeks: "128.86"
    )
}
