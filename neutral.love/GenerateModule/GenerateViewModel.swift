//
//  GenerateViewModel.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 21.10.2023.
//

import Foundation

protocol GenerateViewModelProtocol {
    var style: [String] { get }
    var layout: [String] { get }
    var amount: [String] { get }
}

final class GenerateViewModel: GenerateViewModelProtocol {
    var style = ["Photo", "Fantasy", "Anime", "Painting", "Sci-Fi", "Cyberpunk", "Pixelart", "Steampunk", "Synthwave"]
    var layout = ["Square", "Vertical", "Horizontal"]
    var amount = ["4", "8", "12"]
}
