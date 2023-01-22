//
//  ObjectExtension.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 22.01.2023.
//

import Foundation
import RealmSwift

extension Object {
    
    
    /// Gets the same attributes from target struct object
    ///  - Parameter object: Object which will import to itself
    ///  - Returns: None
    convenience init<T: Codable>(structObject: T) {
        self.init()
        let mirror = Mirror(reflecting: self)
        var attributes = [String]()
        for child in mirror.children {
            let label = child.label?.dropFirst()
            if let strLabel = label?.description {
                attributes.append(strLabel)
            }
        }
        // which is _id
        attributes.removeFirst()
        
        
        let mirror2 = Mirror(reflecting: structObject)
        for child in mirror2.children {
            if let label = child.label {
                if attributes.contains(label) {
                    self.setValue(child.value, forKey: label)
                }
            }
        }
    }
    
    func getFromStruct<T: Codable>(structObject: T.Type) {
        let mirror = Mirror(reflecting: self)
        var attributes = [String]()
        for child in mirror.children {
            let label = child.label?.dropFirst()
            if let strLabel = label?.description {
                attributes.append(strLabel)
            }
        }
        // which is _id
        attributes.removeFirst()
        
        
        let mirror2 = Mirror(reflecting: structObject)
        for child in mirror2.children {
            if let label = child.label {
                if attributes.contains(label) {
                    self.setValue(child.value, forKey: label)
                }
            }
        }
    }
}
