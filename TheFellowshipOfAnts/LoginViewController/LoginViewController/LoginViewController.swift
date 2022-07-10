import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser

class LoginViewController: UIViewController {
    var disposeBag = DisposeBag()

    private let sampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Main Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let kakaoLoginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(named: "KakaoColor")
        btn.setTitle("카카오로 로그인", for: .normal)
        btn.setTitleColor(UIColor.black.withAlphaComponent(0.85), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.setImage(UIImage(named: "KakaoLoginLogo"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let appleLoginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("Apple로 로그인", for: .normal)
        btn.setImage(UIImage(named: "AppleLoginLogo"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let emailLoginBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .darkGray
        btn.setTitle("이메일로 로그인", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        btn.layer.cornerRadius = 12
        return btn
    }()

    private let signupForEmailBtn: UIButton = {
        let button = UIButton()
        button.setTitle("이메일로 회원가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

        signupForEmailBtn.rx.tap
            .subscribe(onNext: {
                let signupForEmailVC = SignupForEmailViewController()
                signupForEmailVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(signupForEmailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setupUI() {
        [sampleLabel, kakaoLoginBtn, appleLoginBtn, emailLoginBtn, signupForEmailBtn]
            .forEach { view.addSubview($0) }
        configSampleText()
        configKakaoLogInBtn()
        configAppleLogInBtn()
        configEmailLoginBtn()
        configSignupForEmailBtn()
    }

    private func configSampleText() {
        sampleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func configKakaoLogInBtn() {
        kakaoLoginBtn.snp.makeConstraints {
            $0.top.equalTo(sampleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func configAppleLogInBtn() {
        appleLoginBtn.snp.makeConstraints {
            $0.top.equalTo(kakaoLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
    }

    private func configEmailLoginBtn() {
//        signupBtn.addTarget(self, action: #selector(showTabbarController), for: .touchUpInside)
        emailLoginBtn.snp.makeConstraints {
            $0.top.equalTo(appleLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
    }

    private func configSignupForEmailBtn() {
        signupForEmailBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(kakaoLoginBtn.snp.height)
        }
    }

    @objc func showTabbarController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "TabbarViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        self.present(mainViewController, animated: false)
    }
}

extension LoginViewController {
    @objc func kakaoLogIn(_ sender: Any) {
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

struct LoginViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
