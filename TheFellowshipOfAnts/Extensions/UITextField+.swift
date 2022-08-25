//
//  UITextField+.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/24.
//

import UIKit

extension UITextField {
    func addLeftPadding(_ width: Double) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
