import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class EmailLoginViewController: UIViewController {
    var disposeBag = DisposeBag()
    let viewModel = EmailLoginViewModel()

    private let mainLogo = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginBtn = UIButton()
    private let signupForEmailBtn = UIButton()
    private let findEmailBtn = UIButton()
    private let findPasswordBtn = UIButton()
    private lazy var loginUtilitiesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signupForEmailBtn, findEmailBtn, findPasswordBtn])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 23
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupUI()
        bind()
    }

    func bind() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailInput)
            .disposed(by: disposeBag)

        viewModel.emailValid
            .subscribe(onNext: { [weak self] valid in
//                if valid {
//                    borderColor = UIColor.systemGreen.cgColor
//                } else {
//                    borderColor = UIColor.black.cgColor
//                }
            })
            .disposed(by: disposeBag)
    }

    private func attribute() {
        mainLogo.setupEmailLogin(title: "Main Title")
        emailTextField.setupEmailLogin(placeholder: "이메일 주소 입력")
        passwordTextField.setupEmailLogin(placeholder: "비밀번호 입력")
        loginBtn.setupLoginBtn(title: "로그인")
        signupForEmailBtn.setupEmailLogin(title: "이메일 회원가입")
        findEmailBtn.setupEmailLogin(title: "이메일 찾기")
        findPasswordBtn.setupEmailLogin(title: "비밀번호 찾기")
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        [mainLogo, emailTextField, passwordTextField, loginBtn, loginUtilitiesStack].forEach { view.addSubview($0) }
        setupMainLogo()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginBtn()
        setupLoginUtilitiesStack()
    }

    private func setupMainLogo() {
        mainLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }

    private func setupEmailTextField() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(mainLogo.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }

    private func setupPasswordTextField() {
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(emailTextField.snp.height)
        }
    }

    private func setupLoginBtn() {
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(emailTextField.snp.height)
        }
    }

    private func setupLoginUtilitiesStack() {
        loginUtilitiesStack.snp.makeConstraints {
            $0.top.equalTo(loginBtn.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
}

private extension UILabel {
    func setupEmailLogin(title: String?) {
        self.text = title
        self.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        self.tintColor = .black
        self.textAlignment = .center
    }
}

private extension UITextField {
    func setupEmailLogin(placeholder: String?) {
        self.placeholder = placeholder
        self.addLeftPadding(15)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}

private extension UIButton {
    func setupLoginBtn(title: String?) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
    }

    func setupEmailLogin(title: String?) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}

struct EmailLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        EmailLoginViewController().toPreview()
    }
}
