//
//  CharacterCellDataState.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 12.02.2023.
//

import Foundation

enum CharacterCellDataState {

    // MARK: - Cases
    
    case loading
    case data(Character)

    // MARK: - Properties
    
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        case .data:
            return false
        }
    }
    
    var characterData: Character? {
        switch self {
            case .data(let data):
            return data
        case .loading:
            return nil
        }
    }

}
