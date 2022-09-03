import Foundation
import RxSwift
import RxCocoa
import FirebaseAuth

protocol ValidForEmailPassword {
    func checkEmailValid(_ email: String) -> Bool
    func checkPasswordValid(_ password: String) -> Bool
    func checkNickname(_ nickname: String) -> Bool
    func saveSignupInfo(email: String, password: String, nickname: String)
    func testing(_ email: String)
}

struct SignupWithEmailModel: ValidForEmailPassword {
    func checkEmailValid(_ email: String) -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return predicate.evaluate(with: email)
    }

    func checkPasswordValid(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[@$!%*#?&]).{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)

        return predicate.evaluate(with: password)
    }

    func checkNickname(_ nickname: String) -> Bool {
        let nicknameRegEx = "^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)

        return predicate.evaluate(with: nickname)
    }

    func saveSignupInfo(email: String, password: String, nickname: String) {
        print("email: \(email)")
        print("password: \(password)")
        print("nickname: \(nickname)")
    }

    func testing(_ email: String) {
        print("email: \(email)")
    }
}
