//
//  UIImageView + extensions.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 26.10.2023.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        let url = URL(string: urlString)
        
        guard let url else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
