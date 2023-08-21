//
//  Result.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import Foundation

struct Welcome: Decodable {
//  let info: Info
  let results: [Result]
}

struct Info: Decodable {
  let count, pages: Int
  let next: String
  let prev: String?
}

struct Result: Decodable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let type: String
  let gender: String
  let origin, location: Location
  let image: URL?
  var imageData: Data?
  let episode: [Episode]
  let url: String
  let created: String

  enum CodingKeys: CodingKey {
    case id
    case name
    case status
    case species
    case type
    case gender
    case origin
    case location
    case image
    case imageData
    case episode
    case url
    case created
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.status = try container.decode(String.self, forKey: .status)
    self.species = try container.decode(String.self, forKey: .species)
    self.type = try container.decode(String.self, forKey: .type)
    self.gender = try container.decode(String.self, forKey: .gender)
    self.origin = try container.decode(Location.self, forKey: .origin)
    self.location = try container.decode(Location.self, forKey: .location)
    self.image = try container.decode(URL.self, forKey: .image)
    self.imageData = nil
    self.episode = try container.decode([Episode].self, forKey: .episode)
    self.url = try container.decode(String.self, forKey: .url)
    self.created = try container.decode(String.self, forKey: .created)

    if let url = self.image {
      let data = try? Data(contentsOf: url)
      self.imageData = data
    }
  }
}

struct Location: Decodable {
  let name: String
  let url: String
}

struct Episode: Decodable, Hashable {
  let name: String
  let episode: String
  let id: Int
  let airDate: String
}
