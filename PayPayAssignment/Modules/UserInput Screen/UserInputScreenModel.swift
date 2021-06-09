//
//  UserInputScreenModel.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

struct UserInputScreenModel:Codable {
    let success:Bool?
    let quotes:[String:Double]?
    let error:ErrorModel?
  
    struct Rate:Codable {
        let code:String
        let rate:String
    }
    
}
