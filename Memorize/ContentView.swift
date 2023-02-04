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
                button1
                Spacer()
                button2
                Spacer()
                button3
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var button1: some View {
        VStack{
            Button{theme = choseTheme(1).shuffled(); cardCount = Int.random(in: 9...20)}
                label: {Image(systemName: "pawprint.circle");
            }
            Text("Theme 1")
                .font(.headline)
        }
    }
    var button2: some View{
        VStack{
            Button{theme = choseTheme(2).shuffled(); cardCount = Int.random(in: 9...20)}
                label: {Image(systemName: "fork.knife.circle")
            }
            Text("Theme 2")
                .font(.headline)
        }
    }
    var button3: some View{
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
        case theme1
        case theme2
        case theme3
    }
    
    var theme = Themes.theme1
    
    if chosenTheme == 1{
        theme = Themes.theme1
    }else if chosenTheme == 2{
        theme = Themes.theme2
    }else{
        theme = Themes.theme3
    }
    
    switch theme{
        case .theme1:
            let emojis = ["🐶", "🐹", "🐱", "🐭", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦆", "🦇", "🦫", "🦚"]
            return emojis
        case .theme2:
        let emojis = ["🍎", "🍏", "🍊", "🍐", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦"]
        return emojis
        case .theme3:
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
//                Text("ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ⠀")
//                    .font(.largeTitle)
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
