//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 03/05/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var lastScoreChange = (0, causedByCardId: "")
    let aspectRatio: CGFloat = 2/3
    
    var body: some View { // some view =  é como estar dizendo pro compilador descobrir o tipo de view que está sendo retornada.
        VStack(spacing: 0){
            //MARK: por que o AspectVGrid toma conta de mais espaço do que precisa?
            VStack{
                cards
                    .foregroundStyle(.orange)
                HStack{
                    score
                    Spacer()
                    deck
                    Spacer()
                    discardPile
                    Spacer()
                    shuffleButton
                }
                .padding()
            }
        }
    }
    
    private var resetButton: some View {
        Button("Reset"){
            viewModel.resetGame()
        }
    }
    
    private var shuffleButton: some View {
        Button("Shuffle"){
            withAnimation(.easeInOut){
                viewModel.shuffle()
            }
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
    }
    
    private var cards: some View {
        AspectVGrid (viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card){
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: card.isMatched ? matchedCardsNamespace : dealingNamespace, isSource: card.isMatched ? false : true) //isSource = True resolve o problema mas mata uma transicao.
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
                    .padding(4)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
        .padding()
        //.background(Color.yellow)
    }
    
    @Namespace private var dealingNamespace
    
    private func choose(_ card: Card) {
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card: card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    @Namespace private var matchedCardsNamespace
    
    private var discardPile: some View {
            ZStack{
                ForEach(matchedCards){ matchedCard in
                    CardView(card: matchedCard)
                        .foregroundStyle(.orange)
                        .matchedGeometryEffect(id: matchedCard.id, in: matchedCardsNamespace)
                }
            }
            //.animation()
            .frame(width: deckWidth, height: deckWidth / aspectRatio)
    }
    
    private var deck: some View {
        ZStack{
            ForEach(undealtCards){ undealtCard in
                CardView(card: undealtCard)
                    .foregroundStyle(.orange)
                    .matchedGeometryEffect(id: undealtCard.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .onTapGesture {
            // Deal the cards
            var delay: TimeInterval = 0.25
            for card in viewModel.cards {
                withAnimation(Animation.easeInOut(duration: 1.0).delay(delay)) {
                    _ = dealt.insert(card.id)
                }
                delay += 0.15
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
    }
    
    private let deckWidth: CGFloat = 50
    
    @State private var dealt = Set<Card.ID>()
    
    private var matchedCards: [Card] {
        viewModel.cards.filter{ $0.isMatched}
    }
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0)}
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCard) = lastScoreChange
        return card.id == causedByCard ? amount : 0
    }
    
    private struct ShuffleView: View {
        var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .opacity(0.5)
                VStack{
                    Text("🔀")
                    Text("Shuffle")
                }
                .font(Font.largeTitle)
                .foregroundColor(.white)
                .bold()
            }
            .font(.body)
        }
    }
    
    struct CardView: View {
        var card: MemoryGame<String>.Card
        
        var body: some View {
            
            if card.isFaceUp || !card.isMatched {
                GeometryReader { geometry in
                    TimelineView(.animation) { animation in
                        ZStack{
                            Group {
                                Pie(endAngle: Angle.degrees(card.bonusPercentRemaining * 360), clockwise: false)
                                    .opacity(0.5)
                                    .padding(5)
                            }
                            Text(card.content)
                            //MARK: - como controlar o tamanho da carta usando minimumScaleFactor?
                                //.rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                        }
                    }
                    .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.55))
                    .animation(Animation.linear(duration: 1).repeatCount(5, autoreverses: false), value: card.isMatched)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(AnyTransition.scale)
                }
            } else {
                Color.clear
            }
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
