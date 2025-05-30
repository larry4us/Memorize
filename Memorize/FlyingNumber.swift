//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 31/08/24.
//

import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State var offset: CGFloat = 0
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? .red : .green)
                .offset(x: 0, y: offset)
                .opacity(offset.isZero ? 1 : 0)
                .shadow(color: Color.black, radius :4, x: 1, y: 1)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        let newOffset = number > 0 ? 200 : -200
                        offset = CGFloat(newOffset)
                    }
                }
                .onDisappear{
                    // resentando o offset
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: -33)
}
