//
//  MainCoordinator.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit

final class MainCoordinator: Coordinator {
  var rootViewController: UINavigationController?
  var childCoordinators: [Coordinator] = []
  var oneResult: Result?

  func start() {
    let vm = MainViewModel(coordinator: self)
    let view = MainViewController(viewModel: vm)
    rootViewController = UINavigationController(rootViewController: view)
  }
  func toDeatail() {
    let detailCoordinator = DetailCoordinator()
    detailCoordinator.start()
    childCoordinators.append(detailCoordinator)
    guard let vc = detailCoordinator.rootViewController else { return }
    self.rootViewController?.pushViewController(vc, animated: true)
    detailCoordinator.oneResult = oneResult
  }

  func element(result: Result?) {
    oneResult = result
  }
}
