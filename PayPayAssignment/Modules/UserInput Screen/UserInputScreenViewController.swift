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
        let instance = UserInputScreenView()
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
    func updateUI(with data:UserInputScreenModel) {
        self.containerView.updateUI(with: data)
    }
    
    func showErrorUI(with title:String, message:String) {
        self.containerView.showErrorUI(with: title, message: message)
    }
    
    func selectedCurrency(_ code:String) {
        self.containerView.selectedCurrency(code)
    }
    
    func shouldShowLoader(_ flag:Bool) {
        self.containerView.shouldShowLoader(flag)
    }
}
