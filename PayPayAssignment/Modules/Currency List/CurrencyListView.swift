//
//  CurrencyListView.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation
import UIKit

class CurrencyListView: UIView, UISearchResultsUpdating {
    weak var delegate:CurrencyListViewDelegate?
    private var viewModel: CurrencyListViewModelProtocol?
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: CurrencyListViewModelProtocol?) {
        super.init(frame: .null)
        self.viewModel = viewModel
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }
    
    func insertSearchBar(_ searchBar: UISearchBar) {
        self.tableView.tableHeaderView = searchBar
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search using country name"
        searchController.searchBar.sizeToFit()
        self.insertSearchBar(searchController.searchBar)
        
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
        return self.searchController.isActive ? self.viewModel?.filteredDataSource?.count ?? 0 : self.viewModel?.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if let _datasource = self.searchController.isActive ? self.viewModel?.filteredDataSource : self.viewModel?.dataSource {
            cell.textLabel?.text = "\(_datasource[indexPath.row].code) - \(_datasource[indexPath.row].country)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _datasource = self.searchController.isActive ? self.viewModel?.filteredDataSource : self.viewModel?.dataSource {
            self.searchController.isActive = false
            self.delegate?.didSelectCurrency(_datasource[indexPath.row].code)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel?.applyFilter(searchController.searchBar.text ?? "")
    }
}
