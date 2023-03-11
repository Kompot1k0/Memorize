//
//  MemorizeGameModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card> = []
    
    private var indexOfOneFaceUpCard: Int? {
            get { cards.indices.filter( { cards[$0].isFaceUp } ).oneAndOnly }
            set { cards.indices.forEach( { cards[$0].isFaceUp = ($0 == newValue) }) }
        }
    
    private(set) var score: Int = 0
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    increaseScore()
                }
                reduceScore(cards[chosenIndex].isAlreadyBeenSeen, cards[potentialMatchIndex].isAlreadyBeenSeen,
                    cards[chosenIndex].isMatched,
                    cards[potentialMatchIndex].isMatched)
                cards[chosenIndex].isAlreadyBeenSeen = true
                cards[potentialMatchIndex].isAlreadyBeenSeen = true
                cards[chosenIndex].isFaceUp = true
            } else {
                
                indexOfOneFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func increaseScore() {
        score += 2
    }
    
    mutating func reduceScore(_ card1: Bool, _ card2: Bool, _ card1IsMatched: Bool, _ card2IsMatched: Bool) {
        if card1 && !card1IsMatched {
            score -= 1
        }
        if card2 && !card2IsMatched{
            score -= 1
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        let id: Int
        var isAlreadyBeenSeen = false
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
//        cards = []
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    func chooseRandTheme() -> EmojiTheme{
        let randKey = Int.random(in: 1...6)
        if randKey == 1 {
            return AnimalsTheme()
        } else if randKey == 2 {
            return FruitsTheme()
        } else if randKey == 3 {
            return MusicTheme()
        } else if randKey == 4 {
            return BallsTheme()
        } else if randKey == 5 {
            return CarsTheme()
        } else {
            return FlagsTheme()
        }
    }
    
        struct AnimalsTheme: EmojiTheme {
            var name: String = "Animals"
            var emojis: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐸", "🐥"]
            var numberOfPairs: Int = 7
            var colorOfCard: String = "red"
            var secondColorForGradient: String = "blue"
        }
        
        struct FruitsTheme: EmojiTheme {
            var name: String = "Fruits"
            var emojis: [String] = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
            var numberOfPairs: Int = 5
            var colorOfCard: String = "orange"
            var secondColorForGradient: String = "gray"
        }
        
        struct MusicTheme: EmojiTheme {
            var name: String = "Music"
            var emojis: [String] = ["🎤", "🎧", "🎼", "🎹", "🥁", "🪘", "🎷", "🎺", "🪗", "🎸", "🪕", "🎻"]
            var numberOfPairs: Int = 6
            var colorOfCard: String = "blue"
            var secondColorForGradient: String = "orange"
        }
        
        struct BallsTheme: EmojiTheme {
            var name: String = "Balls"
            var emojis: [String] = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🥏"]
            var numberOfPairs: Int = 4
            var colorOfCard: String = "green"
            var secondColorForGradient: String = "yellow"
        }
        
        struct CarsTheme: EmojiTheme {
            var name: String = "Cars"
            var emojis: [String] = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
            var numberOfPairs: Int = 8
            var colorOfCard: String = "gray"
            var secondColorForGradient: String = "red"
        }
        
    struct FlagsTheme: EmojiTheme {
            var name: String = "Flags"
            var emojis: [String] = ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇦🇺", "🇦🇬", "🇦🇶", "🇻🇳", "🇬🇵", "🇭🇰", "🇭🇳", "🇿🇼", "🇮🇱", "🇲🇨", "🇷🇪", "🇯🇵"]
            var numberOfPairs: Int = 9
            var colorOfCard: String = "yellow"
            var secondColorForGradient: String = "gray"
        }
}

protocol EmojiTheme {
    var name: String { get set }
    var emojis: [String] { get set }
    var numberOfPairs: Int { get set }
    var colorOfCard: String { get set }
    var secondColorForGradient: String { get set }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
