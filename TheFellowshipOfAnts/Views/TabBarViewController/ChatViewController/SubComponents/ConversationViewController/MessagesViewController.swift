import UIKit
import SnapKit

class MessagesViewController: UIViewController {

    private lazy var messagesView = MessagesView()
    private lazy var inputTextContainerView = InputTextContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutNavigationBar()
        layout()
    }
}

extension MessagesViewController {
    private func layoutNavigationBar() {
        title = "에코프로비엠"
    }

    private func layout() {
        view.backgroundColor = .white
        view.addSubviews([messagesView, inputTextContainerView])

        messagesView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(inputTextContainerView.snp.top)
        }

        inputTextContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.height.equalTo(70)
        }
    }
}
