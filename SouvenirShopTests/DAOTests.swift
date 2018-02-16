//
//  SouvenirShopTests.swift
//  SouvenirShopTests
//
//  Created by Sergey Klimov on 12.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import XCTest
@testable import SouvenirShop

class DAOTests: XCTestCase {
    
    let defaults = UserDefaults(suiteName: "Test")!
    let dbKey = "TestKey"
    
    override func setUp() {
        super.setUp()
        
        defaults.removeObject(forKey: dbKey)
    }
    
    func testWriteToDB() {
        let testString = "Test"
        let dao = UserDefaultsDAO<String>()
        
        dao.persist(object: testString, key: dbKey, defaults: defaults)
        let resultString = readDromDB()
        
        XCTAssertEqual(testString, resultString)
    }
    
    func testReadFromDB() {
        let testString = "Test"
        let dao = UserDefaultsDAO<String>()
        
        persist(string: testString)
        let dbCollection = dao.collection(for: dbKey, defaults: defaults)
        
        XCTAssertEqual([testString], dbCollection)
    }
    
    func testEraseDB() {
        let testString = "Test"
        let dao = UserDefaultsDAO<String>()
        
        persist(string: testString)
        dao.erase(for: dbKey, defaults: defaults)
        let resultString = readDromDB()
        
        XCTAssertNil(resultString)
    }
    
    private func persist(string: String) {
        let array = [string]
        let encodedData = try? JSONEncoder().encode(array)
        defaults.set(encodedData, forKey: dbKey)
        defaults.synchronize()
    }
    
    private func readDromDB() -> String? {
        if let data = defaults.object(forKey: dbKey) as? Data,
            let collection = try? JSONDecoder().decode([String].self, from: data),
            let obj = collection.first {
            return obj
        }
        return nil
    }
}
