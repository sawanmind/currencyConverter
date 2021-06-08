//
//  Network + Utils.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation


extension Data {
    public func decoder<T:Decodable>(with model:T.Type) -> T? {
        do {
            var decoder: JSONDecoder {
                let decoder = JSONDecoder()
                return decoder
            }
   
            let item = try decoder.decode(model, from: self)
            return item
        }catch let error {
            var errorString:String = ""
            errorString += " "
            errorString += "========== Parsing Error ==========\n"
            errorString += " "
            errorString += "Failed to decode data to \(model) type due to following reason.\n"
            errorString += "\(error)"
            errorString += "\n================= ~ =================="
            errorString += " "
            #if DEBUG
                print(errorString)
            #endif
            return nil
        }
    }
}
