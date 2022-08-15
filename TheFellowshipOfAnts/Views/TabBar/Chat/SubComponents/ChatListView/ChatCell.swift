import UIKit
import SnapKit

class ChatCell: UITableViewCell {
    static let identifier = String(describing: ChatCell.self)

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = false

        return imageView
    }()

    private lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "애플"
        label.font = .systemFont(ofSize: 17, weight: .semibold)

        return label
    }()

    private lazy var lastChatLabel: UILabel = {
        let label = UILabel()
        label.text = "고급 정보 알려드립니다."
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatCell {
    private func layout() {
        addSubviews([logoImageView, companyNameLabel, lastChatLabel])

        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(logoImageView.snp.height)
            $0.centerY.equalToSuperview()
        }

        lastChatLabel.snp.makeConstraints {
            $0.top.equalToSuperview { $0.snp.centerY }.offset(-10)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.greaterThanOrEqualToSuperview().inset(13)
        }

        companyNameLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(lastChatLabel.snp.top)
        }
    }
}
