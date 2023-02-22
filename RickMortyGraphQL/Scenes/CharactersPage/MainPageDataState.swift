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
    case locationViewModelData([LocationCellViewModel])
    
    // MARK: - Properties
    
    var isLoading: Bool {
        switch self {
            case .loading:
                return true
            case .error,
                    .viewModelData, .locationViewModelData:
                return false
        }
    }
    
    var viewModelData: [CharacterCellViewModel]? {
        switch self {
            case .viewModelData(let data):
                return data
            case .error,
                    .loading, .locationViewModelData:
                return nil
        }
    }
    
    var characterDataError: CharactersDataError? {
        switch self {
            case .error(let characterDataError):
                return characterDataError
            case .loading,
                    .viewModelData, .locationViewModelData:
                return nil
        }
    }
    
    var locationViewModelData: [LocationCellViewModel]? {
        switch self {
            case .locationViewModelData(let data):
                return data
            case .loading, .viewModelData, .error:
                return nil
        }
    }
    
}

enum CharactersDataError: Error {
    
    // MARK: - Cases
    case failedRequest
    case invalidResponse
    case timeout
    
}
