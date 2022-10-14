//
//  CrawlServiceAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

import SwiftSoup

protocol CrawlServiceAPI {
//    associatedtype ResponseDTO: Crawlable
    var provider: CrawlProvider { get }
    var path: String { get }
    var elementLinks: [String] { get }
}

extension CrawlServiceAPI {
    var url: URL { return URL(string: provider.baseURLString + path)! }
    var html: String { return try! String(contentsOf: url, encoding: .utf8) }
    var doc: Document {
        do {
            return try parse(html)
        } catch {
            return Document("")
        }
    }
}

enum CrawlProvider {
    case companiesMarketCap
    case businessInside
}

extension CrawlProvider {
    var baseURLString: String {
        switch self {
        case .companiesMarketCap: return
            "https://companiesmarketcap.com"
        case .businessInside: return
            "https://markets.businessinsider.com"
        }
    }
}
