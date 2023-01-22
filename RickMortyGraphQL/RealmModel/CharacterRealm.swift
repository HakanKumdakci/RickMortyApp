//
//  CharacterRealm.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 20.01.2023.
//

import Foundation
import RealmSwift

class CharacterRealm: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var image: String = ""
}
