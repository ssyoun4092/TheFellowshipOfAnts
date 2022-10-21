//
//  Top20StocksCrawlAPI.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

import SwiftSoup

struct Top20StocksCrawlAPI: CrawlServiceAPI {
//    typealias ResponseDTO = DTO.Top20Stocks
    var provider: CrawlProvider { .companiesMarketCap }
    var path: String { "/usa/largest-companies-in-the-usa-by-market-cap/"}
    var elementLinks: [String] {
        return [
            ".company-name",
            ".company-code",
            ".td-right",
            ".rh-sm",
            ".company-logo"
        ]
    }
}
