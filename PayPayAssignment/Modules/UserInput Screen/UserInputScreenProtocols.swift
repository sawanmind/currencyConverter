//
//  UserInputScreenProtocols.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import Foundation

//MARK: Router -
protocol UserInputScreenRouterProtocol: AnyObject {
    func routeToCurrencyList()
}

protocol UserInputScreenRouterOutputProtocol: AnyObject {
    var viewModel: UserInputScreenViewModelProtocol?  { get set }
}

//MARK: ViewModel -
protocol UserInputScreenViewModelProtocol: UserInputScreenViewDelegate, CurrencyConverterDelegate {
    func fetch()
    var dataSource:[UserInputScreenModel.Rate]? {get set}
    var isPersistenceEnabled:Bool {get set}
    func selectedCurrency(_ code:String)
}


//MARK: View -
protocol UserInputScreenViewProtocol: AnyObject {
    var viewModel: UserInputScreenViewModelProtocol?  { get set }
    func updateUI()
    func showErrorUI(with title:String, message:String)
    func selectedFromCurrency(_ code:String)
    func selectedToCurrency(_ code:String)
    func shouldShowLoader(_ flag:Bool)
    
    func updateFromExchangeRate(_ value:String)
    func updateToExchangeRate(_ value:String)
}

protocol UserInputScreenViewDelegate: AnyObject {
    func didTapToSelectCurrency(_ tag:Int)
    func userInput(_ input:String, tag:Int)
}
