//
//  CurrencyListModel.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

struct CurrencyListModel:Codable {
    let success:Bool
    private let currencies:[String:String]
    
    var list:[Currencies] {
        return currencies.map({CurrencyListModel.Currencies(code: $0.key, country: $0.value)})
    }
    
    struct Currencies:Codable {
        let code:String
        let country:String
    }
    
}


//{
//    "success": true,
//    "terms": "https://currencylayer.com/terms",
//    "privacy": "https://currencylayer.com/privacy",
//    "currencies": {
//        "AED": "United Arab Emirates Dirham",
//        "AFN": "Afghan Afghani",
//        "ALL": "Albanian Lek",
//        "AMD": "Armenian Dram",
//        "ANG": "Netherlands Antillean Guilder",
//        [...]
//    }
//}
