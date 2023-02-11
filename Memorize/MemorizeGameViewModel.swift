//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import SwiftUI

class EmojiMemorize: ObservableObject {
    
    static func createMemoryGame() -> MemorizeGame<String> {
        MemorizeGame<String>(numberOfPairsOfCards: EmojiMemorize.thema.numberOfPairs) { pairIndex in
            EmojiMemorize.thema.emojis[pairIndex]
        }
    }
    
    
    @Published private var model: MemorizeGame<String> = createMemoryGame()
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    
    static var themes = MemorizeGame<String>.Themes()
    static var thema = MemorizeGame<String>.Themes.AnimalsTheme()
}
