//
//  Mountain.swift
//  EmojiBlocker
//
//  Created by Bizplay on 2022/08/31.
//

import Foundation
/// The hash value.
///
/// Hash values are not guaranteed to be equal across different executions of
/// your program. Do not save hash values to use during a future execution.
///
/// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
///
///
///
class MountainVC {
    struct Mountain : Hashable {
        
        let name        : String
        let height      : Int
        let identifier  = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func == (lhs : Mountain, rhs : Mountain) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        
        private lazy var mountains : [Mountain] = {
            return generateMountains()
        }()
        
        private func generateMountains() -> [Mountain] {
            let components = mountainsRawData.components(separatedBy: CharacterSet.newlines)
            var mountains = [Mountain]()
            for line in components {
                let mountainComponents = line.components(separatedBy: ",")
                
                let name = mountainComponents[0]
                let height = Int(mountainComponents[1])
                mountains.append(Mountain(name: name, height: height!))
            }
            return mountains
        }
//        func filteredMountains(with filter : String? = nil, limit : Int? = nil) -> [Mountain] {
//            let filtered = mountains.filter{ }
//            if let limit = limit {
//                return Array(filter)
//            }
//        }
    }
}

