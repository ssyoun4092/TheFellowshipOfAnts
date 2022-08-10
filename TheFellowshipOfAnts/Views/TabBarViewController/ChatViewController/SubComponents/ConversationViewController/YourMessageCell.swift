import UIKit
import SnapKit

class YourMessageCell: UICollectionViewCell {
    static let identifier = String(describing: YourMessageCell.self)

    private lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black

        return imageView
    }()

    private lazy var userNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "신이 되고픈 사람"

        return label
    }()

    private lazy var bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
}

extension YourMessageCell {
    private func layout() {
        addSubviews([profilePic, userNicknameLabel, bubbleBackgroundView, messageLabel])

        profilePic.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.width.height.equalTo(50)
        }

        userNicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profilePic.snp.trailing).offset(10)
            $0.top.equalTo(profilePic.snp.top)
        }

        let width = UIScreen.main.bounds.width * 0.4
        bubbleBackgroundView.snp.makeConstraints {
            $0.top.equalTo(userNicknameLabel.snp.bottom).offset(13)
            $0.leading.equalTo(profilePic.snp.trailing).offset(10)
            $0.width.equalTo(messageLabel.snp.width).offset(32)
            $0.height.equalTo(messageLabel).offset(36)
            $0.bottom.equalToSuperview()
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleBackgroundView.snp.top).inset(18)
            $0.leading.equalTo(bubbleBackgroundView.snp.leading).offset(16)
            $0.width.lessThanOrEqualTo(width)
        }
    }

    func configure(text: String) {
        messageLabel.text = text
    }
}
