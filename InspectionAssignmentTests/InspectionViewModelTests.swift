//
//  InspectionViewModelTests.swift
//  InspectionAssignmentTests
//
//  Created by Sanjay Raskar on 22/07/24.
//

@testable import InspectionAssignment
import XCTest

final class InspectionViewModelTests: XCTestCase {
    var inspectionViewModel: InspectionViewModel!
    var mockInspectionService: MockInspectionService = MockInspectionService()
    
    @MainActor override func setUpWithError() throws {
        inspectionViewModel = InspectionViewModel(inspectionService: mockInspectionService)
    }

    override func tearDownWithError() throws {
        inspectionViewModel = nil
    }

    @MainActor
    func testStartInspectionSuccess() async throws {
        mockInspectionService.result = true
        await inspectionViewModel.startInspection()
        XCTAssertTrue((inspectionViewModel.inspection != nil))
    }
    
    @MainActor
    func testSubmitInspectionSuccess() async throws {
        mockInspectionService.result = true
        await inspectionViewModel.submitInspection()
        XCTAssertTrue(inspectionViewModel.error.isEmpty)
    }

}
