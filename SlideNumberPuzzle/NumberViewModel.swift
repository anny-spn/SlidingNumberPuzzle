//
//  NumberViewModel.swift
//  SlideNumberPuzzle
//
//  Created by นางสาวสุภาพันธ์ หง่อสกุล on 10/2/2567 BE.
//

import Foundation

class NumberViewModel: ObservableObject {
    static let numbers = (1...15).map(String.init) + [""]
    
    @Published private var model = SlideNumberModel<String>(total: numbers.count) { index in
        numbers[index]
    }
    
    var blocks: [SlideNumberModel<String>.Block] {
        return model.blocks
    }
    
    var count: Int {
        return model.count
    }
    
    var isOrder: Bool {
        return model.isOrder()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ block: SlideNumberModel<String>.Block) {
        model.choose(block: block)
    }
//    
//    func isOrder() -> Bool {
//        return model.isOrder()
//    }
}
