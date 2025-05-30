//
//  Cardify.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 19/05/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var isFaceUp: Bool
    var rotation: Double
    
    init(isFaceUp: Bool = false){
        self.isFaceUp = isFaceUp
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 10)
            base
                .strokeBorder(lineWidth: 2)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}


