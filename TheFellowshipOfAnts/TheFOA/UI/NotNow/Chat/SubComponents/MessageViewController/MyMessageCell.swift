import UIKit
import SnapKit

class MessageCell: UICollectionViewCell {
    var cellWidth = UIScreen.main.bounds.width * 0.5
    var cellSidePadding: CGFloat = 15
    var messageTopPadding: CGFloat = 18
    var messageLeadingPadding: CGFloat = 16

    
}

class MyMessageCell: MessageCell {
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
            $0.trailing.equalToSuperview().inset(cellSidePadding)
            $0.width.equalTo(messageLabel.snp.width).offset(messageLeadingPadding * 2)
            $0.height.equalTo(messageLabel).offset(messageTopPadding * 2)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleBackgroundView.snp.top).inset(messageTopPadding)
            $0.trailing.equalTo(bubbleBackgroundView.snp.trailing).inset(messageLeadingPadding)
            $0.width.lessThanOrEqualTo(width)
        }
    }

    func configure(text: String) {
        messageLabel.text = text
    }
}
