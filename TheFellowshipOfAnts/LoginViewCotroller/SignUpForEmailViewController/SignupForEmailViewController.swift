import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit

class SignupForEmailViewController: UIViewController {
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let completeSigninBtn = UIButton()

    let viewModel = SignupForEmailViewModel()
    var disposeBag = DisposeBag()
//    let emailInput = BehaviorSubject<String>(value: "")
    let passwordInput = BehaviorSubject<String>(value: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        configUI()
        bind()
    }

    func bind() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailInput)
            .disposed(by: disposeBag)

        viewModel.emailValid
            .subscribe(onNext: { [weak self] valid in
                print("email valid: \(valid)")
                if valid {
                    self?.emailTextField.layer.borderColor = UIColor.black.cgColor
                } else {
                    self?.emailTextField.layer.borderColor = UIColor.red.cgColor
                }
            })
            .disposed(by: disposeBag)

//        emailInput
//            .map { input -> Bool in
//                if input.contains("@") && input.contains(".") || input == "" {
//                    return true
//                } else {
//                    return false
//                }
//            }
//            .subscribe(onNext: { [weak self] valid in
//                if valid {
//                    self?.emailTextField.layer.borderColor = UIColor.black.cgColor
//                } else {
//                    self?.emailTextField.layer.borderColor = UIColor.red.cgColor
//                }
//            })
//            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: passwordInput)
            .disposed(by: disposeBag)

        passwordInput
            .map(checkPasswordValid)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        let pattern = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[~!@#$%^&*]).{8,}$"
        if password.range(of: pattern, options: .regularExpression) == nil {
            return false
        } else {
            return true
        }
    }

    private func attribute() {
        view.backgroundColor = .systemBackground
        emailLabel.setupSignupForEmail("이메일 주소")
        emailTextField.setupSignupForEmail(placeholder: "이메일 주소 입력")
        passwordLabel.setupSignupForEmail("비밀번호")
        passwordTextField.setupSignupForEmail(placeholder: "영문, 숫자, 특수문자 포함 8자리 이상")
        nicknameLabel.setupSignupForEmail("닉네임")
        nicknameTextField.setupSignupForEmail(placeholder: "닉네임")
        completeSigninBtn.setupNextBtn(title: "회원가입 완료")
    }

    private func configUI() {
        [emailLabel, emailTextField, passwordLabel, passwordTextField, nicknameLabel, nicknameTextField, completeSigninBtn].forEach { view.addSubview($0) }
        configEmailLabel()
        configEmailTextField()
        configPassworLabel()
        configPasswordTextField()
        configNicknameLabel()
        configNicknameTextField()
        configNextBtn()
    }

    private func configEmailLabel() {
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }

    private func configEmailTextField() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }

    private func configPassworLabel() {
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }

    private func configPasswordTextField() {
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }

    private func configNicknameLabel() {
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }

    private func configNicknameTextField() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }

    private func configNextBtn() {
        completeSigninBtn.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }
}

private extension UILabel {
    func setupSignupForEmail(_ text: String?) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.textColor = .black
    }
}

private extension UITextField {
    func setupSignupForEmail(placeholder: String?) {
        self.addLeftPadding(15)
        self.placeholder = placeholder
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}

private extension UIButton {
    func setupNextBtn(title: String?) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray
    }
}

struct SignUpForEmailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SignupForEmailViewController().toPreview()
    }
}
