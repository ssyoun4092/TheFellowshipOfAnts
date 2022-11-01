//
//  StockIncomStatementAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/20.
//

import Foundation

import Moya

struct StockIncomeStatementAPI: StockAPI {
    typealias ResponseDTO = [DTO.StockIncomeStatement]
    var symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    var provider: APIProvider { .financialmodeling }
    var path: String { "/api/v3/income-statement/\(symbol)" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "apikey": apiKey
        ], encoding: URLEncoding.queryString)
    }
}
