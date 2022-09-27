//
//  LogoAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/26.
//

import Foundation

import Moya

struct LogoAPI: StockAPI {
    typealias ResponseDTO = DTO.Logo
    var symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    var apiProvider: APIProvider { .twelveData }
    var path: String { "/logo" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "symbol": symbol,
            "apikey": apiKey
        ], encoding: URLEncoding.queryString)
    }
}
