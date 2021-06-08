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
    private var dataSource = [UserInputScreenModel.Rate]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI(with data:UserInputScreenModel) {
        self.shouldShowLoader(false)
        self.errorView.isHidden = true
        self.tableView.isHidden = false
        self.dataSource = data.list
        self.tableView.reloadData()
        self.textField.becomeFirstResponder()
    }
    
    func selectedCurrency(_ code:String) {
        self.selectCurrencyCTA.setTitle(code, for: .normal)
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
        
        self.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        textField.topAnchor.constraint(equalTo: self.topAnchor,constant: 100).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.addSubview(selectCurrencyCTA)
        selectCurrencyCTA.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor,constant: 10).isActive = true
        selectCurrencyCTA.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 10).isActive = true
        selectCurrencyCTA.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        selectCurrencyCTA.heightAnchor.constraint(equalToConstant: 36).isActive = true
        selectCurrencyCTA.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        
        self.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: selectCurrencyCTA.bottomAnchor,constant: 15).isActive = true
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
    
    private lazy var textField:UITextField = {
        let instance = UITextField()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.borderStyle = .roundedRect
        instance.keyboardType = .decimalPad
        instance.textAlignment = .right
        instance.font = UIFont.preferredFont(forTextStyle: .headline)
        instance.addTarget(self, action: #selector(observeTextField), for: .editingChanged)
        instance.addKeyboardManager(#selector(keyboardManager))
        return instance
    }()
    
    @objc private func keyboardManager() {
        dismissKeyboard()
    }
    
    private lazy var selectCurrencyCTA:UIButton = {
        let instance = UIButton(type: .roundedRect)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.backgroundColor = .clear
        instance.setTitle("USD", for: .normal)
        instance.layer.borderWidth = 1
        instance.layer.borderColor = UIColor.gray.cgColor
        instance.setImage(UIImage(named: "arrow"), for: .normal)
        instance.semanticContentAttribute = .forceRightToLeft
        instance.addTarget(self, action: #selector(selectCurrency), for: .touchUpInside)
        instance.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        instance.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 5)
        return instance
    }()
    
    private lazy var tableView:UITableView = {
        let instance = UITableView()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.dataSource = self
        instance.delegate = self
        instance.backgroundColor = .white
        instance.isHidden = true
        instance.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
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
        self.delegate?.userInput(sender.text ?? "")
    }
    
    @objc private func selectCurrency(_ sender:UIButton) {
        self.delegate?.selectCurrency()
    }
    
    
}

extension UserInputScreenView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) 
        cell.textLabel?.text = "\(self.dataSource[indexPath.row].fromTo) - \(self.dataSource[indexPath.row].rate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
