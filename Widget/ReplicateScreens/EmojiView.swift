//
//  EmojiView.swift
//  ReplicateScreens
//
//  Created by Cristhian Leon on 19.03.21.
//

import SwiftUI

struct EmojiView: View {
    let emoji: Emoji
    
    var body: some View {
        Text(emoji.icon)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
    }
}
