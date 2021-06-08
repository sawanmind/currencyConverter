//
//  UserInputScreenViewModel.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class UserInputScreenViewModel: UserInputScreenViewModelProtocol {
    
    weak private var view: UserInputScreenViewProtocol?
    private let router: UserInputScreenRouterProtocol
    private let service = NetworkService()
    
    init(interface: UserInputScreenViewProtocol, router: UserInputScreenRouterProtocol) {
        self.view = interface
        self.router = router
        self.observeSelectedCurrency()
    }
    
    func fetch() {
        self.fetch("USD")
    }
    
    private func observeSelectedCurrency() {
        self.router.selectCurrency = { [weak self] code in
            self?.view?.selectedCurrency(code)
            self?.fetch(code)
        }
    }

    func selectCurrency() {
        self.router.routeToCurrencyList()
    }
    
    func userInput(_ input:String) {
        print(input)
    }
}


extension UserInputScreenViewModel {
    private func fetch(_ code:String) {
        self.view?.shouldShowLoader(true)
        self.service.request(query:[URLQueryItem(name: "source", value: code)],
                             endpoint: Endpoint.live.get, method: .get)
        { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.shouldShowLoader(false)
                }
                
                if let model = data.decoder(with: UserInputScreenModel.self) {
                    if let error = model.error {
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.showErrorUI(with: "Oops!", message: error.info ?? "Error not found")
                        }
                    }else {
                        DispatchQueue.main.async { [weak self] in
                            self?.view?.updateUI(with: model)
                        }
                    }
                }else {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.showErrorUI(with: "Oops!", message: AppError.parsingError.description)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.shouldShowLoader(false)
                    self?.view?.showErrorUI(with: "Oops!", message: error.description)
                }
            }
        }
    }
}
