//
//  StockOverviewAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya

struct StockOverviewAPI: StockAPI {
    typealias ResponseDTO = DTO.StockOverview
    var symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    var serviceProvider: ServiceProvider { .alphavantage }
    var path: String { "/query" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "function": "OVERVIEW",
            "symbol": symbol,
            "apikey": apiKey
        ], encoding: URLEncoding.queryString)
    }
}
