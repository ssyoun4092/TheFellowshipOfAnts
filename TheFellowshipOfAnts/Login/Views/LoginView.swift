//
//  LoginView.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/08/18.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func navigateTabBar()
}

class LoginView: UIView {

    // MARK: - Properties
    weak var delegate: LoginViewDelegate?

    // MARK: - IBOulets

    let titleLabel = UILabel()
    let VStack = UIStackView()
    let kakaoLoginButton = UIButton()
    let appleLoginButton = UIButton()
    let emailLoginButton = UIButton()
    let signupWithEmailButton = UIButton()
    let testButton = UIButton()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitleLabel()
        setupSignupWithEmailButton()
        setupVStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func didTapTestButton() {
        print("DID Tapped")
        delegate?.navigateTabBar()
    }
}

extension LoginView {
    private func setupTitleLabel() {
        addSubview(titleLabel)

        titleLabel.text = "개미 원정대"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = .black

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }

    private func setupSignupWithEmailButton() {
        addSubview(signupWithEmailButton)

        signupWithEmailButton.setTitle("이메일로 회원가입", for: .normal)
        signupWithEmailButton.setTitleColor(.black, for: .normal)
        signupWithEmailButton.layer.borderWidth = 1
        signupWithEmailButton.layer.borderColor = UIColor.black.cgColor

        signupWithEmailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }

    private func setupVStack() {
        addSubview(VStack)

        VStack.axis = .vertical
        VStack.distribution = .equalSpacing

        VStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(250)
        }

        [kakaoLoginButton, appleLoginButton, emailLoginButton, testButton].forEach { VStack.addArrangedSubview($0) }

        kakaoLoginButton.setTitle("카카오로 로그인", for: .normal)
        kakaoLoginButton.setTitleColor(.black, for: .normal)
        kakaoLoginButton.backgroundColor = UIColor(named: "KakaoLoginBgColor")

        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        appleLoginButton.setTitle("Apple로 로그인", for: .normal)
        appleLoginButton.setTitleColor(.white, for: .normal)
        appleLoginButton.backgroundColor = UIColor(named: "AppleLoginBgColor")

        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        emailLoginButton.setTitle("이메일로 로그인", for: .normal)
        emailLoginButton.setTitleColor(.black, for: .normal)
        emailLoginButton.backgroundColor = UIColor(named: "SignupWithEmailBgColor")

        emailLoginButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        testButton.setTitle("홈화면 바로가기", for: .normal)
        testButton.setTitleColor(.black, for: .normal)
        testButton.backgroundColor = UIColor(named: "SignupWithEmailBgColor")
        testButton.addTarget(self, action: #selector(didTapTestButton), for: .touchUpInside)

        testButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}
