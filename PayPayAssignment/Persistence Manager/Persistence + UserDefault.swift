//
//  Persistence + UserDefault.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation

extension UserDefaults: PersistenceProtocols {
    func save(_ item: Any, for key:String) {
        UserDefaults.standard.setValue(item, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func delete(for key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func update(_ item: Any, for key:String) {
        UserDefaults.standard.delete(for: key)
        UserDefaults.standard.save(item, for: key)
    }
    
    func fetch(for key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
}
