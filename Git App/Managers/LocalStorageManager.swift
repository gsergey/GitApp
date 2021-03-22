//
//  LocalStorageManager.swift
//  Git App
//
//  Created by Sergey Galagan on 21.03.2021.
//

import Foundation


class LocalStorageManager {
    let lastPageNumber: String = "lastPageNumber"
    
    static let sharedInstance = LocalStorageManager()
    var manager:UserDefaults = UserDefaults(suiteName: "GitApp")!
    
    func storeLastPageNumber(_ pageNumber: Int) {
        manager.set(pageNumber, forKey: lastPageNumber)
        manager.synchronize()
    }
    
    func getLastPageNumber() -> Int {
        let pageNumber:Int = manager.integer(forKey: lastPageNumber)
        guard pageNumber >= 0 else {
            return 0
        }
        
        return pageNumber
    }
    
    func clearData() {
        manager.removeSuite(named: "GitApp")
        manager.synchronize()
    }
}
