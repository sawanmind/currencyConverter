//
//  App + Error.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

enum AppError: Error, CustomStringConvertible {
    case parsingError
    
    var description: String {
        switch self {
       
        case .parsingError:
            return "Something went wrong while parsing data"
        }
    }
}

struct ErrorModel:Codable {
    let code:Int?
    let info:String?
}
