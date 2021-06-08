//
//  Network + Endpoint.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

struct NSEndpoint {
    static func get(_ endpoint:String) -> String {
        return Config.baseUrl + endpoint
    }
}
