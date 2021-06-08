//
//  UserInputScreenModel.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

struct UserInputScreenModel:Codable {
    let success:Bool?
    private let quotes:[String:Double]?
    let error:ErrorModel?
    
    var list:[Rate] {
        return quotes?.map({UserInputScreenModel.Rate(fromTo: $0.key, rate: String(format: "%.2f", $0.value))}) ?? []
    }
    
    struct Rate:Codable {
        let fromTo:String
        let rate:String
    }
    
}
