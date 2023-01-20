//
//  Location.swift
//  GraphQLApp
//
//  Created by Hakan on 10.07.2022.
//

import Foundation


struct Location: Codable{
    var id: String?
    var name: String?
    var type: String?
    var dimension: String?
    var created: String?
}


struct LocationDetail: Decodable{
    var id: String?
    var name: String?
    var type: String?
    var dimension: String?
    var created: String?
    var residents: [Character]
}
