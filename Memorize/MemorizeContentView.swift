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
                
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(game.cards) {card in
                        CardView(card: card, color1: game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard), color2: game.convertColorOfThema(color: EmojiMemorize.theme.secondColorForGradient))
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }.padding(-1.0)
                }.foregroundColor(game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
            }
            Spacer()
            .font(.largeTitle)
            Text("Score: \(game.score)")
                .font(.title3)
            Button(action: game.newGame) {
                Text("New Game")
                    .font(.title)
                    .foregroundColor(game.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
            }
        }
        .padding(.horizontal)
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
        static let cornerRadius: CGFloat = 18
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}
































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemorize()
        
        MemorizeContentView(game: game)
            .preferredColorScheme(.dark)
        MemorizeContentView(game: game)
    }
}
