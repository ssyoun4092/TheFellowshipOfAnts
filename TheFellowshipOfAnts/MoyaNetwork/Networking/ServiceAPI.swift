//
//  ServiceAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import TheFellowshipOfAntsKey
import Moya

protocol ServiceAPI: TargetType {
    associatedtype ResponseDTO: Decodable
    var serviceBaseURL: ServiceBaseURL { get }
}

extension ServiceAPI {
    var baseURL: URL { serviceBaseURL.baseURL }
    var headers: [String : String]? { nil }
}

enum ServiceBaseURL {
    case twelveData
    case alphavantage
    case financialmodeling
}

extension ServiceBaseURL {
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
}
