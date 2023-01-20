//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Hakan on 11.11.2022.
//

import UIKit
import Apollo
import Kingfisher


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jsonString = "{\"name\":\"Rick\",\"id\":\"Alive\",\"image2\":\"https://rickandmortyapi.com/api/character/avatar/1.jpeg\"}"
        
        let jsonData = jsonString.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        let launch = try! decoder.decode(Character.self, from: jsonData)
        
        print(launch)
        
        Network.shared.apollo.fetch(query: SsQuery()) { [weak self] result in
            switch result {
                    
                case .success(_):
                    print()
                case .failure(let error):
                    print(error.localizedDescription)
                    print()
            }
            guard let data = try? result.get().data else { return }
//            print(data.jsonObject)
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            decoder.dateDecodingStrategy = .secondsSince1970
//            let launch = try decoder.decode(Character.self, from: jsonData)
        }
        // Do any additional setup after loading the view.
    }


}
