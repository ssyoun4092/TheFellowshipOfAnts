//
//  Commodity.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/02.
//

import Foundation

extension Entity {
    struct Commodity: CarouselCellReusable {
        let name: String
        let price: String
        let fluctuationRate: String
    }
}

protocol CarouselCellReusable {
    var name: String { get }
    var price: String { get }
    var fluctuationRate: String { get }
}
