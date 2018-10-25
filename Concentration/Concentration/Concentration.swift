//
//  Concentration.swift
//  Concentration
//
//  Created by Minseo Seo on 2018. 8. 13..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import Foundation

struct Concentration
{
    // empty array
    private(set) var cards = Array<Card>()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //            var foundIndex: Int?
            //            for index in cards.indices {
            //                if cards[index].isFaceUp {
            //                    if foundIndex == nil {
            //                        foundIndex = index
            //                    } else {
            //                        return nil
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        for i in cards.indices {
            let randomIndex = (cards.count - 1).arc4random
            cards.swapAt(i, randomIndex)
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
