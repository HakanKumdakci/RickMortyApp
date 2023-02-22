//
//  Location.swift
//  GraphQLApp
//
//  Created by Hakan on 10.07.2022.
//

import Foundation
import Apollo

struct Location: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, type, dimension, created, residents
    }
    
    var id: String = ""
    var name: String = ""
    var type: String = ""
    var dimension: String = ""
    var created: String = ""
    var residents: [Character] = []
    
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
                self.type = try container.decode(String.self, forKey: .type)
            } catch {
                print(Log.info(ErrorTypes.attributeError("type").description))
            }
            
            do {
                self.dimension = try container.decode(String.self, forKey: .dimension)
            } catch {
                print(Log.info(ErrorTypes.attributeError("dimension").description))
            }
            
            do {
                self.created = try container.decode(String.self, forKey: .created)
            } catch {
                print(Log.info(ErrorTypes.attributeError("created").description))
            }
            
            do {
                self.residents = try container.decode([Character].self, forKey: .residents)
            } catch {
//                print(Log.info(ErrorTypes.attributeError("residents").description))
            }
        } catch {
            print(Log.error("Decoding Error"))
        }
    }
    
    
    static func decodeFromJsonValue<T>(data: Apollo.JSONValue?) -> T? where T : Decodable, T : Encodable {
        do {
            guard let data = data else { return nil }
            let json = try JSONSerialization.data(withJSONObject: data)
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


struct LocationDetail: Decodable{
    var id: String?
    var name: String?
    var type: String?
    var dimension: String?
    var created: String?
    var residents: [Character]
}
