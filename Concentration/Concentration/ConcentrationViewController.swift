//
//  ViewController.swift
//  Concentration
//
//  Created by Minseo Seo on 2018. 8. 5..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    // 한 변수가 다른 것에 의존하여 서로 초기화가 어려운 상태 => lazy 로 해결
    // 어떤 변수를 lazy로 만들면 누가 사용하기 전까지는 초기화하지 않는다.
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    private(set) var flipCount = 0 {
        // 속성 감시자 : flipCount가 바뀔 때마다 didSet을 실행하여 Label과 싱크를 맞추어 업데이트한다.
        didSet {
//            flipCountLabel.text = "Flips: \(flipCount)"
            updateFlipCountLabel()
        }
    }
    
    func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        // 이 연결이 만들어질 때 didSet을 호출한다.
        didSet {
            updateFlipCountLabel()
        }
    }
    
    // Oulet Collection
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        // indices : 모든 인덱스를 돌 수 있다.
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.01096737292, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
//    private var emojiChoices = ["🎃","👻", "🐾", "🥀", "☃️", "🍒", "🍭", "🍡", "🍷"] // Array<String> 타입 추론
    private var emojiChoices = "🎃👻🐾🥀☃️🍒🍭🍡🍷" // Array<String> 타입 추론
    
    private var emoji = [Card:String]()
    
//    private func emoji(for card: Card) -> String {
//        if emoji[card] == nil, emojiChoices.count > 0 {
//            // 유사 임의 번호 생성기 : 0부터 상한 사이의 숫자를 임의로 생성함.
//            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
//        }
//        return  emoji[card] ?? "?"
//    }
    
    // 배열 -> 문자열로 변경
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            // 문자열은 정수로 색인되지 않으므로 index 설정
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
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

