//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Admin on 22.01.2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let game = EmojiMemorize()
    
    var body: some Scene {
        WindowGroup {
            MemorizeContentView(game: game)
        }
    }
}
