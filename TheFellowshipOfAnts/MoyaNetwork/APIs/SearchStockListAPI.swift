//
//  SearchAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya

struct SearchStockAPI: StockAPI {
    typealias ResponseDTO = DTO.SearchStocks
    var symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    var provider: APIProvider { .twelveData }
    var path: String = "/symbol_search"
    var task: Moya.Task {
        .requestParameters(parameters: [
            "symbol": symbol,
            "apiKey": apiKey
        ], encoding: URLEncoding.queryString)
    }
}
