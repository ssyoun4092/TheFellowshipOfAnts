//
//  AppCoordinator.swift
//  TheFellowshipOfAnts
//
//  Created by SeYeong on 2022/09/01.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
