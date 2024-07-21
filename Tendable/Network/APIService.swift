//
//  APIService.swift
//  Tendable
//
//  Created by Ayush Jain on 21/07/24.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidData
    case requestFailed
}

protocol APIServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func register(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func startInspection(completion: @escaping (Result<Inspection, Error>) -> Void)
    func submitInspection(inspection: Inspection, completion: @escaping (Result<Bool, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    let baseURL = "http://localhost:5001/api"
    
    func register(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: Any] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    func startInspection(completion: @escaping (Result<Inspection, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/inspections/start")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let inspection = try? JSONDecoder().decode(InspectionContainer.self, from: data) else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            completion(.success(inspection.inspection))
        }.resume()
    }
    
    func submitInspection(inspection: Inspection, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/inspections/submit")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = try? JSONEncoder().encode(["inspection": inspection])
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
}
