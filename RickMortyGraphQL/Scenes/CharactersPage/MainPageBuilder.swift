//
//  CharactersPageBuilder.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 24.01.2023.
//

import Foundation
import UIKit

final class CharactersPageBuilder {
    static func create(navigationController: UINavigationController) -> MainPageViewController {
        let viewModel = MainPageViewModel()
        let coordinator = MainPageCoordinator(navigationController: navigationController)
        let vc = MainPageViewController(viewModel: viewModel, coordinator: coordinator)
        return vc
    }
}
