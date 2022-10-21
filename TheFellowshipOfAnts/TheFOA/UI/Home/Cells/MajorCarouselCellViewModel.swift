//
//  MajorCarouselCellViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/02.
//

import Foundation

final class MajorCarouselCellViewModel {
    let title: String
    let fluctuationRate: String
    let price: String

    init(with entity: CarouselCellReusable) {
        self.title = entity.name
        self.fluctuationRate = entity.fluctuationRate
        self.price = entity.price
    }
}
