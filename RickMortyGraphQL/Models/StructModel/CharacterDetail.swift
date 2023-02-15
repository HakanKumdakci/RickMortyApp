//
//  CharacterDetail.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 20.01.2023.
//

import Foundation
import Apollo
import Combine

struct CharacterDetail: BaseModelProtocol, Codable {
        
    private enum CodingKeys: String, CodingKey {
        case id, name, status, species, type, gender, origin, location, episode, created, image
    }
    
    var id: String = ""
    var name: String = ""
    var status: String = ""
    var species: String = ""
    var type: String = ""
    var gender: String = ""
    var origin: Location? = nil
    var location: Location? = nil
    var episode: [Episode] = []
    var createdDate: String = ""
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
                self.status = try container.decode(String.self, forKey: .status)
            } catch {
                print(Log.info(ErrorTypes.attributeError("status").description))
            }
            do {
                self.species = try container.decode(String.self, forKey: .species)
            } catch {
                print(Log.info(ErrorTypes.attributeError("species").description))
            }
            do{
                self.origin = try container.decode(Location.self, forKey: .origin)
            } catch {
                print(Log.info(ErrorTypes.attributeError("origin").description))
            }
            do {
                self.location = try container.decode(Location.self, forKey: .location)
            } catch {
                print(Log.info(ErrorTypes.attributeError("location").description))
            }
            do {
                self.episode = try container.decode([Episode].self, forKey: .episode)
            } catch {
                print(Log.info(ErrorTypes.attributeError("episode").description))
            }
            do {
                self.createdDate = try container.decode(String.self, forKey: .created)
            } catch {
                print(Log.info(ErrorTypes.attributeError("createdDate").description))
            }
            do {
                self.image = try container.decode(String.self, forKey: .image)
            } catch {
                print(Log.info(ErrorTypes.attributeError("image").description))
            }
        } catch {
            print(Log.error("Decoding Error"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
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
