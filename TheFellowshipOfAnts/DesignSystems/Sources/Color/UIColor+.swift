//
//  UIColor+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/10/26.
//

import UIKit

extension UIColor {
    static func designSystem(_ color: Pallete) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
