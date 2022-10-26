//
//  RecentSearchedStockUDS.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/21.
//

import Foundation

extension UDModel {
    struct RecentSearchStock: Codable {
        let symbol: String
        let companyName: String
    }
}
