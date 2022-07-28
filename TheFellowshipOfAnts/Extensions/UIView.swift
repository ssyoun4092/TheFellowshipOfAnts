import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
