//
//  MainViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 05.10.2023.
//

import UIKit

protocol MainViewControllerCoordinator: AnyObject {
    func didTapGenerateSettingsButton()
}

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: MainViewModelProtocol
    private weak var coordinator: MainViewControllerCoordinator?
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collection.register(MainCollectionViewCell.self,
                            forCellWithReuseIdentifier: .mainCollectionViewCellIdentifier)
        collection.register(UICollectionViewCell.self,
                            forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = Resources.Colors.backgroundGray
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        collection.delaysContentTouches = false
        collection.contentInsetAdjustmentBehavior = .never
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 4 // from view model
        control.addTarget(self,
                          action: #selector(pageControlDidChange(_:)),
                          for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var generateSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Resources.Colors.MainModule.generateButtonBackground
        button.setTitle(Resources.Strings.MainModule.generateSettingsButtonEnabled, for: .normal)
        button.layer.cornerRadius = 15
        button.titleLabel?.font = Resources.Fonts.SFProTextSemibold17
        button.tintColor = Resources.Colors.white
        button.addTarget(self, action: #selector(presentGenerateViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0 %"
        label.font = Resources.Fonts.SFProTextSemibold17
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    // MARK: - Init
    
    init(viewModel: MainViewModelProtocol, coordinator: MainViewControllerCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelagates()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = Resources.Colors.backgroundGray
        progressLabel.isHidden = true
        progressBar.isHidden = true
        
        [
            mainCollectionView,
            pageControl,
            generateSettingsButton,
            progressLabel,
            progressBar
        ].forEach { view.addSubview($0) }
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        mainCollectionView.setContentOffset(
            CGPoint(
                x: CGFloat(currentPage) * (mainCollectionView.frame.width),
                y: 0
            ),
            animated: true
        )
    }
    
    @objc private func presentGenerateViewController() {
        coordinator?.didTapGenerateSettingsButton()
        
        viewModel.textPercentages.bind { [weak self] in
            self?.progressLabel.text = $0
        }
        
        viewModel.progresPercentages.bind { [weak self] in
            self?.progressBar.progress = $0
        }
        
        viewModel.generateButtonIsEnabled.bind { [weak self] isEnabled in
            self?.generateSettingsButton.isEnabled = isEnabled
            
            if isEnabled {
                self?.generateSettingsButton.setTitle(
                    Resources.Strings.MainModule.generateSettingsButtonEnabled,
                    for: .normal
                )
            } else {
                self?.generateSettingsButton.setTitle(
                    Resources.Strings.MainModule.generateSettingsButtonNotEnabled,
                    for: .normal
                )
            }
        }
        
        viewModel.progressUIIsHidden.bind { [weak self] in
            self?.progressLabel.isHidden = $0
            self?.progressBar.isHidden = $0
        }
    }
    
    private func setDelagates() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        viewModel.delegate = self
    }
}

// MARK: - Setup Constraints

private extension MainViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainCollectionView.widthAnchor.constraint(
                equalToConstant: view.frame.width - Constants.mainCollectionViewSpacing * 2
            ),
            mainCollectionView.heightAnchor.constraint(
                equalToConstant: view.frame.width - Constants.mainCollectionViewSpacing * 2
            ),
            mainCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: view.frame.height / 9
            ),
            
            pageControl.topAnchor.constraint(equalTo: mainCollectionView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: Constants.pageControlHeigth),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 5),
            progressLabel.leadingAnchor.constraint(equalTo: mainCollectionView.leadingAnchor),
            progressLabel.widthAnchor.constraint(equalToConstant: 55),
            
            progressBar.centerYAnchor.constraint(equalTo: progressLabel.centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 10),
            progressBar.trailingAnchor.constraint(equalTo: mainCollectionView.trailingAnchor),
            
            generateSettingsButton.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: Constants.generateButtonTop),
            generateSettingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateSettingsButton.heightAnchor.constraint(equalToConstant: Constants.generateButtonHeight),
            generateSettingsButton.widthAnchor.constraint(equalToConstant: Constants.generateButtonWidth)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int( ( Float(mainCollectionView.contentOffset.x) / Float(mainCollectionView.frame.width) ) )
        pageControl.currentPage = page
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.outputs.count > 0 ? viewModel.outputs.count : 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainCollectionView.dequeueReusableCell(
            withReuseIdentifier: .mainCollectionViewCellIdentifier,
            for: indexPath
        ) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        if viewModel.outputs.isNotEmpty {
            let previewUrlString = viewModel.outputs[indexPath.row].preview
            let fullUrlString = viewModel.outputs[indexPath.row].full
            let caption = viewModel.outputs[indexPath.row].caption
            
            viewModel.saveImageInDatabase(caption: caption,
                                          preview: previewUrlString,
                                          full: fullUrlString)
                   
            cell.bindImage(collectionView,
                           withURL: previewUrlString,
                           atIndexPath: indexPath,
                           viewModel: viewModel)
        }
       
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: mainCollectionView.frame.width,
               height: mainCollectionView.frame.height)
    }
}

// MARK: - MainViewModelProtocolDelegate

extension MainViewController: MainViewModelProtocolDelegate {
    func didLoadData() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}

// MARK: - Constants

extension MainViewController {
    
    private enum Constants {
        static let generateButtonCornerRadius: CGFloat = 15
        static let generateButtonTop: CGFloat = 20
        static let generateButtonHeight: CGFloat = 50
        static let generateButtonWidth: CGFloat = 200
        static let mainCollectionViewSpacing: CGFloat = 20
        static let pageControlHeigth: CGFloat = 40
    }
}
