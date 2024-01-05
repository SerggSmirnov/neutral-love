//
//  FavoritesViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    private let favoritesView = FavoritesView()
    private var viewModel: FavoritesViewModelProtocol {
        didSet {
            favoritesView.viewModel = viewModel
        }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        embedView()
        setupFavoritesViewConstraints()
        
        viewModel.fetchedResultController =
        viewModel.coreDataManager.createPreparedFetchedResultsController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateCollectionViewWithCachedData()
        favoritesView.collectionView.reloadData()
    }

    // MARK: Init
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup View and Constraints

private extension FavoritesViewController {
    func embedView() {
        view.addSubview(favoritesView)
    }

    func setupFavoritesViewConstraints() {
        NSLayoutConstraint.activate([
            favoritesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            favoritesView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            favoritesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
