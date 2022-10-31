//
//  LikedCellViewModel.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/31.
//

import Foundation

class LikedCellViewModel {
    let likedEntity: Entity.Liked
    let prices: [Double]

    init(
        likedEntity: Entity.Liked,
        prices: [Double]
    ) {
        self.likedEntity = likedEntity
        self.prices = prices
    }
}
