//
//  DetailCoordinator.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import SwiftUI

final class DetailCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []

  var rootViewController: UIViewController?

  var oneResult: Result?

    func start() {
        let vm = DetailViewModel(coordinator: self)
        let detailViewController = UIHostingController(rootView: DetailView(viewModel: vm))
        rootViewController = detailViewController

    }
}
