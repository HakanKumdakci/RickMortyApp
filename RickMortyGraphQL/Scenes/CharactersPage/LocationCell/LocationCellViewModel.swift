//
//  LocationCellViewModel.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 21.02.2023.
//

import Foundation
import Combine

class LocationCellViewModel {
    
    private var data: Location
    
    private let locationDataStateSubject = PassthroughSubject<Location, Never>()
    
    public var namePublisher: AnyPublisher<String?, Never> {
        return locationDataStateSubject
            .map { $0.name }
            .eraseToAnyPublisher()
    }
    
    public var typePublisher: AnyPublisher<String?, Never> {
        return locationDataStateSubject
            .map { $0.type }
            .eraseToAnyPublisher()
    }
    
    init(data: Location) {
        self.data = data
    }
    
    func requestForData() {
        self.locationDataStateSubject.send(data)
    }
    
}
