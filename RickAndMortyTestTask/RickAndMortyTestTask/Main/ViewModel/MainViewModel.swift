//
//  MainViewModel.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {

    init(coordinator: Coordinator) {
        self.coordinator = coordinator as! MainCoordinator
        getMainData()
    }

    private let coordinator: MainCoordinator

    private let api = ApiManager()

    @Published var result = [Result]()

  var oneResult: Result?

    var cancellable = Set<AnyCancellable>()

  func didTapDetail() {
    coordinator.toDeatail()
  }

  func setup(result: Result) {
    oneResult = result
    coordinator.element(result: oneResult)
  }
}

extension MainViewModel {
    private func getMainData() {
        api.getMain().sink { [weak self] welcome in
            self?.result = welcome.results
        }
        .store(in: &cancellable)
    }
}
