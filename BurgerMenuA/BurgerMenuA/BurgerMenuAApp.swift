//
//  BurgerMenuAApp.swift
//  BurgerMenuA
//
//  Created by Cristhian Leon on 02.04.21.
//

import SwiftUI

@main
struct BurgerMenuAApp: App {
    var body: some Scene {
        WindowGroup {
            HStack {
                ContentView(color: .main) { isOpen in
                    print(isOpen)
                }
                .frame(width: 100, height: 100)
                
                ContentView(color: .blue) { isOpen in
                    print(isOpen)
                }
                .frame(width: 100, height: 100)
            }
        }
    }
}
