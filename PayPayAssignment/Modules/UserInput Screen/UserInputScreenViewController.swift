//
//  UserInputScreenViewController.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class UserInputScreenViewController: UIViewController, UserInputScreenViewProtocol {

	var viewModel: UserInputScreenViewModelProtocol?

    override func loadView() {
        super.loadView()
        setupUI()
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.shouldShowLoader(true)
        self.viewModel?.fetch()
    }
 
    private lazy var containerView:UserInputScreenView = {
        let instance = UserInputScreenView(viewModel: self.viewModel)
        instance.delegate = self.viewModel
        instance.translatesAutoresizingMaskIntoConstraints = false
        return instance
    }()
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Currency Conversion"
       
        self.view.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}


extension UserInputScreenViewController {
    func updateUI() {
        self.containerView.updateUI()
    }
    
    func showErrorUI(with title:String, message:String) {
        self.containerView.showErrorUI(with: title, message: message)
    }
 
    func shouldShowLoader(_ flag:Bool) {
        self.containerView.shouldShowLoader(flag)
    }
    
    func selectedToCurrency(_ code: String) {
        self.containerView.selectedToCurrency(code)
    }
    
    func selectedFromCurrency(_ code: String) {
        self.containerView.selectedFromCurrency(code)
    }
    
    func updateFromExchangeRate(_ value:String) {
        self.containerView.updateFromExchangeRate(value)
    }
    
    func updateToExchangeRate(_ value:String) {
        self.containerView.updateToExchangeRate(value)
    }
}
