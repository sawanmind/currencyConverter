//
//  CurrencyListModel.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

struct CurrencyListModel:Codable {
    let success:Bool?
    private let currencies:[String:String]?
    let error:ErrorModel?
    
    var list:[Currencies] {
        return currencies?.map({CurrencyListModel.Currencies(code: $0.key, country: $0.value)}) ?? []
    }
    
    struct Currencies:Codable {
        let code:String
        let country:String
    }
    
}
