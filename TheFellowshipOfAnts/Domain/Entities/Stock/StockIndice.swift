//
//  StockIndice.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

extension Entity {
    /// 주가지수 Entity
    struct StockIndice {
        let title: String
        let prices: [String]
        let fluctuation: Fluctuation
    }
}
