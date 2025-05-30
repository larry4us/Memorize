//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 27/08/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    let items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader{ geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRation: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0){
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio,contentMode: .fit)
                    //.background(Color.red)
                }
            }
            //.background(Color.green)
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRation aspectRatio: CGFloat
    ) -> CGFloat {
        var columnCount = CGFloat(1)
        let count = CGFloat(count)
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count/columnCount).rounded(.up)
            if height * rowCount < size.height {
                return width.rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

//struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
//    let items: [Item]
//    var aspectRatio: CGFloat = 1
//    let content: (Item) -> ItemView
//
//    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
//        self.items = items
//        self.aspectRatio = aspectRatio
//        self.content = content
//    }
//
//    var body: some View {
//        GeometryReader { geometry in
//            let gridItemSize = gridItemWidthThatFits(
//                count: items.count,
//                size: geometry.size,
//                atAspectRatio: aspectRatio
//            )
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
//                ForEach(items) { item in
//                    content(item)
//                        .aspectRatio(aspectRatio, contentMode: .fit)
//                }
//            }
//        }
//    }
//
//    private func gridItemWidthThatFits(
//        count: Int,
//        size: CGSize,
//        atAspectRatio aspectRatio: CGFloat
//    ) -> CGFloat {
//        let count = CGFloat(count)
//        var columnCount = 1.0
//        repeat {
//            let width = size.width / columnCount
//            let height = width / aspectRatio
//
//            let rowCount = (count / columnCount).rounded(.up)
//            if rowCount * height < size.height {
//                return (size.width / columnCount).rounded(.down)
//            }
//            columnCount += 1
//        } while columnCount < count
//        return min(size.width / count, size.height * aspectRatio).rounded(.down)
//    }
//}

//
//#Preview {
//    AspectVGrid()
//}
