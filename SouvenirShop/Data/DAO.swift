//
//  DAO.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


protocol DAO {
    
    associatedtype T: Codable
    
    func collection() -> [T]
    func persist(object: T)
    func eraseAll()
}

class UserDefaultsDAO<P: Codable>: DAO {
    
    typealias T = P
    
    func collection() -> [P] {
        return collection(for: K.DAO.Cards)
    }
    
    func eraseAll() {
        erase(for: K.DAO.Cards)
    }
    
    func persist(object: P) {
        persist(object: object, key: K.DAO.Cards)
    }
    
    func collection(for key: String, defaults: UserDefaults = .standard) -> [P] {
        if let data = defaults.object(forKey: key) as? Data,
            let collection = try? JSONDecoder().decode([P].self, from: data) {
            return collection
        }
        return []
    }
    
    func persist(object: P, key: String, defaults: UserDefaults = .standard) {
        var array = collection(for: key, defaults: defaults)
        array.append(object)
        let encodedData = try? JSONEncoder().encode(array)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
    
    func erase(for key: String, defaults: UserDefaults = .standard) {
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}

