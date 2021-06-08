//
//  CurrencyListRouter.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class CurrencyListRouter: CurrencyListRouterProtocol {

    weak var viewController: UIViewController?
    weak static var delegate:CurrencyListDelegate?
    
    static func createModule(_ delegate:CurrencyListDelegate) -> UIViewController {
        self.delegate = delegate
        let view = CurrencyListViewController()
        let router = CurrencyListRouter()
        let viewModel = CurrencyListViewModel(interface: view, router: router)

        view.viewModel = viewModel
        router.viewController = view

        return view
    }
    
    func pop(_ code:String) {
        CurrencyListRouter.delegate?.didSelectCurrency(code)
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
