//
//  ContentView.swift
//  Memorize
//
//  Created by Admin on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount = 12
    @State var theme: [String] = choseTheme(1)
    var body: some View {
        VStack{
            Text("Memorize!")
                .font(.title)
                .fontWeight(.bold)
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]){
                    ForEach(theme[0..<cardCount], id: \.self) {emoji in  CardView(isFaceUp: false, content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }.padding(-1.0)
                }.foregroundColor(.red)
            }
            Spacer()
            HStack{
                buttonChoseThemeAnimals
                Spacer()
                buttonChoseThemeFruits
                Spacer()
                buttonChoseThemeTransport
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var buttonChoseThemeAnimals: some View {
        VStack{
            Button{theme = choseTheme(1).shuffled(); cardCount = Int.random(in: 9...20)}
                label: {Image(systemName: "pawprint.circle");
            }
            Text("Theme 1")
                .font(.headline)
        }
    }
    var buttonChoseThemeFruits: some View{
        VStack{
            Button{theme = choseTheme(2).shuffled(); cardCount = Int.random(in: 9...20)}
                label: {Image(systemName: "fork.knife.circle")
            }
            Text("Theme 2")
                .font(.headline)
        }
    }
    var buttonChoseThemeTransport: some View{
        VStack{
            Button{theme = choseTheme(3).shuffled(); cardCount = Int.random(in: 9...20)}
                label: {Image(systemName: "car.circle")
            }
            Text("Theme 3")
                .font(.headline)
        }
    }
}

func choseTheme(_ chosenTheme: Int) -> [String]{
    
    enum Themes{
        case themeAnimals
        case themeFruits
        case themeTransport
    }
    
    var theme = Themes.themeAnimals
    
    if chosenTheme == 1{
        theme = Themes.themeAnimals
    }else if chosenTheme == 2{
        theme = Themes.themeFruits
    }else{
        theme = Themes.themeTransport
    }
    
    switch theme{
        case .themeAnimals:
            let emojis = ["🐶", "🐹", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦆", "🦇", "🦫", "🦚"]
            return emojis
        case .themeFruits:
        let emojis = ["🍎", "🍏", "🍊", "🍐", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦"]
        return emojis
        case .themeTransport:
        let emojis = ["🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚃", "🚂", "🚁", "🚀"]
        return emojis
    }
}

struct CardView: View{
    @State var isFaceUp: Bool
    var content: String
    
    var body: some View{
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack {
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
                    
                    
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            
    }
}
