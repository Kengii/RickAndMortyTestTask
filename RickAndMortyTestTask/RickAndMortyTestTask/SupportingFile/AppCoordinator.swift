//
//  AppCoordinator.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit

final class AppCoordinator: Coordinator {

  var rootViewController: UIViewController = UINavigationController()

  var childCoordinators: [Coordinator] = []

  let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  func start() {
    let mainCoordinator = MainCoordinator()
    mainCoordinator.start()
    self.childCoordinators = [mainCoordinator]
    window.rootViewController = mainCoordinator.rootViewController
    window.makeKeyAndVisible()
  }
}
