import Foundation
import UIKit

extension UICollectionView {
    func scroll(to: Position, animated: Bool) {
        let sections = numberOfSections
        let items = numberOfItems(inSection: numberOfSections - 1)
        switch to {
        case .top:
            if items > 0 {
                let indexPath = IndexPath(item: 0, section: 0)
                self.scrollToItem(at: indexPath, at: .top, animated: animated)
            }
            break
        case .bottom:
            if items > 0 {
                let indexPath = IndexPath(item: items - 1, section: sections - 1)
                self.scrollToItem(at: indexPath, at: .bottom, animated: animated)
            }
            break
        }
    }

    enum Position {
        case top
        case bottom
    }
}
