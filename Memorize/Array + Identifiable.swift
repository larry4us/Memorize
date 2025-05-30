//
//  Array + Identifiable.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 13/05/24.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int?{ // Int? é um optional, ou seja, NÃO É UM INT. É um enum que retornará um int caso seja do caso .some
        for index in 0..<self.count {
            if self[index].id == matching.id {
               return index // o Swift é esperto para desempacotar o optional que declaramos.
            }
        }
        return nil
    }
}
