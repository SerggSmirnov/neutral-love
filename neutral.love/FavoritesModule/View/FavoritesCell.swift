//
//  FavoritesCell.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    static let cellIdentifier: String = .favoritesCellIdentifier

    private let savedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Resources.Colors.MainModule.mainCollectionCellBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        embedView()
        setupAppearence()
        setupSavedImageConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind image
    
    func bind(image: Data?) {
        guard let image else { return }
        
        savedImage.image = UIImage(data: image)
    }
}

// MARK: - Setup Appearence

extension FavoritesCell {
    private func setupAppearence() {
        layer.cornerRadius = 5
        clipsToBounds = true
    }
}

// MARK: - Setup View and Constraints

private extension FavoritesCell {
    func embedView() {
        contentView.addSubview(savedImage)
    }

    func setupSavedImageConstraints() {
        NSLayoutConstraint.activate([
            savedImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            savedImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            savedImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            savedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
