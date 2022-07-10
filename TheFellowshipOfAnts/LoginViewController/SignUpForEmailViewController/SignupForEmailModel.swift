import Foundation

protocol ValidForEmailPassword {
    func checkEmailValid(_ email: String) -> Bool
    func checkPasswordValid(_ password: String) -> Bool
    func saveEmailPassword(email: String, password: String)
}

struct SignupForEmailModel: ValidForEmailPassword {
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

    func saveEmailPassword(email: String, password: String) {

    }
}
