import Foundation
import RxSwift
import RxCocoa

protocol SignupForEmailType {
    // input
    var emailText: AnyObserver<String> { get }
    var passwordText: AnyObserver<String> { get }
    var nicknameText: AnyObserver<String> { get }

    var emailTextDidBegin: AnyObserver<Void> { get }
    var passwordTextDidBegin: AnyObserver<Void> { get }
    var nicknameTextDidBegin: AnyObserver<Void> { get }

    var emailTextDidEnd: AnyObserver<Void> { get }
    var passwordTextDidEnd: AnyObserver<Void> { get }
    var nicknameTextDidEnd: AnyObserver<Void> { get }

    var completeBtnTap: AnyObserver<Void> { get }

    // output
    var wrongEmail: Observable<Bool> { get }
    var wrongPassword: Observable<Bool> { get }
    var wrongNickname: Observable<Bool> { get }
    var emailValid: Observable<Bool> { get }
    var passwordValid: Observable<Bool> { get }
    var nicknameValid: Observable<Bool> { get }
}

class SignupForEmailViewModel: SignupForEmailType {
    var disposeBag = DisposeBag()

    let emailText: AnyObserver<String>
    let emailTextDidBegin: AnyObserver<Void>
    let emailTextDidEnd: AnyObserver<Void>

    let passwordText: AnyObserver<String>
    let passwordTextDidBegin: AnyObserver<Void>
    let passwordTextDidEnd: AnyObserver<Void>

    var nicknameText: AnyObserver<String>
    var nicknameTextDidBegin: AnyObserver<Void>
    var nicknameTextDidEnd: AnyObserver<Void>

    let completeBtnTap: AnyObserver<Void>

    let wrongEmail: Observable<Bool>
    let wrongPassword: Observable<Bool>
    let wrongNickname: Observable<Bool>

    let emailValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let nicknameValid: Observable<Bool>

    init(model: ValidForEmailPassword = SignupForEmailModel()) {
        let emailTexting = BehaviorSubject<String>(value: "")
        let emailInputDidBegin = PublishSubject<Void>()
        let emailInputDidEnd = PublishSubject<Void>()
        let showWrongEmail = BehaviorSubject<Bool>(value: false)
        let emailValidating = BehaviorSubject<Bool>(value: false)

        let passwordTexting = BehaviorSubject<String>(value: "")
        let passwordInputDidBegin = PublishSubject<Void>()
        let passwordInputDidEnd = PublishSubject<Void>()
        let showWrongPassword = BehaviorSubject<Bool>(value: false)
        let passwordValidating = BehaviorSubject<Bool>(value: false)

        let nicknameTexting = BehaviorSubject<String>(value: "")
        let nicknameInputDidBegin = PublishSubject<Void>()
        let nicknameInputDidEnd = PublishSubject<Void>()
        let showWrongNickname = BehaviorSubject<Bool>(value: false)
        let nicknameValidating = BehaviorSubject<Bool>(value: false)

        let tappedCompleteBtn = PublishSubject<Void>()

        //MARK: - Email Handling
        emailText = emailTexting.asObserver()
        emailTextDidBegin = emailInputDidBegin.asObserver()
        emailTextDidEnd = emailInputDidEnd.asObserver()
        wrongEmail = showWrongEmail
        emailValid = emailValidating

        emailTexting
            .map(model.checkEmailValid)
            .subscribe(onNext: emailValidating.onNext)
            .disposed(by: disposeBag)

        emailInputDidBegin
            .subscribe(onNext: { _ in showWrongEmail.onNext(false) })
            .disposed(by: disposeBag)

        emailInputDidEnd
            .withLatestFrom(emailTexting)
            .map(model.checkEmailValid)
            .subscribe(onNext: { valid in
                showWrongEmail.onNext(!valid)
                emailValidating.onNext(valid)
            })
            .disposed(by: disposeBag)

        //MARK: - Password Handling
        passwordText = passwordTexting.asObserver()
        passwordTextDidBegin = passwordInputDidBegin.asObserver()
        passwordTextDidEnd = passwordInputDidEnd.asObserver()
        wrongPassword = showWrongPassword
        passwordValid = passwordValidating

        passwordTexting
            .map(model.checkPasswordValid)
            .subscribe(onNext: passwordValidating.onNext)
            .disposed(by: disposeBag)

        passwordInputDidBegin
            .subscribe(onNext: { _ in showWrongPassword.onNext(false) })
            .disposed(by: disposeBag)

        passwordInputDidEnd
            .withLatestFrom(passwordTexting)
            .map(model.checkPasswordValid)
            .subscribe(onNext: { valid in
                showWrongPassword.onNext(!valid)
                passwordValidating.onNext(valid)
            })
            .disposed(by: disposeBag)

        //MARK: - Nickname Handling
        nicknameText = nicknameTexting.asObserver()
        nicknameTextDidBegin = nicknameInputDidBegin.asObserver()
        nicknameTextDidEnd = nicknameInputDidEnd.asObserver()
        wrongNickname = showWrongNickname
        nicknameValid = nicknameValidating

        nicknameTexting
            .map(model.checkNickname)
            .subscribe(onNext: nicknameValidating.onNext)
            .disposed(by: disposeBag)

        nicknameInputDidBegin
            .subscribe(onNext: { _ in showWrongNickname.onNext(false) })
            .disposed(by: disposeBag)

        nicknameInputDidEnd
            .withLatestFrom(nicknameTexting)
            .map(model.checkNickname)
            .subscribe(onNext: { valid in
                showWrongNickname.onNext(!valid)
                nicknameValidating.onNext(valid)
            })
            .disposed(by: disposeBag)

        completeBtnTap = tappedCompleteBtn.asObserver()

        tappedCompleteBtn
            .withLatestFrom(Observable.combineLatest(emailTexting, passwordTexting) { email, _ in
                model.testing(email)
            })
//            .map(model.testing)
            .subscribe(onNext: { _ in
                print("Tapped")
            })
            .disposed(by: disposeBag)

//        tappedCompleteBtn
//            .withLatestFrom(Observable.combineLatest(emailTexting, passwordTexting, nicknameTexting) { email, password, nickname in
//                model.saveSignupInfo(email: email, password: password, nickname: nickname)
//            })
//            .subscribe(onNext: { _ in
//                print("Completed")
//            })
//            .disposed(by: disposeBag)

    }
}
