//
//  Character.swift
//  GraphQLApp
//
//  Created by Hakan on 19.08.2021.
//

import Foundation
import Apollo
import Combine

protocol BaseModelProtocol {
    static func decodeFromJsonValue<T: Codable>(characterData: JSONValue?) -> T?
}

struct Character: BaseModelProtocol, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, image
    }
    
    var id: String = ""
    var name: String = ""
    var image: String = ""
    
    init(from decoder: Decoder) {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            do {
                self.id = try container.decode(String.self, forKey: .id)
            } catch {
                print(Log.info(ErrorTypes.attributeError("id").description))
            }
            do {
                self.name = try container.decode(String.self, forKey: .name)
            } catch {
                print(Log.info(ErrorTypes.attributeError("name").description))
            }
            do {
                self.image = try container.decode(String.self, forKey: .image)
            } catch {
                print(Log.info(ErrorTypes.attributeError("image").description))
            }
        } catch {
            print(Log.warning("Decoding Error"))
        }
    }
    
    
    static func decodeFromJsonValue<T>(characterData: Apollo.JSONValue?) -> T? where T : Decodable, T : Encodable {
        do {
            guard let characterData = characterData else { return nil }
            let json = try JSONSerialization.data(withJSONObject: characterData)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let obj = try decoder.decode(T.self, from: json)
            return obj
        } catch let err {
            print(Log.error("Convert Error \(err)"))
            return nil
        }
    }
}
