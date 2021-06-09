//
//  PayPayAssignmentTests.swift
//  PayPayAssignmentTests
//
//  Created by Sawan Kumar on 08/06/21.
//

import XCTest
@testable import PayPayAssignment

class PayPayAssignmentTests: XCTestCase {

    var userInputInterface: UserInputScreenViewController?
    var userInputRouter: UserInputScreenRouter?
    var userInputViewModel: UserInputScreenViewModel?
    
    var persistence: PersistenceManager?
    
    var currencylistInterface: CurrencyListViewController?
    var currencylistRouter: CurrencyListRouter?
    var currencylistvm:CurrencyListViewModel?
    
    override func setUp() {
        userInputInterface = UserInputScreenViewController()
        userInputRouter = UserInputScreenRouter()
        userInputViewModel = UserInputScreenViewModel(interface: userInputInterface!, router: userInputRouter!)
        
        persistence = PersistenceManager(.userDefault)
        persistence?.save(100, for: "1")
        
        currencylistInterface = CurrencyListViewController()
        currencylistRouter = CurrencyListRouter()
        currencylistvm = CurrencyListViewModel(interface: currencylistInterface!, router: currencylistRouter!)
    }
    
    override func tearDown() {
        userInputInterface = nil
        userInputRouter = nil
        userInputViewModel = nil
        
        persistence = nil
        persistence?.delete(for: "1")
        
        currencylistInterface = nil
        currencylistRouter = nil
        currencylistvm = nil
    }

    func testCurrencyConversionEqual() throws {
        let sut = userInputViewModel?.currencyConverter.convert(1, valueCurrency: "USD", outputCurrency: "INR")
        XCTAssertEqual(sut!, 72, accuracy: 1)
    }
    
    func testCurrencyConversionNotEqual() throws {
        let sut = userInputViewModel?.currencyConverter.convert(1, valueCurrency: "USD", outputCurrency: "INR")
        XCTAssertNotEqual(sut!, 20)
    }

    func testPersistanceNilCheck_fail() throws {
        persistence?.delete(for: "1")
        let sut = persistence?.fetch(for: "1")
        XCTAssertNil(sut)
    }
    
    func testPersistanceNotNilCheck_pass() throws {
        let sut = persistence?.fetch(for: "1")
        XCTAssertNotNil(sut)
    }
    
    func testCurrencyListFilterDataSource_pass() throws {
        currencylistvm?.dataSource = [CurrencyListModel.Currencies(code: "USD", country: "United States of America Dollar"),
                                      CurrencyListModel.Currencies(code: "INR", country: "Indian Rupees")]
        currencylistvm?.applyFilter("INR")
        XCTAssertNotNil(currencylistvm?.filteredDataSource)
    }
    
    func testCurrencyListFilterDataSource_fail() throws {
        currencylistvm?.applyFilter("USD")
        XCTAssertNil(currencylistvm?.filteredDataSource)
    }
    
    func testUserInputConversion_pass() throws {
        // As by default from: USD & to: INR ==> should be around 72.9 as of today 9 June 2021
        userInputViewModel?.userInput("1", tag: 0)
        let sut = userInputViewModel?.convert()
        XCTAssertEqual(sut!, 72.9, accuracy: 1)
    }
   
    func testUserInputConversion_fail() throws {
        // As input should be in digit but i have pass letter which means it will return nil as it can't convert to double.
        userInputViewModel?.userInput("q", tag: 0)
        let sut = userInputViewModel?.convert()
        XCTAssertNil(sut)
    }
}
