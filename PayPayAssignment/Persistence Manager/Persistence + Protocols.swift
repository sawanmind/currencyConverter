//
//  Persistence + Protocols.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

protocol PersistenceProtocols:AnyObject {
    func save(_ item:Any, for key:String)
    func delete(for key:String)
    func update(_ item:Any, for key:String)
    func fetch(for key:String) -> Any?
}

enum PersistenceType {
   case userDefault
}
