//
//  CharacterCellViewModel.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 27.01.2023.
//

import Foundation
import Combine

class CharacterCellViewModel {
    
    private var data: Character
    
    private let characterDataStateSubject = PassthroughSubject<CharacterCellDataState, Never>()
    
    private var characterDataPublisher: AnyPublisher<Character, Never> {
        characterDataStateSubject
            .compactMap { $0.characterData }
            .eraseToAnyPublisher()
    }
    
    public var namePublisher: AnyPublisher<String?, Never> {
        return characterDataPublisher
            .map { $0.name }
            .eraseToAnyPublisher()
    }
    
    public var imageUrlPublisher: AnyPublisher<String?, Never> {
        return characterDataPublisher
            .map { $0.image }
            .eraseToAnyPublisher()
    }
    
    init(data: Character) {
        self.data = data
    }
    
    func requestForData() {
        self.characterDataStateSubject.send(.data(data))
    }
    
}
