//
//  CurrencyListView.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation
import UIKit

class CurrencyListView: UIView {
    weak var delegate:CurrencyListViewDelegate?
    private var dataSource = [CurrencyListModel.Currencies]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI(with data:CurrencyListModel) {
        self.dataSource = data.list
        self.tableView.reloadData()
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private lazy var tableView:UITableView = {
        let instance = UITableView(frame: .null, style: .insetGrouped)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.dataSource = self
        instance.delegate = self
        instance.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return instance
    }()
    
}

extension CurrencyListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) 
        cell.textLabel?.text = "\(self.dataSource[indexPath.row].code) - \(self.dataSource[indexPath.row].country)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
