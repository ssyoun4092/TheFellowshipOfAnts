//
//  Top20StockRanks.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

extension DTO {
    struct Top20Stocks: Crawlable {
        let stocks: [Stock]

        struct Stock {
            let companyName: String
            let symbol: String
            let price: String
            let fluctuationRate: String
            let logoURLString: String
        }
    }
}
