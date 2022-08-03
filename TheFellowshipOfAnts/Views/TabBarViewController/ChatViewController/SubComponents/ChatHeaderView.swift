import UIKit
import SnapKit

class ChatHeaderView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "채팅"
        label.font = .systemFont(ofSize: 28, weight: .bold)

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatHeaderView {
    private func layout() {
        addSubview(title)

        title.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
