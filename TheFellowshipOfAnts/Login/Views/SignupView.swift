//
//  SignupView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit

import SnapKit

class SignupView: UIView {

    // MARK: - IBOutlets

    let emailStackView = UIStackView()
    let emailHeaderLabel = UILabel()
    let emailTextField = UITextField()
    let invalidEmailLabel = UILabel()

    let passwordStackView = UIStackView()
    let passwordHeaderLabel = UILabel()
    let passwordTextField = UITextField()
    let invalidPasswordLabel = UILabel()

    let nicknameStackView = UIStackView()
    let nicknameHeaderLabel = UILabel()
    let nicknameTextField = UITextField()
    let invalidNicknameLabel = UILabel()

    let completeSigninButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupEmailStackView()
        setupPasswordStackView()
        setupNicknameStackView()
        setupCompleteSigninButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignupView {
    private func setupEmailStackView() {
        addSubview(emailStackView)

        emailStackView.axis = .vertical
        emailStackView.spacing = 10
        emailStackView.distribution = .equalSpacing

        emailStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        [emailHeaderLabel, emailTextField, invalidEmailLabel].forEach { emailStackView.addArrangedSubview($0) }

        emailHeaderLabel.text = "이메일 주소"
        emailHeaderLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        emailHeaderLabel.textColor = .black

        emailHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }

        emailTextField.placeholder = "이메일 주소를 입력"
        emailTextField.addLeftPadding(15)
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor

        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }

        invalidEmailLabel.text = "유효한 이메일 형식이 아닙니다"
        invalidEmailLabel.font = .systemFont(ofSize: 15, weight: .regular)
        invalidEmailLabel.textColor = .red
        invalidEmailLabel.isHidden = true

        invalidEmailLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupPasswordStackView() {
        addSubview(passwordStackView)

        passwordStackView.axis = .vertical
        passwordStackView.spacing = 10
        passwordStackView.distribution = .equalSpacing

        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(emailStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }

        [passwordHeaderLabel, passwordTextField, invalidPasswordLabel].forEach { passwordStackView.addArrangedSubview($0) }

        passwordHeaderLabel.text = "비밀번호"
        passwordHeaderLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        passwordHeaderLabel.textColor = .black

        passwordHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }

        passwordTextField.placeholder = "영문, 숫자, 특수문자 포함 8자리 이상"
        passwordTextField.addLeftPadding(15)
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }

        invalidPasswordLabel.text = "영문+숫자+특수문자 조합, 8자리 이상이어야 합니다."
        invalidPasswordLabel.font = .systemFont(ofSize: 15, weight: .regular)
        invalidPasswordLabel.textColor = .red
        invalidPasswordLabel.isHidden = true

        invalidPasswordLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupNicknameStackView() {
        addSubview(nicknameStackView)

        nicknameStackView.axis = .vertical
        nicknameStackView.spacing = 10
        nicknameStackView.distribution = .equalSpacing

        nicknameStackView.snp.makeConstraints {
            $0.top.equalTo(passwordStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }

        [nicknameHeaderLabel, nicknameTextField, invalidNicknameLabel].forEach { nicknameStackView.addArrangedSubview($0) }

        nicknameHeaderLabel.text = "닉네임"
        nicknameHeaderLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nicknameHeaderLabel.textColor = .black

        nicknameHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }

        nicknameTextField.placeholder = "한글, 영문, 숫자 가능하며 2-10자리 가능"
        nicknameTextField.addLeftPadding(15)
        nicknameTextField.layer.cornerRadius = 10
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.borderColor = UIColor.black.cgColor

        nicknameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(57)
        }

        invalidNicknameLabel.text = "올바른 닉네임 형식이 아닙니다."
        invalidNicknameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        invalidNicknameLabel.textColor = .red
        invalidNicknameLabel.isHidden = true

        invalidNicknameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupCompleteSigninButton() {
        addSubview(completeSigninButton)

        completeSigninButton.setTitle("회원가입 완료", for: .normal)
        completeSigninButton.setTitleColor(.white, for: .normal)
        completeSigninButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        completeSigninButton.layer.cornerRadius = 10
        completeSigninButton.backgroundColor = .lightGray

        completeSigninButton.snp.makeConstraints {
            $0.top.equalTo(nicknameStackView.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(57)
        }
    }
}
