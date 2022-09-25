//
//  SearchAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya

struct SearchStockAPI: ServiceAPI {
    typealias ResponseDTO = SymbolSearch
    var symbol: String
    init(symbol: String) {
        self.symbol = symbol
    }
    var serviceBaseURL: ServiceBaseURL { .twelveData }
    var path: String { "/symbol_search/\(symbol)" }
    var method: Moya.Method { .get }
    var task: Moya.Task { .requestPlain }
}
