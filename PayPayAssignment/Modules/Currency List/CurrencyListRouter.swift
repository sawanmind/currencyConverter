//
//  CurrencyListRouter.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class CurrencyListRouter: CurrencyListRouterProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = CurrencyListViewController()
        let router = CurrencyListRouter()
        let viewModel = CurrencyListViewModel(interface: view, router: router)

        view.viewModel = viewModel
        router.viewController = view

        return view
    }
    
    func pop() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
