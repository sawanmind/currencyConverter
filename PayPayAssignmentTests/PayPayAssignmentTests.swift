//
//  PayPayAssignmentTests.swift
//  PayPayAssignmentTests
//
//  Created by Sawan Kumar on 08/06/21.
//

import XCTest
@testable import PayPayAssignment

class PayPayAssignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrencyConversionEqual() throws {
        let interface = UserInputScreenViewController()
        let router = UserInputScreenRouter()
        let vm = UserInputScreenViewModel(interface: interface, router: router)
        //let sut = vm.convert(amount: 10, rate:7)
        XCTAssertEqual(sut, 70)
    }
    
    func testCurrencyConversionNotEqual() throws {
        let interface = UserInputScreenViewController()
        let router = UserInputScreenRouter()
        let vm = UserInputScreenViewModel(interface: interface, router: router)
        //let sut = vm.convert(amount: 10, rate:7)
        XCTAssertNotEqual(sut, 20)
    }


}
