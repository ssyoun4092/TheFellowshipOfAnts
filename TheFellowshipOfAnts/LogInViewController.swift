import UIKit
import SwiftUI
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser

class LogInViewController: UIViewController {
    private let sampleLabel: UILabel = {
        let label = UILabel()
        label.text = "열심히 살까??"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let kakaoLoginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "KakaoLogInColor")
        btn.setTitle("카카오로 로그인", for: .normal)
        btn.setImage(UIImage(named: "KakaoLogInLogo"), for: .normal)
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let kakaoLoginLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "KakaoLogInLogo"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let kakaoLoginLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오로 로그인"
        label.tintColor = .black.withAlphaComponent(0.85)
        label.textAlignment = .center
        return label
    }()

    private lazy var kakaoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [kakaoLoginLogo, kakaoLoginLabel])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private let appleLoginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Apple로 로그인", for: .normal)
        btn.setImage(UIImage(named: "AppleLoginLogo"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 12
        return btn
    }()

//    private let appleLogInLogo: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "AppleLoginLogo"))
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//    private let appleLogInLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Apple로 로그인"
//        label.textColor = .white
//        label.textAlignment = .center
//        return label
//    }()
//
//    private lazy var appleStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [appleLogInLogo, appleLogInLabel])
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fill
//        stackView.spacing = 0
//        return stackView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(sampleLabel)
        view.addSubview(kakaoLoginBtn)
        view.addSubview(appleLoginBtn)
        setUpSampleText()
        setUpKakaoLogInUI()
        setUpAppleLogInUI()
    }

    private func setUpSampleText() {
        sampleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func setUpKakaoLogInUI() {
        kakaoLoginBtn.addSubview(kakaoStackView)
        kakaoLoginBtn.addTarget(self, action: #selector(kakaoLogIn), for: .touchUpInside)

        kakaoLoginBtn.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }

        kakaoStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
//            $0.width.equalToSuperview().multipliedBy(0.5)
//            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        kakaoLoginLogo.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(kakaoLoginBtn.snp.height).multipliedBy(0.33)
        }

        kakaoLoginLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
    }

    private func setUpAppleLogInUI() {
//        appleLogInBtn.addSubview(appleStackView)
//
        appleLoginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
//
//        appleStackView.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
////            $0.width.equalToSuperview().multipliedBy(0.5)
////            $0.height.equalToSuperview().multipliedBy(0.3)
//        }
//
//        appleLogInLogo.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview()
//            $0.height.equalTo(appleLogInBtn.snp.height).multipliedBy(0.2)
//        }
//
//        appleLogInLabel.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview()
//        }
    }
}

extension LogInViewController {
    @objc func kakaoLogIn(_ sender: Any) {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("login kakao")
                _ = oauthToken
                self.navigationController?.pushViewController(AfterLogInViewController(), animated: true)
            }
        }
    }

    private func setUserInfo() {
            UserApi.shared.me {(user, error) in
                if let error = error {
                    print(error)
                } else {
                    print("me() success")
                    _ = user
                    print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                    print("image: \(user?.kakaoAccount?.profile?.profileImageUrl)")
                }
            }
        }
}

struct LogInViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LogInViewController().toPreview()
    }
}


#if DEBUG
extension UIViewController {
    private struct LogInViewControllerPreView: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            LogInViewControllerPreView(viewController: self)
        }
}
#endif
