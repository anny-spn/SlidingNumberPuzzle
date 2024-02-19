//
//  SlideNumberModel.swift
//  SlideNumberPuzzle
//
//  Created by นางสาวสุภาพันธ์ หง่อสกุล on 10/2/2567 BE.
//

import Foundation

struct SlideNumberModel<BlockContentType: Equatable> {
    private(set) var blocks: Array<Block>
    private(set) var orderedBlocks: Array<Block>
    private(set) var freeSpaceBlock: Block
    private(set) var count: Int = 0
    
    init(total: Int ,blockContentFactory: (Int) -> BlockContentType){
        blocks = []
        for index in 0..<total {
            let content = blockContentFactory(index)
            blocks.append(Block(content: content, isSpace: index == total-1 ? true : false))
        }
        orderedBlocks = blocks
        freeSpaceBlock = blocks[total-1]
        shuffle()
    }
    
    struct Block: Identifiable, Equatable{
        let content: BlockContentType
        let isSpace: Bool
        var isMoveable: Bool = false
        let id = UUID()
    }
    
    private func index(of block: Block) -> Int {
        for index in blocks.indices {
            if blocks[index].id == block.id {
                return index
            }
        }
        return 0;
    }
    
    mutating func choose(block: Block) {
        let chosenIndex = index(of: block)
        if block.isMoveable {
            blocks[index(of: freeSpaceBlock)] = block
            blocks[chosenIndex] = freeSpaceBlock
            count += 1
        }
        aroundFreeSpaceMoveable()
        if isOrder() {
            imMovable()
        }
    }
    
    private mutating func imMovable() {
        for i in blocks.indices {
            blocks[i].isMoveable = false
        }
    }
    
    private mutating func aroundFreeSpaceMoveable() {
        imMovable()
        let freeSpaceIndex = index(of: freeSpaceBlock)
        if (blocks[freeSpaceIndex].isSpace) {
//            case 1: right block can move}
            if (freeSpaceIndex % 4) != 3 {
                blocks[freeSpaceIndex+1].isMoveable = true
            }
//            case 2: left block can move
            if (freeSpaceIndex % 4) != 0 {
                blocks[freeSpaceIndex-1].isMoveable = true
            }
//            case 3: upper block can move
            if (freeSpaceIndex - 4) >= 0 {
                blocks[freeSpaceIndex-4].isMoveable = true
            }
//            case 4: upper block can move
            if (freeSpaceIndex + 4) < 16 {
                blocks[freeSpaceIndex+4].isMoveable = true
            }
        }
        freeSpaceBlock.isMoveable = true
    }
    
    mutating func shuffle() {
        blocks.shuffle()
        count = 0;
        aroundFreeSpaceMoveable()
    }
    
    func isOrder() -> Bool {
        let blocksContent = blocks.map{$0.content}
        let orderedBlocksContent = orderedBlocks.map{$0.content}
        if blocksContent == orderedBlocksContent {
            return true
        }
        return false
    }
}
