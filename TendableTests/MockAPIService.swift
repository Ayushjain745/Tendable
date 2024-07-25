//
//  MockAPIService.swift
//  TendableTests
//
//  Created by Ayush Jain on 21/07/24.
//

import XCTest
@testable import Tendable

class MockAPIService: APIServiceProtocol {
    var mockLoginResult: Result<Bool, Error> = .success(true)
    var mockRegisterResult: Result<Bool, Error> = .success(true)
    var mockStartInspectionResult: Result<Inspection, Error> = .success(Inspection(id: 1, inspectionType: InspectionType(id: 1, name: "Type", access: "Access"), area: Area(id: 1, name: "Area"), survey: Survey(id: 1, categories: [])))
    var mockSubmitInspectionResult: Result<Bool, Error> = .success(true)
    var mockfetchHistoryResult: Result<[Inspection], Error> = .success([Inspection(id: 1, inspectionType: InspectionType(id: 1, name: "Type", access: "Access"), area: Area(id: 1, name: "Area"), survey: Survey(id: 1, categories: []))])

    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(mockLoginResult)
    }

    func register(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(mockRegisterResult)
    }

    func startInspection(completion: @escaping (Result<Inspection, Error>) -> Void) {
        completion(mockStartInspectionResult)
    }

    func submitInspection(inspection: Inspection, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(mockSubmitInspectionResult)
    }
    
    func fetchHistory(completion: @escaping (Result<[Inspection], any Error>) -> Void) {
        completion(mockfetchHistoryResult)
    }
}
