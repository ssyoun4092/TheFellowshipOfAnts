import UIKit
import SwiftUI
import SnapKit
import RxSwift
import RxCocoa

class EmailLoginViewController: UIViewController {
    var disposeBag = DisposeBag()
    let viewModel = EmailLoginViewModel()

    private let mainLogo: UILabel = {
        let label = UILabel()
        label.text = "Main Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.tintColor = .black
        label.textAlignment = .center
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 주소 입력"
        textField.addLeftPadding(15)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.placeholder = "비밀번호 입력"
        textField.addLeftPadding(15)
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()

    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        return button
    }()

    private let signupForEmailBtn: UIButton = {
        let button = UIButton()
        button.setTitle("이메일 회원가입", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    private let findEmailBtn: UIButton = {
        let button = UIButton()
        button.setTitle("이메일 찾기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    private let findPasswordBtn: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    private lazy var loginUtilitiesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [signupForEmailBtn, findEmailBtn, findPasswordBtn])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 23
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

struct EmailLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        EmailLoginViewController().toPreview()
    }
}
