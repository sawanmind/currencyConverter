//
//  ConversionTableViewCell.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 09/06/21.
//

import Foundation
import UIKit

class ConversionTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupUI(){
        self.contentView.addSubview(currencyCodeLabel)
        currencyCodeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        currencyCodeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        currencyCodeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        self.contentView.addSubview(exchangeRateLabel)
        exchangeRateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        exchangeRateLabel.topAnchor.constraint(equalTo: self.currencyCodeLabel.bottomAnchor, constant: 10).isActive = true
        exchangeRateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        exchangeRateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func updateUI(code:String, rate:String) {
        let _code = "Currency Code: ".customize(color: UIColor.black.withAlphaComponent(0.7), font: .preferredFont(forTextStyle: .title3))
        _code.append(code.customize(color: .black, font: .boldSystemFont(ofSize: 16)))
        currencyCodeLabel.attributedText = _code
        
        let _rate = "Exchange Rate: ".customize(color: UIColor.black.withAlphaComponent(0.7), font: .preferredFont(forTextStyle: .title3))
        _rate.append(rate.customize(color: .black, font: .boldSystemFont(ofSize: 16)))
        exchangeRateLabel.attributedText = _rate
    }
    
    private let currencyCodeLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.preferredFont(forTextStyle: .title3)
        instance.textAlignment = .left
        instance.textColor = UIColor.black.withAlphaComponent(0.7)
        instance.text = "Currency Code:"
        return instance
    }()
    
    private let exchangeRateLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.font = UIFont.preferredFont(forTextStyle: .title3)
        instance.textAlignment = .left
        instance.textColor = UIColor.black.withAlphaComponent(0.7)
        instance.text = "Exchange Rate:"
        return instance
    }()

}
