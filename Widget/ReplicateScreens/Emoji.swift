//
//  Emoji.swift
//  ReplicateScreens
//
//  Created by Cristhian Leon on 19.03.21.
//

import Foundation

struct Emoji: Identifiable, Codable {
    var id: String {
        return name.lowercased()
    }
    
    let icon: String
    let name: String
    let description: String
}
