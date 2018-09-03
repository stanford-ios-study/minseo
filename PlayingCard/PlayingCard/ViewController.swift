//
//  ViewController.swift
//  PlayingCard
//
//  Created by Minseo Seo on 2018. 8. 27..
//  Copyright © 2018년 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    
    @IBOutlet var playingCardView: PlayingCardView! {
        didSet {
            // 이 카드를 뒤집을 때 스와이프를 사용하는데, 모델에 영향을 주므로 컨트롤러가 처리해야 한다. 즉 target은 self.
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            // 컨트롤러까지 가지 않고 뷰에서 처리한다.
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(playingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)))
            playingCardView.addGestureRecognizer(pinch)
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
    }
    
    @objc func nextCard() {
        if let card = deck.draw() {
            // 변형을 위해 컨트롤러가 해야하는 일
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
}
