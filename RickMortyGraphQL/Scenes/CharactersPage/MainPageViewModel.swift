//
//  MainPageViewModel.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 23.01.2023.
//

import Foundation
import Combine
import Apollo
import ApolloCombine

class MainPageViewModel {
    
    // MARK: - Properties

    var loadingPublisher: AnyPublisher<Bool, Never> {
        weatherDataStateSubject
            .map { $0.isLoading }
            .eraseToAnyPublisher()
    }
    
    var characterDataViewModelPublisher: AnyPublisher<CharacterDataState, Never> {
        weatherDataStateSubject
            .filter({ $0.viewModelData != nil })
            .eraseToAnyPublisher()
    }
    
    
    var hasWeatherDataErrorPublisher: AnyPublisher<Bool, Never> {
        weatherDataStateSubject
            .map { $0.characterDataError != nil }
            .eraseToAnyPublisher()
    }
    
    
    var characterDataStatePublisher: AnyPublisher<CharacterDataState, Never> {
        weatherDataStateSubject
            .eraseToAnyPublisher()
    }
    
    private let weatherDataStateSubject = PassthroughSubject<CharacterDataState, Never>()
    
    var subs: Set<AnyCancellable> = []
    
    private var networkManager : BaseNetworkInterface
    
    init(networkManager: BaseNetworkInterface = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    var characters = [Character]()
    
    
    func makeRequest() {
        weatherDataStateSubject.send(.loading)
        
        networkManager.getCharacters()
            .sink(onError: { err in
                 print(err.localizedDescription)
            }, receiveValue: { [weak self] res in
                guard let self = self else {return }
                let charactersJsonValue = res.data?.characters?.results?.map({ $0?.resultMap.jsonValue }) ?? []
                // compactMap will add non-nil values
                self.characters = charactersJsonValue.compactMap({ Character.decodeFromJsonValue(characterData: $0) })
                //pass to subject
                
                let vms: [CharacterCellViewModel] = self.characters.compactMap({ CharacterCellViewModel(data: $0) })
                
                self.weatherDataStateSubject.send(.viewModelData(vms))
            })
    }
    
    func navigateToCharacterPage(coordinator: MainPageCoordinatorProtocol, index: Int) {
        coordinator.navigateToCharacterDetail(data: characters[index])
    }
}

