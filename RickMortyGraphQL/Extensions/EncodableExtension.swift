//
//  EncodableExtension.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 22.01.2023.
//

import Foundation

extension Encodable {
    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}
