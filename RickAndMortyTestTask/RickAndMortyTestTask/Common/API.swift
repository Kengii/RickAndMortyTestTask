//
//  API.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit
import Combine

protocol API {
  func getMain() -> AnyPublisher<Welcome, Never>
}

final class ApiManager: API {
  init() {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self.decoder = decoder
  }

  let decoder: JSONDecoder

  func getMain() -> AnyPublisher<Welcome, Never> {
    let link = "https://rickandmortyapi.com/api/character"
    guard let url = URL(string: link) else {
      return Just(Welcome(results: [])).eraseToAnyPublisher()
    }

    return URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: Welcome.self, decoder: decoder)
      .replaceError(with: Welcome(results: []))
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
