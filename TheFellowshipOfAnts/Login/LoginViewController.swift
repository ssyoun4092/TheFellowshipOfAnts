import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices

class LoginViewController: UIViewController {

    // MARK: - Properties

    var disposeBag = DisposeBag()

    // MARK: - IBOulet

    let loginView = LoginView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        loginView.delegate = self

        setupViews()
        bind()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(loginView)

        loginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }

    private func bind() {
        loginView.emailLoginButton.rx.tap
            .subscribe(onNext: {
                let emailLoginVC = EmailLoginViewController()
                emailLoginVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(emailLoginVC, animated: true)
            })
            .disposed(by: disposeBag)

        loginView.signupWithEmailButton.rx.tap
            .subscribe(onNext: {
                let signupForEmailVC = SignupForEmailViewController()
                signupForEmailVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(signupForEmailVC, animated: true)
            })
            .disposed(by: disposeBag)
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

extension LoginViewController: LoginViewDelegate {
    func navigateTabBar() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}

struct LoginViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
