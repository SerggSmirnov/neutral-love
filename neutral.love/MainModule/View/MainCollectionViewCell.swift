//
//  MainCollectionViewCell.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 17.10.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    
    private let generatedImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.on.rectangle.angled")
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemGray2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
}

// MARK: - Bind image

extension MainCollectionViewCell {
    
    func bindImage(urlString: String) {
        generatedImage.load(urlString: urlString)
    }
}

// MARK: - Set Constraints

extension MainCollectionViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Configure

extension MainCollectionViewCell {
    
    private func configure() {
        contentView.backgroundColor = Resources.Colors.MainModule.mainCollectionCellBackground
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}

// MARK: - SetupViews

extension MainCollectionViewCell {
    
    private func setupViews() {
        contentView.addSubview(generatedImage)
        generatedImage.frame = contentView.frame
    }
}

// MARK: - mainCollectionViewCellIdentifier

extension String {
    static let mainCollectionViewCellIdentifier = "MainCollectionViewCell"
}
