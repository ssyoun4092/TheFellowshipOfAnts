import Foundation
import RxSwift
import RxCocoa

protocol SignupForEmailType {
    var emailText: AnyObserver<String> { get }
    var emailTextDidEnd: AnyObserver<Void> { get }
    var passwordText: AnyObserver<String> { get }
    var passwordTextDidEnd: AnyObserver<Void> { get }
    var completeBtnTap: PublishSubject<Void> { get }

    var emailCanValid: Observable<Bool> { get }
    var passwordCanValid: Observable<Bool> { get }
    var emailIsValid: Observable<Bool> { get }
    var passwordIsValid: Observable<Bool> { get }
}

class SignupForEmailViewModel: SignupForEmailType {
    var disposeBag = DisposeBag()

    let emailText: AnyObserver<String>
    let emailTextDidBegin = PublishSubject<Void>()
    let emailTextDidEnd: AnyObserver<Void>
    let passwordText: AnyObserver<String>
    let passwordTextDidBegin = PublishSubject<Void>()
    let passwordTextDidEnd: AnyObserver<Void>
    let completeBtnTap: PublishSubject<Void> = PublishSubject<Void>()

    let emailCanValid: Observable<Bool>
    let passwordCanValid: Observable<Bool>
    let emailIsValid: Observable<Bool>
    let passwordIsValid: Observable<Bool>
    let showMainPage: Observable<Void>

    init(model: ValidForEmailPassword = SignupForEmailModel()) {
        let validateEmail = PublishSubject<Void>()
        let emailTexting = BehaviorSubject<String>(value: "")
        let emailValidating = BehaviorSubject<Bool>(value: true)
        let emailIsValidating = BehaviorSubject<Bool>(value: false)
        let savingEmailPassword = PublishSubject<Void>()

        let validatePassword = PublishSubject<Void>()
        let passwordTexting = BehaviorSubject<String>(value: "")
        let passwordValidating = BehaviorSubject<Bool>(value: true)
        let passwordIsValidating = BehaviorSubject<Bool>(value: false)

        emailTextDidEnd = validateEmail.asObserver()
        emailText = emailTexting.asObserver()
        emailIsValid = emailIsValidating

        emailTextDidBegin
            .subscribe(onNext: { _ in emailValidating.onNext(true) })
            .disposed(by: disposeBag)

        validateEmail
            .withLatestFrom(emailTexting)
            .map(model.checkEmailValid)
            .subscribe(onNext: { valid in
                emailValidating.onNext(valid)
                emailIsValidating.onNext(valid)
            })
            .disposed(by: disposeBag)

        emailCanValid = emailValidating

        passwordTextDidEnd = validatePassword.asObserver()
        passwordText = passwordTexting.asObserver()
        passwordIsValid = passwordIsValidating

        passwordTextDidBegin
            .subscribe(onNext: { _ in passwordValidating.onNext(true) })
            .disposed(by: disposeBag)

        validatePassword
            .withLatestFrom(passwordTexting)
            .map(model.checkPasswordValid)
            .subscribe(onNext: { valid in
                passwordValidating.onNext(valid)
                passwordIsValidating.onNext(valid)
            })
            .disposed(by: disposeBag)

        passwordCanValid = passwordValidating
    }
}
