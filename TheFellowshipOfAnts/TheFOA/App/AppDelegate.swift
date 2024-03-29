import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [ : ]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            print("AuthAPI")

            return AuthController.handleOpenUrl(url: url)
        }

        return false
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        KakaoSDK.initSDK(appKey: "a637cb76c8001243e312de3d2051359b")
        FirebaseApp.configure()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

