//
//  CurrencyListViewController.swift
//  PayPayAssignment
//
//  Created Sawan Kumar on 08/06/21.
//

import UIKit

class CurrencyListViewController: UIViewController, CurrencyListViewProtocol {

	var viewModel: CurrencyListViewModelProtocol?

    override func loadView() {
        super.loadView()
        setupUI()
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.startAnimating()
        self.viewModel?.fetch()
    }
    
    private lazy var loader:UIActivityIndicatorView = {
        let instance = UIActivityIndicatorView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.hidesWhenStopped = true
        instance.color = .gray
        instance.style = .medium
        return instance
    }()

    private lazy var containerView:CurrencyListView = {
        let instance = CurrencyListView()
        instance.delegate = self.viewModel
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.isHidden = true
        return instance
    }()
    
    private lazy var errorView:ErrorView = {
        let instance = ErrorView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.isHidden = true
        return instance
    }()
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Currency list"
        self.view.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(errorView)
        errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}


extension CurrencyListViewController {
    func updateUI(with data:CurrencyListModel) {
        self.loader.stopAnimating()
        self.errorView.isHidden = true
        self.containerView.isHidden = false
        self.containerView.updateUI(with: data)
    }
    
    func showErrorUI(with title:String, message:String) {
        self.loader.stopAnimating()
        self.containerView.isHidden = true
        self.errorView.isHidden = false
        self.errorView.updateUI(with: title, message: message)
    }
}
