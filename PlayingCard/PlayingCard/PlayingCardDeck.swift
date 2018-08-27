//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Minseo Seo on 2018. 8. 27..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    
    // 완전한 deck으로 시작할 것이므로 통제 가능한 private(set)을 사용한다.
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    // err: mutating member on immutable value -> value 타입의 구조체이므로 카드를 없애는 변화를 주려면 mutating 키워드를 사용해야한다.
    mutating func draw() -> PlayingCard? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
