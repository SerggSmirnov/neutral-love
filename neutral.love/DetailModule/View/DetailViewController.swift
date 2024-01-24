//
//  DetailViewController.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 08.01.2024.
//

import UIKit

protocol DetailViewControllerCoordinator: AnyObject {
    func showAlertSaveImageSuccess(to: UIViewController)
}

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: FavoritesViewModelProtocol
    private weak var coordinator: DetailViewControllerCoordinator?
    
    private var generatedImageFull: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.on.rectangle.angled")
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemGray2
        image.backgroundColor = Resources.Colors.MainModule.mainCollectionCellBackground
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Resources.Colors.MainModule.generateButtonBackground
        button.setTitle("Download image", for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = Resources.Fonts.SFProTextSemibold17
        button.tintColor = Resources.Colors.white
        button.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - downloadButtonPressed
    
    @objc private func downloadButtonPressed() {
        guard let image = generatedImageFull.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        coordinator?.showAlertSaveImageSuccess(to: self)
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        embedViews()
        setupConstraints()
        setupImage()
    }
    
    // MARK: Init
    init(viewModel: FavoritesViewModelProtocol,
         coordinator: DetailViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Embed Views
    
    private func embedViews() {
        view.addSubview(generatedImageFull)
        view.addSubview(downloadButton)
    }
    
    // MARK: - Setup Appearance
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.backgroundGray
    }
    
    // MARK: - Set image
    
    private func setupImage() {
        let indexPath = viewModel.indexPath.value
        guard let fullImageData = viewModel
            .fetchedResultController?
            .object(at: indexPath)
            .full else { return }
        
        generatedImageFull.image = UIImage(data: fullImageData)
    }
    
}

// MARK: - Set Constraints

extension DetailViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            generatedImageFull.widthAnchor.constraint(
                equalToConstant: view.frame.width - Constants.spacing * 2
            ),
            generatedImageFull.heightAnchor.constraint(
                equalToConstant: view.frame.width - Constants.spacing * 2
            ),
            generatedImageFull.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generatedImageFull.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: view.frame.height / 9
            ),
            
            downloadButton.topAnchor.constraint(equalTo: generatedImageFull.bottomAnchor, constant: 60),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
            downloadButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - Constants

extension DetailViewController {
    
    private enum Constants {
        static let spacing: CGFloat = 20
    }
}
