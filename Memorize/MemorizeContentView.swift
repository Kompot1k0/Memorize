//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 22.01.2023.
//

import SwiftUI

struct MemorizeContentView: View {
    
    @ObservedObject var viewModel: EmojiMemorize
    
    var body: some View {
        
        VStack {
            Text(EmojiMemorize.theme.name)
                .font(.title)
                .fontWeight(.bold)
                
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(viewModel.cards) {card in
                        CardView(card: card, color1: viewModel.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard), color2: viewModel.convertColorOfThema(color: EmojiMemorize.theme.secondColorForGradient))
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }.padding(-1.0)
                }.foregroundColor(viewModel.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
            }
            Spacer()
            .font(.largeTitle)
            Text("Score: \(viewModel.score)")
                .font(.title3)
            Button(action: viewModel.newGame) {
                Text("New Game")
                    .font(.title)
                    .foregroundColor(viewModel.convertColorOfThema(color: EmojiMemorize.theme.colorOfCard))
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
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill(Gradient(colors: [color1, color2]))
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let game = EmojiMemorize()
        
        MemorizeContentView(viewModel: game)
            .preferredColorScheme(.dark)
        MemorizeContentView(viewModel: game)
    }
}
