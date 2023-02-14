//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import SwiftUI

class EmojiMemorize: ObservableObject {
    
    static func createMemoryGame() -> MemorizeGame<String> {
        let emojis = shuffledEmojis(emojis: thema.emojis, numberOfEmojis: thema.numberOfPairs)
        return MemorizeGame<String>(numberOfPairsOfCards: thema.numberOfPairs) { pairIndex in emojis[pairIndex]
        }
    }
    
    
    @Published private var model: MemorizeGame<String> = createMemoryGame()
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    
    struct Themes{
        var animals = MemorizeGame<String>.AnimalsTheme()
        var fruits = MemorizeGame<String>.FruitsTheme()
        var music = MemorizeGame<String>.MusicTheme()
        var balls = MemorizeGame<String>.BallsTheme()
        var cars = MemorizeGame<String>.CarsTheme()
        var flags = MemorizeGame<String>.FlagsTheme()
    }
    
    static let themes = Themes()
    static var thema = themes.animals
    static var themaColor = thema.colorOfCard
    
    static func shuffledEmojis (emojis: [String], numberOfEmojis: Int) -> [String] {
        let shuffledEmojis = emojis.shuffled()
        var createdEmojis = Array(repeating: "🐸", count: numberOfEmojis)
        for emoji in createdEmojis.indices {
            createdEmojis[emoji] = (shuffledEmojis[emoji])
        }
        return createdEmojis
    }

}
