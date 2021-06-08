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
    
    init(interface: CurrencyListViewProtocol, router: CurrencyListRouterProtocol) {
        self.view = interface
        self.router = router
    }

    func didSelectCurrency() {
        self.router.pop()
    }
}


extension CurrencyListViewModel {
    func fetch() {
        self.service.request(endpoint: Endpoint.list.get, method: .get) { [weak self] result in
            switch result {
            case .success(let data):
                if let model = data.decoder(with: CurrencyListModel.self) {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.updateUI(with: model)
                    }
                }else {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.showErrorUI(with: "Oops!", message: AppError.parsingError.description)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showErrorUI(with: "Oops!", message: error.description)
                }
            }
        }
    }
}
