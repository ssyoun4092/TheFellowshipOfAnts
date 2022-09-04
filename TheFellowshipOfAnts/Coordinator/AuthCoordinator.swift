//
//  AuthCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/03.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    weak var parentCoordinator: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func pushToEmailLoginVC() {
        let vc = EmailLoginViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func pushToSignupWithEmailVC() {
        let vc = SignupWithEmailViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func showTabBarVC() {
        parentCoordinator?.showTabBarVC()
    }

    func didFinishAuth() {
        parentCoordinator?.childDidFinish(self)
    }
}
