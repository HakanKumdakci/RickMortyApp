//
//  RealmManager.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 22.01.2023.
//

import Foundation
import RealmSwift

enum RealmErrorTypes {
    case realmObjectCouldNotFetched
    case realmObjectCouldNotCreated
    case realmObjectCouldNotDelete
    
    var description: String {
        switch self {
            case .realmObjectCouldNotFetched: return "dwd"
            case .realmObjectCouldNotCreated: return "dwdw"
            case .realmObjectCouldNotDelete: return "dwdwd"
        }
    }
    
}

protocol RealmServiceProtocol: AnyObject{
    func create<T: Object>(_ object: T)
    func delete<T: Object>(_ object: T)
    func get<T: Object>(_ object: T.Type) -> Results<T>?
}

class RealmService: RealmServiceProtocol {
    static let shared = RealmService()
    
    var realm: Realm?
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    convenience init(test: Bool = false) {
        if test{
            let x = Realm.Configuration(inMemoryIdentifier: "RickMortyGraphQLTest")
            do {
                self.init(realm: try Realm(configuration: x))
            }catch {
                self.init()
            }
        }
        do{
            self.init(realm: try Realm())
        } catch {
            self.init()
        }
    }
    
    func checkForAnyTypeOfObjectChanged() {
        
    }
    
    func create<T: Object>(_ object: T) {
        guard let realm = realm else { return }
        
        do {
            try realm.write{
                realm.add(object, update: .all)
            }
        } catch {
            Log.warning(ErrorTypes.RealmErrorTypes(.realmObjectCouldNotCreated).description)
        }
    }
    
    private func realmObjectToDictionary<T: Object>(_ object: T) -> [String: Any] {
        var dict = [String: Any]()
        for (key, value) in object.dictionaryWithValues(forKeys: Array(object.objectSchema.properties.map { $0.name })) {
            dict[key] = value
        }
        //below line to prevent key causing error while converting to json data
        dict["_id"] = nil
        return dict
    }
    
    func convertRealmObjectToStructs<T: Object, W: Codable>(_ object: T, targetType: W.Type) -> W? {
        do {
            var dict = realmObjectToDictionary(object)
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoder = JSONDecoder()
            let user = try! decoder.decode(W.self, from: jsonData)
            return user
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func updateObject<T: Object>(_ objectType: T.Type, id: String, changedValues: [String: Any]) {
        let values = self.get(objectType)
        
    }
    
    /// Deletes realm object
    ///  - Parameter object: Realm object to delete
    ///  - Returns: None
    func delete<T: Object>(_ object: T) {
        guard let realm = realm else {return }
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            Log.warning(ErrorTypes.RealmErrorTypes(.realmObjectCouldNotDelete).description)
        }
    }
    
    /// Fetches realm objects
    ///  - Parameter objectType: Search according to this parameter
    ///  - Returns: Gets all the objects according to parameter type, if couldn't find anything returns nil
    func get<T: Object>(_ object: T.Type) -> Results<T>? {
        guard let realm = realm else { return nil }
        
        return realm.objects(T.self).isEmpty ? nil : realm.objects(T.self)
    }
}
