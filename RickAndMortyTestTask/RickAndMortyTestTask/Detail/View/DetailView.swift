//
//  DetailView.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import SwiftUI

struct DetailView: View {

  @ObservedObject var viewModel: DetailViewModel

  var body: some View {

    VStack {
      Image(uiImage: getImageData(from: viewModel.result))
        .resizable()
        .frame(width: 148, height: 148)
      Text("\(viewModel.result?.name ?? "")" )
      Text("\(viewModel.result?.status ?? "")")
      HStack {
        Text("Info")
          .font(Font.system(size: 17, weight: .bold))
          .foregroundColor(.black)
        Spacer()

      }
      .padding(.leading, 24)
      ZStack {
        RoundedRectangle(cornerRadius: 16)
          .frame(width: 327, height: 124)
          .foregroundColor(.fiolet)
        VStack {
          HStack {
            Text("Species:")
              .foregroundColor(.white)
            Text("\(viewModel.result?.species ?? "")")
              .foregroundColor(.white)
            Spacer()
          }
          .padding(.leading, 40)
          HStack {
            Text("Type:")
              .foregroundColor(.white)
            Text("\(viewModel.result?.type ?? "")")
              .foregroundColor(.white)
            Spacer()
          }
          .padding(.leading, 40)
          .padding(.top, 10)
          HStack {
            Text("Gender:")
              .foregroundColor(.white)
            Text("\(viewModel.result?.gender ?? "")")
              .foregroundColor(.white)
            Spacer()
          }
          .padding(.leading, 40)
          .padding(.top, 10)
        }
      }
      HStack {
        Text("Origin")
          .font(Font.system(size: 17, weight: .bold))
          .foregroundColor(.black)
        Spacer()

      }
      .padding(.leading, 24)
      ZStack {
        RoundedRectangle(cornerRadius: 16)
          .frame(width: 327, height: 80)
          .foregroundColor(.fiolet)
        HStack() {
          RoundedRectangle(cornerRadius: 10)
            .frame(width: 64, height: 64)
            .foregroundColor(.darkFiolet)
          Spacer()
        }
        .padding(.leading, 42)
        HStack {
          Image("Planet")
          Spacer()
        }
        .padding(.leading, 62)
        HStack {
          VStack {
            Text("\(viewModel.result?.location.name ?? "")")
              .font(Font.system(size: 17, weight: .bold))
            Text("Planet")
              .foregroundColor(.green)
              .font(Font.system(size: 13, weight: .medium))
              .padding(.top, 8)
          }
          .padding(.leading, 125)
          Spacer()
        }
      }
      HStack {
        Text("Origin")
          .font(Font.system(size: 17, weight: .bold))
          .foregroundColor(.black)
        Spacer()
      }
      .padding(.leading, 24)
    }
    ScrollView(.horizontal, showsIndicators: false) {
      ForEach(viewModel.result?.episode ?? [Episode(name: "", episode: "", id: 0, airDate: "")], id: \.self) { episode in
        EpisodeItem(name: episode.name, airDate: episode.airDate, episode: episode.episode)
      }
    }
    .frame(height: 1800)
  }

  func getImageData(from image: Result?) -> UIImage {
    if let data = image?.imageData {
          return UIImage(data: data) ?? UIImage()
      }
      return UIImage()
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(viewModel: DetailViewModel(coordinator: DetailCoordinator()))
  }
}
