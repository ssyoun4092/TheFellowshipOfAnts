import Foundation
import UIKit

extension UILabel {
    func setLetterSpacing(by value: Double) {
        if let text = self.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
