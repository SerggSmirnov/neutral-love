//
//  NetworkingError.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 10.11.2023.
//

import Foundation

enum NetworkingError: Error {
    case badUrl
    case badRequest
    case badResponse
}
