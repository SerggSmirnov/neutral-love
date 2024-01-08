//
//  FavoritesView.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import UIKit

final class FavoritesView: UIView, UICollectionViewDelegate {
    var viewModel: FavoritesViewModelProtocol?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.createLayout(for: section)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: .favoritesCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        setupDelegates()
        embedView()
        setupCollectionViewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel?.delegate = self
    }

    private func createLayout(for section: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return section
    }
}

// MARK: - Setup Appearence

extension FavoritesView {
    private func setupAppearence() {
        backgroundColor = Resources.Colors.backgroundGray
        collectionView.backgroundColor = Resources.Colors.backgroundGray
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup View and Constraints

private extension FavoritesView {
    func embedView() {
        addSubview(collectionView)
    }

    func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = viewModel?.fetchedResultController?.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .favoritesCellIdentifier,
            for: indexPath
        ) as? FavoritesCell else {
            return UICollectionViewCell()
        }
        
        let previewImageData = viewModel?.fetchedResultController?.object(at: indexPath).preview
        cell.bind(image: previewImageData)

        return cell
    }
}

// MARK: - FavoritesViewModelDelegate

extension FavoritesView: FavoritesViewModelDelegate {
    func didLoadImages() {
        collectionView.reloadData()
    }
}

// MARK: - String extension

extension String {
    static let favoritesCellIdentifier = "FavoritesCell"
}
