//
//  RealmHelper.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 21.11.24.
//

import Foundation
import RealmSwift

final class RealmHelper {
    private init() {}
    private static let realm = try! Realm()
    
    // MARK: - Add Object
    
    static func addObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print("Error adding object: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update Object
    
    static func updateObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch let error {
            print("Error adding or updating object: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete Object
    
    static func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error {
            print("Error deleting object: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Delete All Objects of Type
    
    static func deleteAllObjects<T: Object>(_ type: T.Type) {
        do {
            try realm.write {
                let objects = realm.objects(type)
                realm.delete(objects)
            }
        } catch let error {
            print("Error deleting all objects of type \(type): \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Objects
    
    static func fetchObjects<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
    // MARK: - Fetch Object by Primary Key
    
    static func fetchObject<T: Object, KeyType>(_ type: T.Type, primaryKey: KeyType) -> T? {
        return realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    // MARK: - Update Object
    
    static func updateObject<T: Object>(_ object: T, updates: () -> Void) {
        do {
            try realm.write {
                updates()
            }
        } catch let error {
            print("Error updating object: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Configuration URL
    
    static func configURL() {
        print("Realm is located at:", realm.configuration.fileURL!)
    }
}
