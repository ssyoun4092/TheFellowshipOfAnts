import UIKit
import SnapKit

class ProfileSectionView: UIView {
    private let imageHeight = UIScreen.main.bounds.width * 0.24

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageHeight / 2
        imageView.backgroundColor = .black

        return imageView
    }()

    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 21, weight: .bold)

        return label
    }()

    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.text = "유저 ID"
        label.font = .systemFont(ofSize: 17, weight: .medium)

        return label
    }()

    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "자기소개가 없습니다."

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

extension ProfileSectionView {
    private func layout() {
        addSubviews([profileImageView, nicknameLabel, userIDLabel, aboutMeLabel])

        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
            $0.width.height.equalTo(imageHeight)
        }

        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(13)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-13)
        }

        userIDLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(13)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(13)
        }

        aboutMeLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
    }
}
