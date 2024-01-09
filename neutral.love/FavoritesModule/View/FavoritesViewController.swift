//
//  FavoritesViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import UIKit

protocol FavoritesViewControllerCoordinator: AnyObject {
    func didTapCollectionViewCell()
}

final class FavoritesViewController: UIViewController {
    private var viewModel: FavoritesViewModelProtocol
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.createLayout(for: section)
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: .favoritesCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedView()
        setupAppearence()
        setupConstraints()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.imagesFromDatabase = viewModel.coreDataManager.obtainSavedImages()
        collectionView.reloadData()
    }

    // MARK: Init
    init(viewModel: FavoritesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.delegate = self
    }
    
    private func setupAppearence() {
        view.backgroundColor = Resources.Colors.backgroundGray
        collectionView.backgroundColor = Resources.Colors.backgroundGray
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

// MARK: - Setup View and Constraints

private extension FavoritesViewController {
    func embedView() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imagesFromDatabase.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .favoritesCellIdentifier,
            for: indexPath
        ) as? FavoritesCell else {
            return UICollectionViewCell()
        }
        
        let previewImageData = viewModel.imagesFromDatabase[indexPath.row].preview
        cell.bind(image: previewImageData)

        return cell
    }
}

// MARK: - FavoritesViewModelDelegate

extension FavoritesViewController: FavoritesViewModelDelegate {
    func didLoadImages() {
        collectionView.reloadData()
    }
}

// MARK: - String extension

extension String {
    static let favoritesCellIdentifier = "FavoritesCell"
}
