//
//  NetworkManager.swift
//  GraphQLApp
//
//  Created by Hakan on 9.07.2022.
//

import UIKit
import Apollo
import Combine

extension Publisher {
    func ignore() {
        receive(subscriber: Subscribers.Sink(receiveCompletion: { _ in }, receiveValue: { _ in }))
    }
    
    func sink(onError: @escaping (Self.Failure) -> Void, receiveValue: @escaping (Self.Output) -> Void) {
        receive(subscriber: Subscribers.Sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                onError(error)
            case .finished:
                break
            }
        }, receiveValue: receiveValue))
    }
}

//Weakly assign, because combine leaks otherwise
extension Publisher where Failure == Never {
    func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable {
        sink { [weak root] in
            root?[keyPath: keyPath] = $0
        }
    }
}


protocol BaseNetworkInterface{
    func getCharacters(pageNumber: Int) -> Publishers.ApolloFetch<GetCharactersQuery>
    func getLocations(pageNumber: Int) -> Publishers.ApolloFetch<GetLocationsQuery>
}

class NetworkManager: BaseNetworkInterface {
    
    private var client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: URL(string: Constants.baseURL)!)){
        self.client = client
    }
    
    func getCharacters(pageNumber: Int) -> Publishers.ApolloFetch<GetCharactersQuery> {
        return self.client.fetchPublisher(query: GetCharactersQuery(page: pageNumber))
    }
    
    func getLocations(pageNumber: Int) -> Publishers.ApolloFetch<GetLocationsQuery> {
        return self.client.fetchPublisher(query: GetLocationsQuery(page: pageNumber))
    }
    
    
    
    public func performRequest(urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPError.invalidResponse
                }
                guard (200 ..< 300).contains(httpResponse.statusCode) else {
                    throw HTTPError.invalidResponse
                }
                return data
            }.eraseToAnyPublisher()
    }
}
