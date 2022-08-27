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
    private func didTapTestButton() {
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
        signupWithEmailButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        signupWithEmailButton.layer.borderWidth = 1
        signupWithEmailButton.layer.borderColor = UIColor.black.cgColor
        signupWithEmailButton.layer.cornerRadius = 7

        signupWithEmailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
    }

    private func setupVStack() {
        addSubview(VStack)

        VStack.axis = .vertical
        VStack.spacing = 30

        VStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(50)
        }

        [kakaoLoginButton, appleLoginButton, emailLoginButton, testButton].forEach { VStack.addArrangedSubview($0) }

        kakaoLoginButton.setTitle("카카오로 로그인", for: .normal)
        kakaoLoginButton.setImage(UIImage(named: "KakaoLoginLogo"), for: .normal)
        kakaoLoginButton.setTitleColor(.black.withAlphaComponent(0.85), for: .normal)
        kakaoLoginButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        kakaoLoginButton.backgroundColor = UIColor(named: "KakaoLoginBgColor")
        kakaoLoginButton.layer.cornerRadius = 7

        kakaoLoginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        appleLoginButton.setTitle("Apple로 로그인", for: .normal)
        appleLoginButton.setImage(UIImage(named: "AppleLoginLogo"), for: .normal)
        appleLoginButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        appleLoginButton.setTitleColor(.white, for: .normal)
        appleLoginButton.backgroundColor = UIColor(named: "AppleLoginBgColor")
        appleLoginButton.layer.cornerRadius = 7

        appleLoginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        emailLoginButton.setTitle("이메일로 로그인", for: .normal)
        emailLoginButton.setTitleColor(.white, for: .normal)
        emailLoginButton.titleLabel?.font = .systemFont(ofSize: 19, weight: .semibold)
        emailLoginButton.backgroundColor = UIColor(named: "EmailLoginBgColor")
        emailLoginButton.layer.cornerRadius = 7

        emailLoginButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        testButton.setTitle("홈화면 바로가기", for: .normal)
        testButton.setTitleColor(.black, for: .normal)
        testButton.backgroundColor = UIColor(named: "SignupWithEmailBgColor")
        testButton.addTarget(self, action: #selector(didTapTestButton), for: .touchUpInside)

        testButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
}
