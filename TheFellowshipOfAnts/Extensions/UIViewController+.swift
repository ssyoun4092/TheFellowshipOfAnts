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
