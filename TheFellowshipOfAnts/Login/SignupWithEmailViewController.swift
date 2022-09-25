import UIKit

import RxCocoa
import RxSwift
import SnapKit
import SwiftUI

class SignupWithEmailViewController: UIViewController {

    // MARK: - Properties
    let viewModel = SignupWithEmailViewModel()
    var disposeBag = DisposeBag()

    // MARK: - IBOutlet
    let signupView = SignupView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bind()
    }

    // MARK: - Methods

    func setupViews() {
        view.backgroundColor = .systemBackground
        view.endEditing(true)

        view.addSubview(signupView)

        signupView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    func bind() {
        signupView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)

        signupView.emailTextField.rx
            .controlEvent(.editingDidBegin)
            .map { _ in () }
            .bind(to: viewModel.emailTextDidBegin)
            .disposed(by: disposeBag)

        signupView.emailTextField.rx
            .controlEvent(.editingDidEnd)
            .map { _ in () }
            .bind(to: viewModel.emailTextDidEnd)
            .disposed(by: disposeBag)

        signupView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)

        signupView.passwordTextField.rx
            .controlEvent(.editingDidBegin)
            .map { _ in () }
            .bind(to: viewModel.passwordTextDidBegin)
            .disposed(by: disposeBag)

        signupView.passwordTextField.rx
            .controlEvent(.editingDidEnd)
            .map { _ in () }
            .bind(to: viewModel.passwordTextDidEnd)
            .disposed(by: disposeBag)

        signupView.nicknameTextField.rx.text.orEmpty
            .bind(to: viewModel.nicknameText)
            .disposed(by: disposeBag)

        signupView.nicknameTextField.rx
            .controlEvent(.editingDidBegin)
            .map { _ in () }
            .bind(to: viewModel.nicknameTextDidBegin)
            .disposed(by: disposeBag)

        signupView.nicknameTextField.rx
            .controlEvent(.editingDidEnd)
            .map { _ in () }
            .bind(to: viewModel.nicknameTextDidEnd)
            .disposed(by: disposeBag)

        signupView.completeSigninButton.rx.tap
            .bind(to: viewModel.completeBtnTap)
            .disposed(by: disposeBag)

        viewModel.wrongEmail
            .subscribe(onNext: { [weak self] wrong in
                if wrong {
                    self?.signupView.emailTextField.layer.borderColor = UIColor.red.cgColor
                    self?.signupView.invalidEmailLabel.isHidden = false
                } else {
                    self?.signupView.emailTextField.layer.borderColor = UIColor.black.cgColor
                    self?.signupView.invalidEmailLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        viewModel.wrongPassword
            .subscribe(onNext: { [weak self] wrong in
                if wrong {
                    self?.signupView.passwordTextField.layer.borderColor = UIColor.red.cgColor
                    self?.signupView.invalidPasswordLabel.isHidden = false
                } else {
                    self?.signupView.passwordTextField.layer.borderColor = UIColor.black.cgColor
                    self?.signupView.invalidPasswordLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        viewModel.wrongNickname
            .subscribe(onNext: { [weak self] wrong in
                if wrong {
                    self?.signupView.nicknameTextField.layer.borderColor = UIColor.red.cgColor
                    self?.signupView.invalidNicknameLabel.isHidden = false
                } else {
                    self?.signupView.nicknameTextField.layer.borderColor = UIColor.black.cgColor
                    self?.signupView.invalidNicknameLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        Observable
            .combineLatest(viewModel.emailValid, viewModel.passwordValid, viewModel.nicknameValid) { $0 && $1 && $2 }
            .skip(1)
            .subscribe(onNext: { [weak self] valid in
                if valid {
                    self?.signupView.completeSigninButton.backgroundColor = .systemPink
                    self?.signupView.completeSigninButton.isUserInteractionEnabled = true
                } else {
                    self?.signupView.completeSigninButton.backgroundColor = .lightGray
                    self?.signupView.completeSigninButton.isUserInteractionEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }
}

//struct SignUpForEmailViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        SignupWithEmailViewController().toPreview()
//    }
//}
