//
//  DetailViewModel.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {
  init(coordinator: Coordinator) {

    self.coordinator = coordinator as! DetailCoordinator
    self.element()
  }
  var result: Result?
  private let coordinator: DetailCoordinator


  func element() {
    result = coordinator.oneResult

  }
}

