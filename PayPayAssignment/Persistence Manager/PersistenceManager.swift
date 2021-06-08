//
//  PersistenceManager.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

class PersistenceManager: PersistenceProtocols {
    private var type:PersistenceType
    
    init(_ type:PersistenceType) {
        self.type = type
    }
    
    func save(_ item: Data, for key:String) {
        switch self.type {
        case .userDefault:
            UserDefaults.standard.save(item, for: key)
        }
    }
    
    func delete(for key:String) {
        switch self.type {
        case .userDefault:
            UserDefaults.standard.delete(for: key)
        }
    }
    
    func update(_ item: Data, for key:String) {
        switch self.type {
        case .userDefault:
            UserDefaults.standard.update(item, for: key)
        }
    }
    
    func fetch(for key:String) -> Data? {
        switch self.type {
        case .userDefault:
            return UserDefaults.standard.fetch(for: key)
        }
    }
}
