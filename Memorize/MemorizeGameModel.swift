//
//  MemorizeGameModel.swift
//  Memorize
//
//  Created by Admin on 10.02.2023.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards: Array<Card>
    
    private var indexOfOneFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfOneFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfOneFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
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
    
        struct AnimalsTheme: EmojiTheme{
            var name: String = "Animals"
            var emojis: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐸", "🐥"]
            var numberOfPairs: Int = 7
            var colorOfCard: String = "red"
        }
        
        struct FruitsTheme: EmojiTheme{
            var name: String = "Fruits"
            var emojis: [String] = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
            var numberOfPairs: Int = 5
            var colorOfCard: String = "orange"
        }
        
        struct MusicTheme: EmojiTheme{
            var name: String = "Music"
            var emojis: [String] = ["🎤", "🎧", "🎼", "🎹", "🥁", "🪘", "🎷", "🎺", "🪗", "🎸", "🪕", "🎻"]
            var numberOfPairs: Int = 6
            var colorOfCard: String = "blue"
        }
        
        struct BallsTheme: EmojiTheme{
            var name: String = "Balls"
            var emojis: [String] = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🥏"]
            var numberOfPairs: Int = 4
            var colorOfCard: String = "green"
        }
        
        struct CarsTheme: EmojiTheme{
            var name: String = "Cars"
            var emojis: [String] = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜"]
            var numberOfPairs: Int = 8
            var colorOfCard: String = "gray"
        }
        
        struct FlagsTheme: EmojiTheme{
            var name: String = "Flags"
            var emojis: [String] = ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🇦🇺", "🇦🇬", "🇦🇶", "🇻🇳", "🇬🇵", "🇭🇰", "🇭🇳", "🇿🇼", "🇮🇱", "🇲🇨", "🇷🇪", "🇯🇵"]
            var numberOfPairs: Int = 9
            var colorOfCard: String = "yellow"
        }
}

protocol EmojiTheme{
    var name: String { get set }
    var emojis: [String] { get set }
    var numberOfPairs: Int { get set }
    var colorOfCard: String { get set }
}

