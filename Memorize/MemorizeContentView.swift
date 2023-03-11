//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 22.01.2023.
//

import SwiftUI

struct MemorizeContentView: View {
    
    @ObservedObject var game: EmojiMemorize
    
    var body: some View {
        
        VStack {
            Text(EmojiMemorize.theme.name)
                .font(.title)
                .fontWeight(.bold)
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card, color1: game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard), color2: game.convertColorOfThema(color: EmojiMemorize.theme.secondColorForGradient))
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)}
                } })
            
            .padding(.horizontal)
            .foregroundColor(game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
            Spacer()
                .font(.largeTitle)
            Text("Score: \(game.score)")
                .font(.title3)
            Button(action: game.newGame) {
                Text("New Game")
                    .font(.title)
                    .foregroundColor(game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
            }
            .padding(.horizontal)
        }
    }
}

struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    var color1: Color
    var color2: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    PieShape(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(DrawingConstants.circlePadding)
                        .opacity(DrawingConstants.circleOpacity)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill(Gradient(colors: [color1, color2]))
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
     
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.55
        static let circlePadding: CGFloat = 6
        static let circleOpacity: CGFloat = 0.4
    }
}
































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemorize()
        
//        game.choose(game.cards.first!)
        return MemorizeContentView(game: game)
            .preferredColorScheme(.dark)
    }
}
