//
//  UserInputScreenView.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation
import UIKit

class UserInputScreenView: UIView {
    weak var delegate:UserInputScreenViewDelegate?
    private var viewModel: UserInputScreenViewModelProtocol?
    
    init(viewModel: UserInputScreenViewModelProtocol?) {
        super.init(frame: .null)
        self.viewModel = viewModel
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI() {
        self.shouldShowLoader(false)
        self.errorView.isHidden = true
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func selectedToCurrency(_ code: String) {
        self.toSelectCurrencyCTA.setTitle(code, for: .normal)
    }
    
    func selectedFromCurrency(_ code: String) {
        self.fromSelectCurrencyCTA.setTitle(code, for: .normal)
    }
    
    func updateFromExchangeRate(_ value:String) {
        self.fromTextField.text = value
    }
    
    func updateToExchangeRate(_ value:String) {
        self.toTextField.text = value
    }
    
    func showErrorUI(with title:String, message:String) {
        self.shouldShowLoader(false)
        self.errorView.isHidden = false
        self.tableView.isHidden = true
        self.errorView.updateUI(with: title, message: message)
    }
    
    func shouldShowLoader(_ flag:Bool) {
        switch flag {
        
        case true:
            self.loader.startAnimating()
        case false:
            self.loader.stopAnimating()
        }
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        
        self.addSubview(fromStackView)
        fromStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        fromStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100).isActive = true
        fromStackView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5,constant: -50).isActive = true
        fromTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        fromSelectCurrencyCTA.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        self.addSubview(toStackView)
        toStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        toStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100).isActive = true
        toStackView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5,constant: -20).isActive = true
        toTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        toSelectCurrencyCTA.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    
        self.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: fromStackView.bottomAnchor,constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.addSubview(errorView)
        errorView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor).isActive = true
        errorView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        errorView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor).isActive = true
        errorView.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor).isActive = true
        
    }
    
    private lazy var fromStackView: UIStackView = {
        let instance = UIStackView(arrangedSubviews: [fromTitleLabel,fromTextField,fromSelectCurrencyCTA])
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.alignment = .fill
        instance.axis = .vertical
        instance.distribution = .fill
        instance.spacing = 10
        return instance
    }()
    
    private let fromTitleLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.preferredFont(forTextStyle: .title3)
        instance.textAlignment = .center
        instance.textColor = UIColor.black.withAlphaComponent(0.7)
        instance.text = "From"
        return instance
    }()
    
    private lazy var fromTextField:UITextField = {
        let instance = UITextField()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.borderStyle = .roundedRect
        instance.keyboardType = .decimalPad
        instance.textAlignment = .center
        instance.addTarget(self, action: #selector(observeTextField), for: .editingChanged)
        instance.addKeyboardManager(#selector(keyboardManager))
        instance.placeholder = "Enter Amount"
        instance.tag = 0
        return instance
    }()
    
    @objc private func keyboardManager() {
        dismissKeyboard()
    }
    
    private lazy var fromSelectCurrencyCTA:UIButton = {
        let instance = UIButton(type: .roundedRect)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.backgroundColor = .clear
        instance.setTitle("USD", for: .normal)
        instance.setImage(UIImage(named: "arrow"), for: .normal)
        instance.semanticContentAttribute = .forceRightToLeft
        instance.addTarget(self, action: #selector(didTapToSelectCurrency), for: .touchUpInside)
        instance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        instance.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 5)
        instance.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        instance.contentHorizontalAlignment = .center
        instance.tag = 0
        return instance
    }()
    
    private lazy var toStackView: UIStackView = {
        let instance = UIStackView(arrangedSubviews: [toTitleLabel,toTextField,toSelectCurrencyCTA])
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.alignment = .fill
        instance.axis = .vertical
        instance.distribution = .fill
        instance.spacing = 10
        return instance
    }()
    
    private let toTitleLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.preferredFont(forTextStyle: .title3)
        instance.textAlignment = .center
        instance.textColor = UIColor.black.withAlphaComponent(0.7)
        instance.text = "To"
        return instance
    }()
    
    private lazy var toTextField:UITextField = {
        let instance = UITextField()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.borderStyle = .roundedRect
        instance.keyboardType = .decimalPad
        instance.textAlignment = .center
        instance.addTarget(self, action: #selector(observeTextField), for: .editingChanged)
        instance.addKeyboardManager(#selector(keyboardManager))
        instance.placeholder = "Enter Amount"
        instance.tag = 1
        return instance
    }()
  
    private lazy var toSelectCurrencyCTA:UIButton = {
        let instance = UIButton(type: .roundedRect)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.backgroundColor = .clear
        instance.contentHorizontalAlignment = .center
        instance.setTitle("INR", for: .normal)
        instance.setImage(UIImage(named: "arrow"), for: .normal)
        instance.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        instance.semanticContentAttribute = .forceRightToLeft
        instance.addTarget(self, action: #selector(didTapToSelectCurrency), for: .touchUpInside)
        instance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        instance.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 5)
        instance.tag = 1
        return instance
    }()
    
    private lazy var tableView:UITableView = {
        let instance = UITableView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.dataSource = self
        instance.delegate = self
        instance.backgroundColor = .white
        instance.isHidden = true
        instance.register(ConversionTableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return instance
    }()
    
    
    private lazy var loader:UIActivityIndicatorView = {
        let instance = UIActivityIndicatorView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.hidesWhenStopped = true
        instance.color = .gray
        instance.style = .medium
        return instance
    }()

    
    private lazy var errorView:ErrorView = {
        let instance = ErrorView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.isHidden = true
        return instance
    }()
    
    @objc private func observeTextField(_ sender:UITextField) {
        self.delegate?.userInput(sender.text ?? "",tag: sender.tag)
    }
    
    @objc private func didTapToSelectCurrency(_ sender:UIButton) {
        self.delegate?.didTapToSelectCurrency(sender.tag)
    }
    
    
}

extension UserInputScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as? ConversionTableViewCell else {
            return UITableViewCell()
        }
        if let _datasource = self.viewModel?.dataSource {
            cell.updateUI(code: _datasource[indexPath.row].code,
                          rate: _datasource[indexPath.row].rate)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
