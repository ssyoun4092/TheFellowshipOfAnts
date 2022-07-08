import Foundation
import UIKit
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct UIVieweControllerPreview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        UIVieweControllerPreview(viewController: self)
    }
}
#endif

extension UITextField {
    func addLeftPadding(_ width: Double) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
