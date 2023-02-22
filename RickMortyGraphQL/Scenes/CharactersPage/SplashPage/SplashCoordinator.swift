//
//  SplashCoordinator.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 24.01.2023.
//

import Foundation

protocol SplashCoordinatorProtocol {
    func navigateToCharactersPage()
}

class SplashCoordinator : Coordinator, SplashCoordinatorProtocol  {
    
    func navigateToCharactersPage() {
        let vc = CharactersPageBuilder.create(navigationController: self.navigationController)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController.present(vc, animated: false)
    }
    
}
