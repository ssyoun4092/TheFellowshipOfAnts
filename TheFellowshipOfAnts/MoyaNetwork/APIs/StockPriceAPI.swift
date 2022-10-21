//
//  StockPriceAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

import Moya

struct StockPriceAPI: StockAPI {
    typealias ResponseDTO = DTO.StockPrice
    var symbol: String
    var timeInterval: TimeIntervalType
    init(symbol: String, timeInterval: TimeIntervalType = ._5min) {
        self.symbol = symbol
        self.timeInterval = timeInterval
    }
    var provider: APIProvider { .twelveData }
    var path: String { "/time_series" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "symbol": symbol,
            "interval": timeInterval.rawValue,
            "outputsize": timeInterval.outputSize,
            "apiKey": provider.apiKey
        ], encoding: URLEncoding.queryString)}
}
