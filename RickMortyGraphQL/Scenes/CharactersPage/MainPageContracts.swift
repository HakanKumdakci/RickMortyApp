//
//  MainPageViewModelContracts.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 21.02.2023.
//

import Foundation
import Combine


protocol MainPageCoordinatorProtocol {
    func navigate(_ output: MainPageCoordinatorOutput)
    func navigateToCharacterDetail(data: Character)
}

enum MainPageCoordinatorOutput {
    case toCharacterDetail(Character)
    case toLocation(Location)
}


enum MainPageSection: CaseIterable {
    case characters
    case locations
    case episodes
    
    var desctiption: String {
        switch self {
            case .characters:
                return "Characters"
            case .locations:
                return "Locations"
            case .episodes:
                return "Episodes"
        }
    }
}
