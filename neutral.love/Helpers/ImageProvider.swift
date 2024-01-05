//
//  ImageProvider.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 19.12.2023.
//

import UIKit

final class ImageProvider {
    private var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(
        _ collectionView: UICollectionView,
        withURL urlString: String,
        atIndexPath indexPath: IndexPath,
        completion: @escaping (UIImage?) -> Void
    ) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else { return }
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                   let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    
                    DispatchQueue.main.async {
                        if let visibleIndexPath = collectionView.indexPathsForVisibleItems.first,
                           visibleIndexPath == indexPath {
                            completion(image)
                        }
                    }
                }
            }
        }
    }
}
