//
//  CurrencyListProtocols.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import Foundation

//MARK: Router -
protocol CurrencyListRouterProtocol: AnyObject {
    func pop(_ code:String)
}
//MARK: ViewModel -
protocol CurrencyListViewModelProtocol: CurrencyListViewDelegate {
    func fetch()
}

//MARK: View -
protocol CurrencyListViewProtocol: AnyObject {
    var viewModel: CurrencyListViewModelProtocol?  { get set }
    func updateUI(with data:CurrencyListModel)
    func showErrorUI(with title:String, message:String)
}

protocol CurrencyListViewDelegate: CurrencyListDelegate {}

protocol CurrencyListDelegate: AnyObject {
    func didSelectCurrency(_ code:String)
}
