//
//  EpisodeItem.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import SwiftUI

struct EpisodeItem: View {

  @EnvironmentObject var vm: DetailViewModel

  var name: String
  var airDate: String
  var episode: String

    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 16)
          .frame(width: 327, height: 80)
          .foregroundColor(.fiolet)
        VStack {
          Text("\(name)")
          HStack {
            Text(episode)
            Text(airDate)
          }
        }
      }
    }
}
