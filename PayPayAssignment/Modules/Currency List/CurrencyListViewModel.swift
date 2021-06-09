//
//  CurrencyListViewModel.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    weak private var view: CurrencyListViewProtocol?
    private let router: CurrencyListRouterProtocol
    private let service = NetworkService()
    var dataSource:[CurrencyListModel.Currencies]?
    var filteredDataSource:[CurrencyListModel.Currencies]?
    
    init(interface: CurrencyListViewProtocol, router: CurrencyListRouterProtocol) {
        self.view = interface
        self.router = router
    }

    func didSelectCurrency(_ code:String) {
        self.router.pop(code)
    }
}


extension CurrencyListViewModel {
    func fetch() {
        self.service.request(endpoint: Endpoint.list.get, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                if let model = data.decoder(with: CurrencyListModel.self) {
                    if let error = model.error {
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.showErrorUI(with: Config.errorTitle, message: error.info ?? Config.errorDefaultMessage)
                        }
                    }else {
                        self?.dataSource = model.list
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.updateUI()
                        }
                    }
                }else {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.showErrorUI(with: Config.errorTitle, message: AppError.parsingError.description)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showErrorUI(with: Config.errorTitle, message: error.description)
                }
            }
        }
    }
    
    func applyFilter(_ text:String) {
        self.filteredDataSource?.removeAll(keepingCapacity: false)
        var countries = self.dataSource?.filter({$0.country.localizedStandardContains(text)})
        let codes = self.dataSource?.filter({$0.code.localizedStandardContains(text)}) ?? []
        countries?.append(contentsOf: codes)
        self.filteredDataSource = countries
        self.view?.updateUI()
    }
}
