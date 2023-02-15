//
//  ErrorLogging.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 22.01.2023.
//

import Foundation

enum ErrorTypes {
    case attributeError(String)
    case RealmErrorTypes(RealmErrorTypes)
    
    var description: String {
        switch self {
            case .attributeError: return "\(self.value) attribute could not found."
            case .RealmErrorTypes: return self.value
        }
    }
    
    var value: String {
        switch self {
            case .attributeError(let value): return value
            case .RealmErrorTypes(let value): return value.description
        }
    }
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

enum HTTPError: Equatable {
    case statusCode(Int)
    case invalidResponse
}

extension HTTPError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Error: 401", comment: "401")
        case .statusCode(let int):
            return String(int)
        }
    }
}
