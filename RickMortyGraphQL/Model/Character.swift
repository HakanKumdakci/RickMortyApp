//
//  Character.swift
//  GraphQLApp
//
//  Created by Hakan on 19.08.2021.
//

import Foundation



struct Character: Codable {
    
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
                print(Log.info(ErrorTypes.attributeError("image").description))
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
}
