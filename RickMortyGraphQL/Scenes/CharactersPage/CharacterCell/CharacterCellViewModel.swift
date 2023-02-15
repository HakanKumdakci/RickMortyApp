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
    
    private let weatherDataStateSubject = PassthroughSubject<CharacterCellDataState, Never>()
    
    private var weatherDataPublisher: AnyPublisher<Character, Never> {
        weatherDataStateSubject
            .compactMap { $0.characterData }
            .eraseToAnyPublisher()
    }
    
    public var namePublisher: AnyPublisher<String?, Never> {
        return weatherDataPublisher
            .map { $0.name }
            .eraseToAnyPublisher()
    }
    
    public var imageUrlPublisher: AnyPublisher<String?, Never> {
        return weatherDataPublisher
            .map { $0.image }
            .eraseToAnyPublisher()
    }
    
    init(data: Character) {
        self.data = data
    }
    
    func requestForData() {
        self.weatherDataStateSubject.send(.data(data))
    }
    
}
