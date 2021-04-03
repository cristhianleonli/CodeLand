//
//  ContentView.swift
//  SwiftUIMenus
//
//  Created by Cristhian Leon on 19.03.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hi there!")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Menu {
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Archive") },
                                        icon: { Image(systemName: "folder.fill") }
                                    )
                                })
                                
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Delete") },
                                        icon: { Image(systemName: "trash.fill") }
                                    )
                                })
                                
                                Button(action: {}, label: {
                                    Label(
                                        title: { Text("Send") },
                                        icon: { Image(systemName: "paperplane.fill") }
                                    )
                                })
                            } label: {
                                Label(
                                    title: { Text("Menu") },
                                    icon: { Image(systemName: "plus") }
                                )
                            }
                            
                        }
                    }
            }
            .navigationTitle("SwiftUI Menus")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
