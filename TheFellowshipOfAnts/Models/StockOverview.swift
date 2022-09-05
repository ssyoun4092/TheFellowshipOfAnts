//
//  StockOverview.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/05.
//

import Foundation

struct StockOveriview: Decodable {
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
