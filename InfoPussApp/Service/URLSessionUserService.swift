//
//  MainService.swift
//  InfoPussApp
//
//  Created by Juan Harrington on 26/02/23.
//

import Foundation
import Security

struct URLSessionCatsService: CatsService{
    let mainURL: URL = URL(string: "https://api.thecatapi.com/v1/breeds")!
    let apiKey: String = "bda53789-d59e-46cd-9bc4-2936630fde39"
    
    private let urlSession: URLSession = .shared
    
    private func log(request: URLRequest, response: URLResponse, data: Data) {
        if let httpResponse = response as? HTTPURLResponse {
            //print("response code for \(String(describing: request.url)): \(httpResponse.statusCode)")
            //print("boo\(httpResponse.description)")
        }
        
        let json = String(data: data, encoding: String.Encoding.utf8)
         //print("Response Body: \(String(describing: json))")
    }
    
    func fetchCatsInfo() async throws -> [CatsInfoModel]{
        var urlRequest = URLRequest(url: mainURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("API-KEY \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await urlSession.data(for: urlRequest)
        log(request: urlRequest, response: response, data: data)
        
        let decodeResponse = try JSONDecoder().decode([CatInfoJSONModel].self, from: data)
        
        return decodeResponse.map { CatsInfoModel(origin: $0.origin ?? "",
                                                  name: $0.name ?? "",
                                                  intelligence: $0.intelligence ?? 0,
                                                  vetstreet_url: $0.vetstreet_url ?? "") }
    }
}


