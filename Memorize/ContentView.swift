//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemorize
    
    var body: some View {
        VStack{
            Text(EmojiMemorize.thema.name)
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(viewModel.cards) {card in CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }.padding(-1.0)
                }.foregroundColor(Color(EmojiMemorize.thema.colorOfCard))
            }
            Spacer()
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}


struct CardView: View{
    let card: MemorizeGame<String>.Card
    
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else if card.isMatched{
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemorize()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
    }
}
