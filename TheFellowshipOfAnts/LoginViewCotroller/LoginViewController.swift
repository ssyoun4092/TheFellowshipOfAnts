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
        label.text = "열심히 살까??"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }

    private func bind() {
        emailLoginBtn.rx.tap
            .subscribe(onNext: {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let mainViewController = storyboard.instantiateViewController(identifier: "TabbarViewController")
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: false)
            })
            .disposed(by: disposeBag)
    }

    private func setupUI() {
        view.addSubview(sampleLabel)
        view.addSubview(kakaoLoginBtn)
        view.addSubview(appleLoginBtn)
        view.addSubview(emailLoginBtn)
        setupSampleText()
        setupKakaoLogInUI()
        setupAppleLogInUI()
        setupEmailLoginUI()
    }

    private func setupSampleText() {
        sampleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(130)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func setupKakaoLogInUI() {
        kakaoLoginBtn.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func setupAppleLogInUI() {
        appleLoginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private func setupEmailLoginUI() {
//        signupBtn.addTarget(self, action: #selector(showTabbarController), for: .touchUpInside)
        emailLoginBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(appleLoginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
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

struct LogInViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
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
