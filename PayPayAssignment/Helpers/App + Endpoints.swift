//
//  App + Endpoints.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

enum Endpoint: String {
    case list
    case live
    
    var get: String {
        switch self {
       
        case .list:
            return "list"
        case .live:
            return "live"
        }
    }
}
