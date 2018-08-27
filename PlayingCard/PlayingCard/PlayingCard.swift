//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Minseo Seo on 2018. 8. 27..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    // CustomStringConvertible 프로토콜은 콘솔에서 출력할 때 유용함 (description property 선언 필요)
    var description: String { return "\(rank)\(suit)" }
    
    var suit: Suit
    var rank: Rank
    
    // enum : 고정된 원시값을 각 경우마다 연관지을 수 있다.
    // objc의 열거형이 정수형이었기 때문에 수많은 원시값이 하위 호환성을 지원한다.
    enum Suit: String, CustomStringConvertible {
        var description: String
        
        case spades = "♠️"
        case hearts = "♥️"
        case diamonds = "♦️"
        case clubs = "♣️"
        
        // 모든 것을 가져올 것이므로 static 사용
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
    enum Rank: CustomStringConvertible {
        var description: String
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            // where 은 가능한 모든 경우의 수를 따지지 않는다.
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            allRanks += [Rank.face("J"), Rank.face("Q"), Rank.face("K")]
            return allRanks
        }
    }
}
