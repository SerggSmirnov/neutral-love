//
//  APIModels.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 24.10.2023.
//

import Foundation

// MARK: - OrderID
struct OrderID: Decodable {
    let orderID: String
    let price: Price

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case price
    }
}

// MARK: - Price
struct Price: Decodable {
    let amount: String
    let currency: String
}

// MARK: - OrderInfo
struct OrderInfo: Decodable {
    let id: String
    let type: String
    let name: String
    let slug: String
    let dateCreated: Int
    let sortBy: String
    let status: Status
    let input: Input
    let output: [Output]
    let rating: Rating
    let isPack: Bool
    let thumbnails: [Thumbnail]
    let availabilityStatus: Int
    let availableUntil: Int
    let access: Access
}

// MARK: - Access
struct Access: Decodable {
    let canRemove: Bool
    let canFeedback: Bool
}

// MARK: - Input
struct Input: Decodable {
    let prompt: String
    let style: String
    let layout: String
    let sampler: String
    let cfgScale: Double
    let modelVersion: String
    let amount: Int
    let isPublic: Bool
    let isPriority: Bool
    let hasImage: Bool
    let isHD: Bool
    let negativePrompt: String
    let augmentedPrompt: String
    let steps: Int
    let seed: Int
    let customModelID: String
    let customModelName: String

    enum CodingKeys: String, CodingKey {
        case prompt, style, layout, sampler, cfgScale, modelVersion, amount, isPublic, isPriority, hasImage
        case isHD = "isHd"
        case negativePrompt, augmentedPrompt, steps, seed
        case customModelID = "customModelId"
        case customModelName
    }
}

// MARK: - Output
struct Output: Decodable {
    let id: String
    let type: Int
    let isNsfw: Bool
    let caption: String
    let qualityScore: Double
    let full: String
    let preview: String
    let style: String
}

// MARK: - Rating
struct Rating: Decodable {
    let total: Int
}

// MARK: - Status
struct Status: Decodable {
    let code: Int
    let text: String
    let level: String
    let isReady: Bool
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let url: String
    let outputItemID: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case url
        case outputItemID = "outputItemId"
        case width, height
    }
}
