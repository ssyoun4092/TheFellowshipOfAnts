import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit

class SignupForEmailViewController: UIViewController {
    private let emailStackView = UIStackView()
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let invalidEmailLabel = UILabel()
    private let passwordStackView = UIStackView()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let invalidPasswordLabel = UILabel()
    private let nicknameStackView = UIStackView()
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let completeSigninBtn = UIButton()

    let viewModel = SignupForEmailViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        configUI()
        bind()
    }

    func bind() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)

        emailTextField.rx
            .controlEvent(.editingDidBegin)
            .map { _ in () }
            .bind(to: viewModel.emailTextDidBegin)
            .disposed(by: disposeBag)

        emailTextField.rx
            .controlEvent(.editingDidEnd)
            .map { _ in () }
            .bind(to: viewModel.emailTextDidEnd)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)

        passwordTextField.rx
            .controlEvent(.editingDidBegin)
            .map { _ in () }
            .bind(to: viewModel.passwordTextDidBegin)
            .disposed(by: disposeBag)

        passwordTextField.rx
            .controlEvent(.editingDidEnd)
            .map { _ in () }
            .bind(to: viewModel.passwordTextDidEnd)
            .disposed(by: disposeBag)

        completeSigninBtn.rx.tap
            .bind(to: viewModel.completeBtnTap)
            .disposed(by: disposeBag)

        viewModel.emailCanValid
            .subscribe(onNext: { [weak self] valid in
                if valid {
                    self?.emailTextField.layer.borderColor = UIColor.black.cgColor
                    self?.invalidEmailLabel.isHidden = true
                } else {
                    self?.emailTextField.layer.borderColor = UIColor.red.cgColor
                    self?.invalidEmailLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)

        viewModel.passwordCanValid
            .subscribe(onNext: { [weak self] valid in
                if valid {
                    self?.passwordTextField.layer.borderColor = UIColor.black.cgColor
                    self?.invalidPasswordLabel.isHidden = true
                } else {
                    self?.passwordTextField.layer.borderColor = UIColor.red.cgColor
                    self?.invalidPasswordLabel.isHidden = false
                }
            })
            .disposed(by: disposeBag)

        Observable
            .combineLatest(viewModel.emailIsValid, viewModel.passwordIsValid) { $0 && $1 }
            .skip(1)
            .subscribe(onNext: { [weak self] valid in
                if valid {
                    self?.completeSigninBtn.backgroundColor = .systemPink
                    self?.completeSigninBtn.isUserInteractionEnabled = true
                } else {
                    self?.completeSigninBtn.backgroundColor = .lightGray
                    self?.completeSigninBtn.isUserInteractionEnabled = false
                }
            })
            .disposed(by: disposeBag)

    }

    private func attribute() {
        view.backgroundColor = .systemBackground
        emailStackView.setupSignupForEmail(subViews: [emailLabel, emailTextField, invalidEmailLabel])
        passwordStackView.setupSignupForEmail(subViews: [passwordLabel, passwordTextField, invalidPasswordLabel])
        nicknameStackView.setupSignupForEmail(subViews: [nicknameLabel, nicknameTextField])
        emailLabel.setupSignupForEmail("이메일 주소")
        emailTextField.setupSignupForEmail(placeholder: "이메일 주소 입력")
        invalidEmailLabel.setupInvalidLabel("유효하지 않은 이메일입니다.")
        passwordLabel.setupSignupForEmail("비밀번호")
        passwordTextField.setupSignupForEmail(placeholder: "영문, 숫자, 특수문자 포함 8자리 이상")
        invalidPasswordLabel.setupInvalidLabel("유효하지 않은 비밀번호입니다.")
        nicknameLabel.setupSignupForEmail("닉네임")
        nicknameTextField.setupSignupForEmail(placeholder: "닉네임")
        completeSigninBtn.setupNextBtn(title: "회원가입 완료")
    }

    private func configUI() {
        [emailStackView, passwordStackView, nicknameStackView, completeSigninBtn].forEach { view.addSubview($0) }
        configEmailStackView()
        configPasswordStackView()
        configNicknameStackView()
        configNextBtn()
    }

    private func configEmailStackView() {
        emailStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        configEmailLabel()
        configEmailTextField()
        configInvalidEmailLabel()
    }

    private func configPasswordStackView() {
        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(emailStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        configPassworLabel()
        configPasswordTextField()
        configInvalidPasswordLabel()
    }

    private func configNicknameStackView() {
        nicknameStackView.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        configNicknameLabel()
        configNicknameTextField()
    }

    private func configEmailLabel() {
        emailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }

    private func configEmailTextField() {
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }
    }

    private func configInvalidEmailLabel() {
        invalidEmailLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func configPassworLabel() {
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }

    private func configPasswordTextField() {
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }
    }

    private func configInvalidPasswordLabel() {
        invalidPasswordLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func configNicknameLabel() {
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
    }

    private func configNicknameTextField() {
        nicknameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }
    }

    private func configNextBtn() {
        completeSigninBtn.snp.makeConstraints {
            $0.top.equalTo(nicknameStackView.snp.bottom).offset(30)
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

    func setupInvalidLabel(_ text: String?) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        self.isHidden = false
        self.textColor = UIColor.red
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

private extension UIStackView {
    func setupSignupForEmail(subViews: [UIView]) {
        subViews.forEach { self.addArrangedSubview($0) }
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .equalSpacing
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
