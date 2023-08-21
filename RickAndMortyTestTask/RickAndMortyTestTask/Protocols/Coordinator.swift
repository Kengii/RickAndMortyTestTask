//
//  Coordinator.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit

protocol Coordinator {
  var childCoordinators: [Coordinator] { get set }

  func start()
}
