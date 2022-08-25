//
//  UIView+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
