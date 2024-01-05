//
//  APIManager.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 24.10.2023.
//

import Foundation

final class APIManager {
    
    private let token = "v1.729f88cb97cb903e3543779cba57a4e6fad127114887e20b32563635af355e2b"
    
    // MARK: - Fetch Order ID
    
    func fetchOrderID(prompt: String,
                      style: String,
                      layout: String,
                      amount: String) async throws -> String {
        let parameters = [
            "style": style,
            "layout": layout,
            "amount": Int(amount) ?? 4,
            "isPublic": true,
            "isPriority": false,
            "isHd": false,
            "steps": 30,
            "cfgScale": 7.5,
            "autoClean": false,
            "prompt": prompt
        ] as [String: Any]
        
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(token)"
        ]
        
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = URL(string: "https://api.neural.love/v1/ai-art/generate") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(OrderID.self, from: data).orderID
    }
    
    // MARK: - Fetch Info Output
    
    func fetchOrderInfoOutput(orderID: String) async throws -> [Output] {
        let headers = [
            "accept": "application/json",
            "authorization": "Bearer \(token)"
        ]
        
        let delay: UInt64 = 120
        
        try await Task.sleep(nanoseconds: delay * 1_000_000_000) // wait for a response from  GET request
        print("Time remaining: \(delay)")
        
        guard let url = URL(string: "https://api.neural.love/v1/ai-art/orders/\(orderID)") else {
            throw URLError(.badURL)
        }
        
        print("!!!------stringID: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(OrderInfo.self, from: data).output
        
        print("!!!------output: \(result)")
        
        return result
    }
    
    // MARK: - Fetch Data from string URL
    
    func fetchData(url: String) async throws -> Data? {
        guard let url = URL(string: url) else { return nil }
        
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
