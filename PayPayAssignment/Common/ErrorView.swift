//
//  ErrorView.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation
import UIKit

class ErrorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateUI(with title:String, message:String) {
        self.titleLabel.text = title
        self.descLabel.text = message
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private lazy var stackView:UIStackView = {
        let instance = UIStackView(arrangedSubviews: [titleLabel, descLabel])
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.distribution = .fill
        instance.alignment = .fill
        instance.spacing = 8
        return instance
    }()
    
    private lazy var titleLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.numberOfLines = 0
        instance.lineBreakMode = .byWordWrapping
        instance.textAlignment = .center
        instance.textColor = UIColor.black
        instance.font = UIFont.preferredFont(forTextStyle: .headline)
        return instance
    }()
    
    private lazy var descLabel:UILabel = {
        let instance = UILabel()
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.numberOfLines = 0
        instance.lineBreakMode = .byWordWrapping
        instance.textAlignment = .center
        instance.textColor = UIColor.black.withAlphaComponent(0.65)
        instance.font = UIFont.preferredFont(forTextStyle: .body)
        return instance
    }()
    
}
