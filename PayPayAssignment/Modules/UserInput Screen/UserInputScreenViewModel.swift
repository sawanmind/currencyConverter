//
//  UserInputScreenViewModel.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class UserInputScreenViewModel: UserInputScreenViewModelProtocol {
    
    enum Sender {
        case from
        case to
    }
    
    weak private var view: UserInputScreenViewProtocol?
    private let router: UserInputScreenRouterProtocol
    
    private var latestInputVlaue:String = ""
    
    var dataSource: [UserInputScreenModel.Rate]?
    var isPersistenceEnabled: Bool = false
    lazy var currencyConverter = CurrencyConverter()
    private var valueCurrency:String = Config.defaultFromCurrencyCode
    private var outputCurrency:String = Config.defaultToCurrencyCode

    private var _fromCurrency:String = Config.defaultFromCurrencyCode
    private var _toCurrency:String = Config.defaultToCurrencyCode
    
    private var sender:Sender?
    
    init(interface: UserInputScreenViewProtocol, router: UserInputScreenRouterProtocol) {
        self.view = interface
        self.router = router
        self.currencyConverter.delegate = self
    }

    func refreshUI(exchangeRates: [String : Double]) {
        let _exchangeRates = exchangeRates.map({UserInputScreenModel.Rate.init(code: $0.key, rate: "$1 = " + String(format: "%0.2f ", $0.value) + $0.key)})
        self.dataSource = _exchangeRates
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.shouldShowLoader(false)
            
            if _exchangeRates.isEmpty {
                self?.view?.showErrorUI(with: Config.errorTitle, message: Config.errorDefaultMessage)
            }else {
                self?.view?.updateUI()
            }
        }
    }
    
    func fetch() {
        self.view?.shouldShowLoader(true)
        self.currencyConverter.fetchExchangeRates(self.isPersistenceEnabled)
    }

    func selectedCurrency(_ code: String) {
        if sender == .from {
            self._fromCurrency = code
            self.valueCurrency = _fromCurrency
            self.outputCurrency = _toCurrency
            self.view?.selectedFromCurrency(code)
        }else {
            self._toCurrency = code
            self.valueCurrency = _toCurrency
            self.outputCurrency = _fromCurrency
            self.view?.selectedToCurrency(code)
        }
        self.convert()
    }
 
    func didTapToSelectCurrency(_ tag:Int) {
        self.sender = tag == 0 ? .from : .to
        self.router.routeToCurrencyList()
    }
    
    func userInput(_ input:String, tag:Int) {
        if tag == 0 {
            self.sender = .from
            self.valueCurrency = _fromCurrency
            self.outputCurrency = _toCurrency
        }else {
            self.sender = .to
            self.valueCurrency = _toCurrency
            self.outputCurrency = _fromCurrency
        }
        self.latestInputVlaue = input
        self.convert()
    }
    
    func convert() {
        guard let value = Double(self.latestInputVlaue) else {
            self.view?.updateToExchangeRate("")
            self.view?.updateFromExchangeRate("")
            return}
        let val = currencyConverter.convert(value, valueCurrency: valueCurrency, outputCurrency: outputCurrency) ?? 0
        guard let _sender = sender else {return}
        switch _sender {
        case .from:
            self.view?.updateToExchangeRate(String(format: "%0.2f", val))
        case .to:
            self.view?.updateFromExchangeRate(String(format: "%0.2f", val))
        }
    }
}
