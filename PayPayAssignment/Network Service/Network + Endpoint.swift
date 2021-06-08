//
//  Network + Endpoint.swift
//  PayPayAssignment
//

//

import Foundation

struct NSEndpoint {
    static func get(_ endpoint:String) -> String {
        return Config.baseUrl + endpoint
    }
}
