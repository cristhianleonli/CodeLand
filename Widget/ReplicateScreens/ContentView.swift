//
//  ContentView.swift
//  ReplicateScreens
//
//  Created by Cristhian Leon on 14.03.21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.replicatescreens"))
    
    var emojiData: Data = Data()
    
    let emojis = [
        Emoji(icon: "🤣", name: "laugh", description: "This means the user is laughing"),
        Emoji(icon: "🤣", name: "laugh", description: "This means the user is laughing"),
        Emoji(icon: "🤣", name: "laugh", description: "This means the user is laughing")
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji)
                    .onTapGesture {
                        save(emoji)
                    }
            }
        }
    }
    
    func save(_ emoji: Emoji) {
        print("save \(emoji)")
        
        guard let data = try? JSONEncoder().encode(emoji) else {
            print("not saved")
            return
        }
        
        self.emojiData = data
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
