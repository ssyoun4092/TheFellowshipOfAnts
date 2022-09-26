//
//  CustomProvider.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/25.
//

import Foundation

import Moya

class CustomProvider<Target: TargetType>: MoyaProvider<Target> {
    init() {
        super.init()
    }
}
