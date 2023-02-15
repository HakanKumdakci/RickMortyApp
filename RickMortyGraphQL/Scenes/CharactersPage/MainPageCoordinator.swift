//
//  CharactersCoordinator.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 27.01.2023.
//

import Foundation

protocol MainPageCoordinatorProtocol {
    func navigateToCharacterDetail(data: Character)
}


class MainPageCoordinator: Coordinator {
    
}

extension MainPageCoordinator: MainPageCoordinatorProtocol {
    func navigateToCharacterDetail(data: Character) {
        let vc = CharacterDetailBuilder.create(navigation: self.navigationController, data: data)
        navigationController.pushViewController(vc, animated: true)
    }
}
