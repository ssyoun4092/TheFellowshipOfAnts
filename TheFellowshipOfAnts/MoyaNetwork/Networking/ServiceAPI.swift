//
//  ServiceAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya

protocol ServiceAPI: TargetType {
    associatedtype ResponseDTO: Decodable
    var serviceProvider: ServiceProvider { get }
}

extension ServiceAPI {
    var baseURL: URL { serviceProvider.baseURL }
    var method: Moya.Method { .get }
    var headers: [String : String]? { nil }
    var apiKey: String { serviceProvider.apiKey }
}

protocol StockAPI: ServiceAPI {
    var symbol: String { get }
}
