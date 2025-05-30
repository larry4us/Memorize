//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 03/05/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let viewModel = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: viewModel)
        }
    }
}
