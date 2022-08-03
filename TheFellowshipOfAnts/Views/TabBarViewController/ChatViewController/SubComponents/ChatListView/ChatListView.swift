import UIKit
import SnapKit

class ChatListView: UIView {

    private lazy var chatListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.identifier)
        tableView.rowHeight = 70
        tableView.dataSource = self

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatListView {
    private func layout() {
        addSubview(chatListTableView)

        chatListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ChatListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.identifier, for: indexPath) as? ChatCell else { return UITableViewCell() }

        return cell
    }


}
