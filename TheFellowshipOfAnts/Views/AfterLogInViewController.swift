import UIKit
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser

class AfterLogInViewController: UIViewController {
    
    private let sampleLabel: UILabel = {
        let label = UILabel()
        label.text = "열심히 살자!!"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(sampleLabel)
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(kakaoLogOut), for: .touchUpInside)
        setUpSampleText()
        setUpLogoutButton()
    }

    private func setUpSampleText() {
        sampleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func setUpLogoutButton() {
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview().inset(30)
        }
    }

    @objc func kakaoLogOut(_ sender: Any) {
        UserApi.shared.logout{(error) in
            if let error = error {
                print(error)
            } else {
                print("kakao logout success")
            }
        }
    }
}
