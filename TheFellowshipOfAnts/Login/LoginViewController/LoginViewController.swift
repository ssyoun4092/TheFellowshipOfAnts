import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class LoginViewController: UIViewController {
    var disposeBag = DisposeBag()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "개미 원정대"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    private let kakaoLoginBtn = UIButton()
    private let appleLoginBtn = UIButton()
    private let emailLoginBtn = UIButton()
    private let signupWithEmailBtn: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor

        return button
    }()
    private let kakaoLoginLogo = UIImageView(image: UIImage(named: "KakaoLoginLogo"))
    private let appleLoginLogo = UIImageView(image: UIImage(named: "AppleLoginLogo"))

    private let testButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupUI()
        bind()
    }

    private func bind() {
        emailLoginBtn.rx.tap
            .subscribe(onNext: {
                let emailLoginVC = EmailLoginViewController()
                emailLoginVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(emailLoginVC, animated: true)
            })
            .disposed(by: disposeBag)

        signupWithEmailBtn.rx.tap
            .subscribe(onNext: {
                let signupForEmailVC = SignupForEmailViewController()
                signupForEmailVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(signupForEmailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        kakaoLoginBtn.setupLoginBtn(title: "카카오로 로그인", titleColor: .black, bgColor: "KakaoLoginBgColor", alphaComponent: 0.85)
        appleLoginBtn.setupLoginBtn(title: "Apple로 로그인", titleColor: .white,bgColor: "AppleLoginBgColor", alphaComponent: 1)
        emailLoginBtn.setupLoginBtn(title: "이메일로 로그인", titleColor: .black, bgColor: "EmailLoginBgColor", alphaComponent: 1)
        signupWithEmailBtn.setupLoginBtn(title: "이메일로 회원가입", titleColor: .black, bgColor: "SignupWithEmailBgColor", alphaComponent: 1)
        testButton.setupLoginBtn(title: "홈화면 바로가기", titleColor: .black, bgColor: "SignupWithEmailBgColor", alphaComponent: 1)
    }

    private func setupUI() {
        [titleLabel, kakaoLoginBtn, appleLoginBtn, emailLoginBtn, signupWithEmailBtn, testButton]
            .forEach { view.addSubview($0) }
        kakaoLoginBtn.addSubview(kakaoLoginLogo)
        appleLoginBtn.addSubview(appleLoginLogo)
        configSampleText()
        configKakaoLogInBtn()
        configAppleLogInBtn()
        configEmailLoginBtn()
        configSignupForEmailBtn()
        configTestButton()
    }

    private func configSampleText() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func configKakaoLogInBtn() {
        kakaoLoginBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        configKakaoLoginLogo()
    }

    private func configAppleLogInBtn() {
        appleLoginBtn.snp.makeConstraints {
            $0.top.equalTo(kakaoLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
        configAppleLoginLogo()
    }

    private func configEmailLoginBtn() {
        emailLoginBtn.snp.makeConstraints {
            $0.top.equalTo(appleLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
    }

    private func configSignupForEmailBtn() {
        signupWithEmailBtn.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
    }

    private func configKakaoLoginLogo() {
        kakaoLoginLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(22)
            $0.centerY.equalToSuperview()
        }
        kakaoLoginLogo.contentMode = .scaleAspectFill
    }

    private func configAppleLoginLogo() {
        appleLoginLogo.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(22)
//            $0.height.equalTo(appleLoginBtn.snp.height).multipliedBy(0.25)
            $0.centerY.equalToSuperview()
        }
        appleLoginLogo.contentMode = .scaleAspectFill
    }

    private func configTestButton() {
        testButton.snp.makeConstraints {
            $0.top.equalTo(emailLoginBtn.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
        testButton.addTarget(self, action: #selector(showTabbarController), for: .touchUpInside)
    }

    @objc func showTabbarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabbarViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: false)
    }
}

extension LoginViewController {
    @objc
    func kakaoLogIn(_ sender: Any) {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("login kakao")
                _ = oauthToken
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

private extension UIButton {
    func setupLoginBtn(title: String?, titleColor: UIColor, bgColor: String, alphaComponent: CGFloat) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = UIColor(named: bgColor)
        self.setTitleColor(titleColor.withAlphaComponent(alphaComponent), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.layer.cornerRadius = 12
    }
}

struct LoginViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
