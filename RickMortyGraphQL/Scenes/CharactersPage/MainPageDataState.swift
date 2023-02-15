//
//  CharacterDataState.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 26.01.2023.
//

import Foundation

enum CharacterDataState {
    
    // MARK: - Cases
    
    case loading
    case viewModelData([CharacterCellViewModel])
    case error(CharactersDataError)
    
    // MARK: - Properties
    
    var isLoading: Bool {
        switch self {
            case .loading:
                return true
            case .error,
                    .viewModelData:
                return false
        }
    }
    
    var viewModelData: [CharacterCellViewModel]? {
        switch self {
            case .viewModelData(let data):
                return data
            case .error,
                    .loading:
                return nil
        }
    }
    
    var characterDataError: CharactersDataError? {
        switch self {
            case .error(let characterDataError):
                return characterDataError
            case .loading,
                .viewModelData:
                return nil
        }
    }
    
}

enum CharactersDataError: Error {
    
    // MARK: - Cases
    case failedRequest
    case invalidResponse
    
}
