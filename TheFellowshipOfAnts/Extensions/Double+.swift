//
//  Double+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/30.
//

import Foundation

extension Double {
    func toStringWithFloor(at num: Int) -> String {
        return String(format: "%.\(num)f", self)
    }
}
