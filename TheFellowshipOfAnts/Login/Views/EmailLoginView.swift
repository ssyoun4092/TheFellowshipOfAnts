//
//  EmailLoginView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/25.
//

import UIKit
import SnapKit

class EmailLoginView: UIView {

    // MARK: - IBOulets
    let mainLogoLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signupForEmailButton = UIButton()
    let findEmailButton = UIButton()
    let findPasswordButton = UIButton()
    let HStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainLogoLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupHStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

extension EmailLoginView {
    private func setupMainLogoLabel() {
        addSubview(mainLogoLabel)

        mainLogoLabel.text = "Main Logo"
        mainLogoLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        mainLogoLabel.tintColor = .black
        mainLogoLabel.textAlignment = .center

        mainLogoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }

    private func setupEmailTextField() {
        addSubview(emailTextField)

        emailTextField.placeholder = "이메일 주소 입력"
        emailTextField.addLeftPadding(15)
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(mainLogoLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(57)
        }
    }

    private func setupPasswordTextField() {
        addSubview(passwordTextField)

        passwordTextField.placeholder = "패스워드 입력"
        passwordTextField.addLeftPadding(15)
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(emailTextField.snp.height)
        }
    }

    private func setupLoginButton() {
        addSubview(loginButton)

        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        loginButton.backgroundColor = .gray
        loginButton.layer.cornerRadius = 10

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(emailTextField.snp.height)
        }
    }

    private func setupHStack() {
        addSubview(HStack)

        HStack.axis = .horizontal
        HStack.distribution = .equalSpacing
        HStack.spacing = 23

        HStack.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        [signupForEmailButton, findEmailButton, findPasswordButton].forEach { HStack.addArrangedSubview($0) }

        signupForEmailButton.setTitle("이메일 회원가입", for: .normal)
        signupForEmailButton.setTitleColor(.black, for: .normal)
        signupForEmailButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        findEmailButton.setTitle("이메일 찾기", for: .normal)
        findEmailButton.setTitleColor(.black, for: .normal)
        findEmailButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        findPasswordButton.setTitle("비밀번호 찾기", for: .normal)
        findPasswordButton.setTitleColor(.black, for: .normal)
        findPasswordButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
}
