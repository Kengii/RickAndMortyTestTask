//
//  MainCollectionViewCell.swift
//  RickAndMortyTestTask
//
//  Created by Владимир Данилович on 22.08.23.
//

import UIKit

class CollectionCellView: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    self.nameLabel.text = nil
    self.image.image = nil
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupUI()
  }

  private lazy var nameLabel: UILabel = {
    let it = UILabel()
    it.textColor = .white
    it.textAlignment = .center

    return it
  }()
  private lazy var image: UIImageView = {
    let it = UIImageView()
    it.contentMode = .scaleAspectFill

    return it
  }()

  private func setupConstraints() {
    let stack = UIStackView(arrangedSubviews: [image, nameLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 16

    addSubview(stack)

    stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
    stack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8).isActive = true
    stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    image.translatesAutoresizingMaskIntoConstraints = false
    image.topAnchor.constraint(equalTo: stack.topAnchor, constant: 8).isActive = true
    image.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -54).isActive = true
    image.rightAnchor.constraint(equalTo: stack.rightAnchor).isActive = true
    image.leadingAnchor.constraint(equalTo: stack.leadingAnchor).isActive = true
  }

  private func setupUI() {
    backgroundColor = #colorLiteral(red: 0.1501607299, green: 0.1651831865, blue: 0.2201651633, alpha: 1)
    layer.cornerRadius = 10
    clipsToBounds = true
    image.layer.cornerRadius = 10
    image.clipsToBounds = true
  }

  func setup(with result: Result) {
    nameLabel.text = result.name
    if let data = result.imageData, let image = UIImage(data: data) {
      self.image.image = image
    }
  }
}
