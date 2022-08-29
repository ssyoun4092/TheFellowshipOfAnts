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
    private var currentNonce: String?

    // MARK: - IBOulet

    let loginView = LoginView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
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
                let emailLoginVC = EmailLoginViewController()
                emailLoginVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(emailLoginVC, animated: true)
            })
            .disposed(by: disposeBag)

        loginView.signupWithEmailButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let signupForEmailVC = SignupForEmailViewController()
                signupForEmailVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(signupForEmailVC, animated: true)
            })
            .disposed(by: disposeBag)

        loginView.testButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let tabBar = TabBarController()
                tabBar.modalPresentationStyle = .fullScreen
                self?.present(tabBar, animated: false)
            })
            .disposed(by: disposeBag)

        loginView.kakaoLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.kakaoLogIn()
            })
            .disposed(by: disposeBag)

        loginView.appleLoginButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.loginWithApple()
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
                print("me() success")
                _ = user
                print("email: \(user?.kakaoAccount?.email)")
                print("password: \(user?.id)")
                print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                print("image: \(user?.kakaoAccount?.profile?.profileImageUrl)")
            }
        }
    }
}

extension LoginViewController {
    private func loginWithApple() {
        let nonce = generateRandomNonce()
        currentNonce = nonce
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(nonce)


        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    private func generateRandomNonce(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length

        while remainingLength > 0 {
            let randoms: [UInt8] = (0..<16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }

            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }

                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }

        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()

        return hashString
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }

            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }

            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idTokenString,
                rawNonce: nonce
            )

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                let tabbar = TabBarController()
                tabbar.modalPresentationStyle = .fullScreen
                self.present(tabbar, animated: true)
            }
        }


//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//        }
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!
    }
}

struct LoginViewControllerPreView: PreviewProvider {
    static var previews: some View {
        LoginViewController().toPreview()
    }
}
