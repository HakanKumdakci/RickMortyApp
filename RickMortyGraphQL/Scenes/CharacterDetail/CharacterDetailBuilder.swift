
//  CharacterDetailBuilder.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 15.02.2023.
//

import Foundation
import UIKit

final class CharacterDetailBuilder {
    static func create(navigation: UINavigationController, data: Character) -> CharacterDetailViewController {
        let viewModel = CharacterDetailViewModel(data: data)
        let vc = CharacterDetailViewController(viewModel: viewModel)
        return vc
    }
}
