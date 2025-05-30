//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 06/05/24.
//

import SwiftUI
import Foundation


class EmojiMemoryGame: ObservableObject{
    //toda vez que model mudar, envia o objectWillChange.send() automaticamente. -- por conta do @published.
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    typealias Card = MemoryGame<String>.Card
    // Dado um param (tema) ele retorna um Array<String> ("["🥶", "🥵", "🥥"])"
    
    static func createMemoryGame() -> MemoryGame<String> { // static é a forma do swift de restringir, uma vez que EmojiMemoryGame ainda não foi criado.
        let emojis: Array<String> = ["🥶", "🥵", "🥥", "🤙🏼", "⭐️", "🖤", "💁🏽", "😍"]
        // let emojisFut: Array<String> = ["⚽️", "🖤", "🏟️"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Acess to the Model
    
    var test: Array<Card> {
        model.cards
    }
    
    var cards: Array<Card> {
        // propriedade computada. O valor de cards é acessado por essa função
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose (card: Card) {
        //objectWillChange.send() poderia ser usado, mas nao é necessário por conta do @published.
        model.choose(card)
    }
    
    func resetGame () {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
