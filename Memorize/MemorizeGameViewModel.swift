//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import SwiftUI

class EmojiMemorize: ObservableObject {
    typealias Card = MemorizeGame<String>.Card
    
    private static func createMemoryGame() -> MemorizeGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemorizeGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in emojis[pairIndex]
        }
    }
    
    
    @Published private var model = createMemoryGame()
    
    static var theme: EmojiTheme = themes.animals
    
    //MARK: Спросить почему так 
    var score: Int {
        model.score
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    func newGame() {
        let numberOfPairs = [6, 7, 8, 9, 10]
        EmojiMemorize.theme = EmojiMemorize.chooseRandTheme()
        EmojiMemorize.theme.numberOfPairs = numberOfPairs.randomElement() ?? 6
        model = EmojiMemorize.createMemoryGame()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    // MARK: initialize themes and choose default one
    struct Themes{
        var animals = MemorizeGame<String>.AnimalsTheme()
        var fruits = MemorizeGame<String>.FruitsTheme()
        var music = MemorizeGame<String>.MusicTheme()
        var balls = MemorizeGame<String>.BallsTheme()
        var cars = MemorizeGame<String>.CarsTheme()
        var flags = MemorizeGame<String>.FlagsTheme()
    }
    
    static let themes = Themes()
    
    static func chooseRandTheme() -> EmojiTheme {
        let randKey = Int.random(in: 1...6)
        if randKey == 1 {
            return EmojiMemorize.themes.animals
        } else if randKey == 2 {
            return EmojiMemorize.themes.fruits
        } else if randKey == 3 {
            return EmojiMemorize.themes.music
        } else if randKey == 4 {
            return EmojiMemorize.themes.balls
        } else if randKey == 5 {
            return EmojiMemorize.themes.cars
        } else {
            return EmojiMemorize.themes.flags
        }
    }
    
    func convertColorOfThema (color: String) -> Color {
        switch color {
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "yellow":
            return Color.yellow
        case "gray":
            return Color.gray
        case "green":
            return Color.green
        default:
            return Color.blue
        }
    }
}
