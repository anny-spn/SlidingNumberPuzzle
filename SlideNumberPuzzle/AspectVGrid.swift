//
//  AspectVGrid.swift
//  SlideNumberPuzzle
//
//  Created by นางสาวสุภาพันธ์ หง่อสกุล on 10/2/2567 BE.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio = 1 as CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize) ,spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
            .aspectRatio(aspectRatio, contentMode: .fit)
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize) -> CGFloat {
        let count = CGFloat(count)
        let nColumn = sqrt(count)
        if size.width < size.height {
            return size.width / nColumn
        }
        else {
            return size.height / nColumn
        }
    }

}
