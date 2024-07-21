//
//  TendableTests.swift
//  TendableTests
//
//  Created by Ayush Jain on 21/07/24.
//

import XCTest
@testable import Tendable

class TendableTests: XCTestCase {
    var apiService: MockAPIService!
    var viewModel: InspectionListViewModel!

    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
        viewModel = InspectionListViewModel(apiService: apiService)
    }

    func testLogin() {
        let expectation = self.expectation(description: "Login")
        apiService.mockLoginResult = .success(true) // Mock success response
        
        apiService.login(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Login failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testRegister() {
        let expectation = self.expectation(description: "Register")
        apiService.mockRegisterResult = .success(true) // Mock success response
        
        apiService.register(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Register failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testStartInspection() {
        let expectation = self.expectation(description: "Start Inspection")
        let inspection = Inspection(id: 1, inspectionType: InspectionType(id: 1, name: "Type", access: "Access"), area: Area(id: 1, name: "Area"), survey: Survey(id: 1, categories: []))
        apiService.mockStartInspectionResult = .success(inspection) // Mock success response
        
        apiService.startInspection { result in
            switch result {
            case .success(let inspection):
                XCTAssertNotNil(inspection)
            case .failure(let error):
                XCTFail("Start inspection failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testSubmitInspection() {
        let expectation = self.expectation(description: "Submit Inspection")
        let inspection = Inspection(id: 1, inspectionType: InspectionType(id: 1, name: "Type", access: "Access"), area: Area(id: 1, name: "Area"), survey: Survey(id: 1, categories: []))
        apiService.mockSubmitInspectionResult = .success(true) // Mock success response
        
        apiService.submitInspection(inspection: inspection) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Submit inspection failed: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
