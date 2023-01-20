//
//  CharacterDetail.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 20.01.2023.
//

import Foundation


struct CharacterDetail: Codable {
    var id: String
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Location?
    var location: Location?
    var episode: [Episode]
    var created: String
    var image: String
}
