//
//  FavoritesViewModel.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import Foundation
import CoreData

protocol FavoritesViewModelDelegate: AnyObject {
    func didLoadImages()
}

protocol FavoritesViewModelProtocol {
    var coreDataManager: CoreDataManager { get set }
    var fetchedResultController: NSFetchedResultsController<GenerateImage>? { get set }
    var delegate: FavoritesViewModelDelegate? { get set }
    var indexPath: Box<IndexPath> { get set }
    
    func updateCollectionViewWithCachedData()
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    
    var indexPath: Box<IndexPath> = Box(IndexPath())
    var fetchedResultController: NSFetchedResultsController<GenerateImage>?
    var coreDataManager = CoreDataManager.shared
    weak var delegate: FavoritesViewModelDelegate?
    
    func updateCollectionViewWithCachedData() {
        do {
            try fetchedResultController?.performFetch()
        } catch {
            print("Fetch request failed with error: \(error)")
        }
    }
}
