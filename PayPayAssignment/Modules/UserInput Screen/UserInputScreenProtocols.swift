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
    var selectCurrency:((String)->())? { get set }
}

//MARK: ViewModel -
protocol UserInputScreenViewModelProtocol: UserInputScreenViewDelegate {
    func fetch()
}


//MARK: View -
protocol UserInputScreenViewProtocol: AnyObject {
    var viewModel: UserInputScreenViewModelProtocol?  { get set }
    func updateUI(with data:UserInputScreenModel)
    func showErrorUI(with title:String, message:String)
    func selectedCurrency(_ code:String)
    func shouldShowLoader(_ flag:Bool)
}

protocol UserInputScreenViewDelegate: AnyObject {
    func selectCurrency()
    func userInput(_ input:String)
}
