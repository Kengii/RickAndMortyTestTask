//
//  MainViewController.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit
import Combine

class MainViewController: UIViewController {

  // MARK: Properties
  let api = ApiManager()

  private var viewModel: MainViewModel!
  private var cancellable = Set<AnyCancellable>()
  private lazy var collectionView: UICollectionView = {
    let it = UICollectionView(frame: self.view.frame, collectionViewLayout: self.layout)
    it.backgroundColor = #colorLiteral(red: 0.01813307218, green: 0.04795853049, blue: 0.1145337448, alpha: 1)

    it.delegate = self
    it.dataSource = self
    it.register(CollectionCellView.self, forCellWithReuseIdentifier: "cell")
    it.reloadData()
    view.addSubview(it)

    return it
  }()
  private lazy var layout: UICollectionViewFlowLayout = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let boundSize: CGSize = UIScreen.main.bounds.size
    layout.minimumLineSpacing = 18
    layout.minimumInteritemSpacing = 18
    layout.itemSize = CGSize(width: boundSize.width / 2.2, height: 202)

    return layout
  }()


  init(viewModel: MainViewModel) {
    super.init(nibName: nil, bundle: nil)
    self.viewModel = viewModel
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  deinit {
    cancellable.forEach { $0.cancel() }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    setupUI()
    setupConstraints()
  }
}

extension MainViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.didTapDetail()
    let result = viewModel.result[indexPath.row]
    viewModel.setup(result: result)
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}

extension MainViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard !viewModel.result.isEmpty else { return 0 }
    return viewModel.result.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CollectionCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCellView
    let result = viewModel.result[indexPath.row]

    cell.setup(with: result)


    return cell
  }

  func bind() {
    viewModel.$result
      .receive(on: DispatchQueue.main)
      .filter { !$0.isEmpty }
      .sink { @MainActor results in
      self.collectionView.reloadData()
    }
      .store(in: &cancellable)
  }

  private func setupConstraints() {
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  private func setupUI() {
    title = "Characters"
    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24, weight: .bold)]
    navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.01813307218, green: 0.04795853049, blue: 0.1145337448, alpha: 1)
  }
}
