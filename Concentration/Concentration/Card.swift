//
//  Card.swift
//  Concentration
//
//  Created by Minseo Seo on 2018. 8. 13..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import Foundation


/**
 구조체 vc 클래스
**/

// 모델이므로 카드 위에 어떤 그림이 그려지는지가 아니라 (UI), 카드가 무엇을 해야하는지, 어떻게 게임이 진행되는지가 담겨야한다.
struct Card {
 
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    // 정적 변수
    private static var identifierFactory = 0
    
    // 정적 메소드
    private static func getUniqueIdentifier() -> Int {
        // 정적 메소드 안에서는 Card.이 없어도 정적 변수에 접근할 수 있다.
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        // self = Card
        self.identifier = Card.getUniqueIdentifier()
    }
}
