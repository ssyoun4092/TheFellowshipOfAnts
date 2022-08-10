import UIKit
import SnapKit

class MyMessageCell: UICollectionViewCell {
    static let identifer = String(describing: MyMessageCell.self)

    private lazy var bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 15

        return view
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        layout()
    }
}

extension MyMessageCell {
    private func layout() {
        contentView.addSubviews([bubbleBackgroundView, messageLabel])

        let width = UIScreen.main.bounds.width * 0.5
        bubbleBackgroundView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.width.equalTo(messageLabel.snp.width).offset(32)
            $0.height.equalTo(messageLabel).offset(36)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleBackgroundView.snp.top).inset(18)
            $0.trailing.equalTo(bubbleBackgroundView.snp.trailing).inset(16)
            $0.width.lessThanOrEqualTo(width)
        }
    }

    func configure(text: String) {
        messageLabel.text = text
    }
}
