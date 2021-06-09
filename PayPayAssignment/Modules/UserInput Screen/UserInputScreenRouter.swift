//
//  UserInputScreenRouter.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class UserInputScreenRouter: UserInputScreenRouterProtocol, CurrencyListDelegate, UserInputScreenRouterOutputProtocol {
    
    weak var viewController: UIViewController?
    weak var viewModel: UserInputScreenViewModelProtocol?
    
    static func createModule() -> UIViewController {
        let view = UserInputScreenViewController()
        let router = UserInputScreenRouter()
        let viewModel = UserInputScreenViewModel(interface: view, router: router)
        
        viewModel.isPersistenceEnabled = true // This can configure as per requirement.
        router.viewModel = viewModel
        view.viewModel = viewModel
        router.viewController = view

        return view
    }
    
    func routeToCurrencyList() {
        let vc = CurrencyListRouter.createModule(self)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didSelectCurrency(_ code: String) {
        self.viewModel?.selectedCurrency(code)
    }
}
