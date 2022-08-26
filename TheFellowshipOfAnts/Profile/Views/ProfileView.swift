import UIKit
import SnapKit

class ProfileView: UIView {

    // MARK: - IBOulets

    let profileImageView = UIImageView()
    let nicknameLabel = UILabel()
    let userIDLabel = UILabel()
    let aboutMeLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupProfileImageView()
        setupNicknameLabel()
        setupUserIDLabel()
        setupAboutMeLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    var profileImageHeight: CGFloat { return UIScreen.main.bounds.width * 0.24 }

    private func setupProfileImageView() {
        addSubview(profileImageView)

        profileImageView.backgroundColor = .black
        profileImageView.layer.cornerRadius = profileImageHeight / 2

        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
            $0.width.height.equalTo(profileImageHeight)
        }
    }

    private func setupNicknameLabel() {
        addSubview(nicknameLabel)

        nicknameLabel.text = "닉네임"
        nicknameLabel.font = .systemFont(ofSize: 21, weight: .bold)

        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(13)
            $0.bottom.equalTo(profileImageView.snp.centerY).offset(-13)
        }
    }

    private func setupUserIDLabel() {
        addSubview(userIDLabel)

        userIDLabel.text = "유저 ID"
        userIDLabel.font = .systemFont(ofSize: 17, weight: .medium)

        userIDLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.centerY).offset(13)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(13)
        }
    }

    private func setupAboutMeLabel() {
        addSubview(aboutMeLabel)

        aboutMeLabel.text = "자기소개가 없습니다."

        aboutMeLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
    }
}
