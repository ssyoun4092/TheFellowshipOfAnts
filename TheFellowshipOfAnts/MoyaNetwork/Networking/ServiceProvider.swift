//
//  ServiceProvider.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/26.
//

import Foundation

import TheFellowshipOfAntsKey

enum ServiceProvider {
    case twelveData
    case alphavantage
    case financialmodeling
}

extension ServiceProvider {
    var baseURL: URL {
        switch self {
        case .twelveData:
            return URL(string: "https://api.twelvedata.com")!
        case .alphavantage:
            return URL(string: "https://www.alphavantage.co")!
        case .financialmodeling:
            return URL(string: "https://financialmodelingprep.com")!
        }
    }

    var apiKey: String {
        switch self {
        case .twelveData:
            return TheFOARequest.ApiKey.twelvedata.rawValue
        case .alphavantage:
            return TheFOARequest.ApiKey.alphavantage.rawValue
        case .financialmodeling:
            return TheFOARequest.ApiKey.financialmodeling.rawValue
        }
    }
}
