import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import CryptoKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - Properties

    var disposeBag = DisposeBag()
    var coordinator: AuthCoordinator?
    private var currentNonce: String?

    // MARK: - IBOulet

    let loginView = LoginView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        coordinator?.didFinishAuth()
    }

    // MARK: - Methods

    private func setupViews() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }

    private func bind() {
        loginView.emailLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.pushToEmailLoginVC()
            })
            .disposed(by: disposeBag)

        loginView.signupWithEmailButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.pushToSignupWithEmailVC()
            })
            .disposed(by: disposeBag)

        loginView.testButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.showTabBarVC()
            })
            .disposed(by: disposeBag)

        loginView.kakaoLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.kakaoLogIn()
            })
            .disposed(by: disposeBag)

        loginView.appleLoginButton.rx.tap
            .subscribe(onNext: { _ in
                AppleAuth.shared.signInWithApple()
            })
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    private func kakaoLogIn() {
        print(#function)
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("loginWithKakaoTalk() Success")
                _ = oauthToken

                let accessToken = oauthToken?.accessToken
                print("accessToken: \(accessToken)") 
                self.setUserInfo()
            }
        }
    }

    private func setUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                _ = user
                print("email: \(user?.kakaoAccount?.email)")
                print("password: \(user?.id)")
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
