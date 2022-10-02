//
//  MajorETFsAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/02.
//

import Foundation

import Moya

struct MajorETFsAPI: ServiceAPI {
    typealias ResponseDTO = DTO.MajorETFs
    var provider: APIProvider { .twelveData }
    var path: String { "/time_series" }
    var task: Moya.Task {
        .requestParameters(parameters: [
            "symbol": "SPY, TLT, SHY, VIX",
            "interval": "5min",
            "apikey": apiKey,
            "outputsize": TimeIntervalType._5min.outputSize
        ], encoding: URLEncoding.queryString)
    }
}
