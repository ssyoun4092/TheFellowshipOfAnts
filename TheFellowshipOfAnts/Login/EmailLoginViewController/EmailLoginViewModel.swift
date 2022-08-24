import Foundation
import RxSwift
import RxCocoa

class EmailLoginViewModel {
    let disposeBag = DisposeBag()
    let emailInput = BehaviorSubject<String>(value: "")
    let passwordInput = BehaviorSubject<String>(value: "")
    let emailValid = BehaviorSubject<Bool>(value: false)
    let passwordValid = BehaviorSubject<Bool>(value: false)

    init() {
        emailInput
            .map(checkEmailValid)
            .bind(to: emailValid)
            .disposed(by: disposeBag)
    }

    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }

    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 6
    }
}
