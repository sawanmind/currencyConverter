//
//  Network + Error.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case badURL
    case responseError(String?)
    case dataNotFound
    case failedToConvertPayloadToData(String?)
    
    var description: String {
        switch self {
       
        case .badURL:
            return "Invalid url. Please make sure you have complete url"
        case .responseError(let message):
            return message ?? "No message found"
        case .dataNotFound:
            return "Data not found or is nil"
        case .failedToConvertPayloadToData(let message):
            return "Failed to convert payload into data. Read more >>> \(message ?? "No message found")"
        }
    }
}
