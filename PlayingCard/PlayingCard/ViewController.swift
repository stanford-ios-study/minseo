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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }
}

