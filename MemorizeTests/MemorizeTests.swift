//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Pedro Larry Rodrigues Lopes on 30/05/25.
//

import Testing
@testable import MemorizeStanTest

struct MemorizeTests {
    
    let sut = EmojiMemoryGame.createMemoryGame()
    
    struct initialConditions {
        
        let sut = EmojiMemoryGame.createMemoryGame()
        @Test func startsWithZeroPoints() async throws {
            #expect(sut.score == 0)
        }

        @Test func startsWithAtLeast3Pairs() async throws {
            #expect(sut.cards.count >= 3)
        }
    }
   
}
