//
//  CommoditiesDTO.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/29.
//

import Foundation

extension DTO {
    struct Commodities {
        let commodities: [Commodity]

        struct Commodity {
            let name: String
            let price: String
            let fluctuationRate: String
        }
    }
}
