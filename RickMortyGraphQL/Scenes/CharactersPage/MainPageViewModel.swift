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
        characterDataStateSubject
            .map { $0.isLoading }
            .eraseToAnyPublisher()
    }
    
    var characterDataViewModelPublisher: AnyPublisher<CharacterDataState, Never> {
        characterDataStateSubject
            .filter({ $0.viewModelData != nil || $0.locationViewModelData != nil })
            .eraseToAnyPublisher()
    }
    
    var locationDataStatePublisher: AnyPublisher<CharacterDataState, Never> {
        characterDataStateSubject
            .filter({$0.locationViewModelData != nil })
            .eraseToAnyPublisher()
    }
    
    private let characterDataStateSubject = PassthroughSubject<CharacterDataState, Never>()
    
    private let locationDataStateSubject = PassthroughSubject<Location, Never>()
    
    var subs: Set<AnyCancellable> = []
    
    private var networkManager : BaseNetworkInterface
    
    init(networkManager: BaseNetworkInterface = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    private var characters = [Character]()
    private var locations = [Location]()
    
    var isLoading = false
    func makeRequestForCharacters(pageNumber: Int) {
        if isLoading { return }
        isLoading.toggle()
        characterDataStateSubject.send(.loading)
        
        // I've used throttle but it didn't work because of unknown reason, so I removed it used flag instead of it.
        networkManager.getCharacters(pageNumber: pageNumber)
            .sink(onError: { err in
                self.characterDataStateSubject.send(.error(.failedRequest))
                 print(err.localizedDescription)
                self.isLoading.toggle()
            }, receiveValue: { [weak self] res in
                guard let self = self else {return }
                let charactersJsonValue = res.data?.characters?.results?.map({ $0?.resultMap.jsonValue }) ?? []
                // compactMap will clean nil values
                let characterData: [Character] = charactersJsonValue.compactMap({ Character.decodeFromJsonValue(characterData: $0) })
                
                let vms: [CharacterCellViewModel] = characterData.compactMap({ CharacterCellViewModel(data: $0) })
                self.isLoading.toggle()
                if (pageNumber == 1) {
                    self.characters = characterData
                    self.characterDataStateSubject.send(.viewModelData(vms))
                } else {
                    self.characters.append(contentsOf: characterData)
                    self.characterDataStateSubject.send(.viewModelData(vms))
                }
            })
    }
    
    var isLoading2 = false
    func makeRequestForLocations(pageNumber: Int) {
        if isLoading2 { return }
        isLoading2.toggle()
        characterDataStateSubject.send(.loading)
        
        networkManager.getLocations(pageNumber: pageNumber)
            .sink(onError: { err in
                self.characterDataStateSubject.send(.error(.failedRequest))
                 print(err.localizedDescription)
                self.isLoading2.toggle()
            }, receiveValue: { [weak self] res in
                guard let self = self else {return }
                let locationsJsonValue = res.data?.locations?.results?.map({ $0?.resultMap.jsonValue }) ?? []
                // compactMap will clean nil values
                let locationData: [Location] = locationsJsonValue.compactMap({ Location.decodeFromJsonValue(data: $0) })
                
                let vms: [LocationCellViewModel] = locationData.compactMap({ LocationCellViewModel(data: $0) })
                self.isLoading2.toggle()
                if (pageNumber == 1) {
                    self.locations = locationData
                    self.characterDataStateSubject.send(.locationViewModelData(vms))
                } else {
                    self.locations.append(contentsOf: locationData)
                    self.characterDataStateSubject.send(.locationViewModelData(vms))
                }
            })
    }
    
    
    
    
    func navigateToCharacterPage(coordinator: MainPageCoordinatorProtocol, index: Int) {
        coordinator.navigate(.toCharacterDetail(characters[index]))
    }
    
    func navigateToLocationPage(coordinator: MainPageCoordinatorProtocol, index: Int) {
        coordinator.navigate(.toLocation(locations[index]))
    }
    
    
    
}

