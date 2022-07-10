import Foundation
import RxSwift
import RxCocoa

class SignupForEmailViewModel {
    var disposeBag = DisposeBag()

    let emailInput = BehaviorSubject<String>(value: "")
    let emailValid = BehaviorSubject<Bool>(value: true)

    init() {
        emailInput
            .map(self.checkEmailValid)
            .subscribe(onNext: emailValid.onNext)
            .disposed(by: disposeBag)
    }

    private func checkEmailValid(_ email: String) -> Bool {
//        let pattern = "[A-Za-z0-9~!@#$%^&*]+@[A-Za-z0-9~!@#$%^&*]+\\.[A-Za-z],{2,64}"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
//        return predicate.evaluate(with: email) || email == ""

        let pattern = "[A-Za-z0-9~!@#$%^&*]+@[A-Za-z0-9~!@#$%^&*]+\\.[A-Za-z],{2,64}"
        if email.range(of: pattern, options: .regularExpression) == nil {
            return false
        } else {
            return true
        }
    }
}
