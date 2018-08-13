//
//  ViewController.swift
//  Concentration
//
//  Created by Minseo Seo on 2018. 8. 5..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 한 변수가 다른 것에 의존하여 서로 초기화가 어려운 상태 => lazy 로 해결
    // 어떤 변수를 lazy로 만들면 누가 사용하기 전까지는 초기화하지 않는다.
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        // 속성 감시자 : flipCount가 바뀔 때마다 didSet을 실행하여 Label과 싱크를 맞추어 업데이트한다.
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var flipCountLabel: UILabel!
 
    // Oulet Collection
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        // indices : 모든 인덱스를 돌 수 있다.
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.662745098, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.662745098, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃","👻", "🐾", "🥀", "☃️", "🍒", "🍭", "🍡", "🍷"] // Array<String> 타입 추론
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            // 유사 임의 번호 생성기 : 0부터 상한 사이의 숫자를 임의로 생성함.
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return  emoji[card.identifier] ?? "?"
    }
}

