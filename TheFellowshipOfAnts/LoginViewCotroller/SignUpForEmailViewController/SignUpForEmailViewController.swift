import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import SnapKit

class SignUpForEmailViewController: UIViewController {
    private let emailLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordTextField = UITextField()
    private let nicknameLabel = UILabel()
    private let nicknameTextField = UITextField()
    private let nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입 완료", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        configUI()
    }

    private func attribute() {
        emailLabel.setupSignupForEmail("이메일 주소")
        emailTextField.setupSignupForEmail(placeholder: "이메일 주소 입력")
        passwordLabel.setupSignupForEmail("비밀번호")
        passwordTextField.setupSignupForEmail(placeholder: "영문, 숫자, 특수문자 포함 8자리 이상")
        nicknameLabel.setupSignupForEmail("닉네임")
        nicknameTextField.setupSignupForEmail(placeholder: "닉네임")
    }

    private func configUI() {
        [emailLabel, emailTextField, passwordLabel, passwordTextField, nicknameLabel, nicknameTextField, nextBtn].forEach { view.addSubview($0) }
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
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }
}

struct SignUpForEmailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SignUpForEmailViewController().toPreview()
    }
}

extension UILabel {
    func setupSignupForEmail(_ text: String?) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.textColor = .black
    }
}

extension UITextField {
    func setupSignupForEmail(placeholder: String?) {
        self.addLeftPadding(15)
        self.placeholder = placeholder
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
