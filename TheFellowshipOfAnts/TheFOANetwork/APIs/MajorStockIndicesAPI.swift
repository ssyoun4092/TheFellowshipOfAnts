//
//  MajorStockIndicesAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/01.
//

import Foundation

import Moya

struct MajorStockIndicesAPI: ServiceAPI {
    typealias ResponseDTO = DTO.MajorStockIndices
    var indicesSymbol: [String]
    var timeInterval: TimeIntervalType
    init(indicesSymbol: [String], timeInterval: TimeIntervalType) {
        self.indicesSymbol = indicesSymbol
        self.timeInterval = timeInterval
    }
    var provider: APIProvider { .twelveData }
    var path: String { "/time_series" }
    var symbolStrings: String { indicesSymbol.map { $0 }.joined(separator: ", ") }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "symbol": symbolStrings,
            "interval": timeInterval.rawValue,
            "outputsize": timeInterval.outputSize,
            "apikey": provider.apiKey
        ], encoding: URLEncoding.queryString)
    }
}

enum TimeIntervalType: String {
    case _1min = "1min"
    case _5min = "5min"
    case _15min = "15min"
    case _30min = "30min"
    case _45min = "45min"
    case _1h = "1h"
    case _2h = "2h"
    case _4h = "4h"
    case _8h = "8h"
    case _1day = "1day"
    case _1week = "1week"
    case _1month = "1month"

    var outputSize: String {
        switch self {
        case . _1min: return "270"
        case ._5min: return "54"
        case ._15min: return "28"
        case ._30min: return "14"
        case ._45min: return "10"
        default: return ""
        }
    }
}
