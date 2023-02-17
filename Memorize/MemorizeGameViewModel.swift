//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import SwiftUI

class EmojiMemorize: ObservableObject {
    
    static func createMemoryGame() -> MemorizeGame<String> {
        let emojis = thema.emojis.shuffled()
        return MemorizeGame<String>(numberOfPairsOfCards: thema.numberOfPairs) { pairIndex in emojis[pairIndex]
        }
    }
    
    
    @Published private var model: MemorizeGame<String> = createMemoryGame()
    
    static var thema: EmojiTheme = themes.animals
    
    //MARK: Спросить почему так 
    var score: Int {
        model.score
    }
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards
    }
    
    func newGame() {
        let numberOfPairs = [6, 7, 8, 9, 10]
        EmojiMemorize.thema = EmojiMemorize.chooseRandTheme()
        EmojiMemorize.thema.numberOfPairs = numberOfPairs.randomElement() ?? 6
        model = EmojiMemorize.createMemoryGame()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    
    //MARK: initialize themes and choose default one
    struct Themes{
        var animals = MemorizeGame<String>.AnimalsTheme()
        var fruits = MemorizeGame<String>.FruitsTheme()
        var music = MemorizeGame<String>.MusicTheme()
        var balls = MemorizeGame<String>.BallsTheme()
        var cars = MemorizeGame<String>.CarsTheme()
        var flags = MemorizeGame<String>.FlagsTheme()
    }
    
    static let themes = Themes()
    
    static func chooseRandTheme() -> EmojiTheme{
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
    
    func convertColorOfThema (color: String) -> Color{
        if color == "red" {
            return Color.red
        } else if color == "orange" {
            return Color.orange
        } else if color == "yellow" {
            return Color.yellow
        } else if color == "gray" {
            return Color.gray
        } else if color == "green" {
            return Color.green
        } else {
            return Color.blue
        }
    }
}
