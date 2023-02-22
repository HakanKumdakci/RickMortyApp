//
//  CharactersCoordinator.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 27.01.2023.
//

import Foundation


class MainPageCoordinator: Coordinator {
    
}

extension MainPageCoordinator: MainPageCoordinatorProtocol {
    
    func navigateToCharacterDetail(data: Character) {
        
    }
    
    
    func navigate(_ output: MainPageCoordinatorOutput) {
        switch output {
            case .toCharacterDetail(let data):
                let vc = CharacterDetailBuilder.create(navigation: self.navigationController, data: data)
                navigationController.pushViewController(vc, animated: true)
            case .toLocation(let data):
//                let vc = CharacterDetailBuilder.create(navigation: self.navigationController, data: data)
//                navigationController.pushViewController(vc, animated: true)
                return
        }
    }
}
