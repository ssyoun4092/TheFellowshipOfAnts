import UIKit
import SnapKit

class ChatViewController: UIViewController {

    weak var coordinator: ChatCoordinator?

    private lazy var headerView = ChatHeaderView()
    private lazy var chatListView = ChatListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        chatListView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layout()
    }
}

extension ChatViewController {
    private func layout() {
        view.addSubviews([headerView, chatListView])

        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }

        chatListView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ChatViewController: ChatListViewDelegate {
    func showMessageViewController() {
        let vc = MessagesViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated:  true)
    }
}
