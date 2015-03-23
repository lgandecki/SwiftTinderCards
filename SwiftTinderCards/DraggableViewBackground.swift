//
//  DraggableViewBackground.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import Foundation
import UIKit


class DraggableViewBackground: UIView, DraggableViewDelegate {
    
    let MAX_BUFFER_SIZE = 2;
    let CARD_HEIGHT = CGFloat(386.0);
    let CARD_WIDTH = CGFloat(290.0);
    
    let menuButton = UIButton()
    let messageButton = UIButton()
    let checkButton = UIButton()
    let xButton = UIButton()
    
    let exampleCardLabels = ["first", "second", "third", "fourth", "last"]
    var loadedCards = NSMutableArray()
    var allCards =  NSMutableArray()
    var cardsLoadedIndex = 0
    var numLoadedCardsCap = 0
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        setupView()
        setLoadedCardsCap()
        createCards()
        displayCards()
    }
    
    func setupView() {
        setBackgroundColor()
        addMenuButton()
        addMessageButton()
        addXButton()
        addCheckButton()
    }
    
    func setBackgroundColor() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1);
    }
    
    func addMenuButton() {
        menuButton.frame = CGRectMake(17, 34, 22, 15);
        menuButton.setImage(UIImage(named: "menuButton"), forState: .Normal)
        addSubview(menuButton)
    }
    
    func addMessageButton() {
        self.messageButton.frame = CGRectMake(284, 34, 18, 18)
        self.messageButton.setImage(UIImage(named: "messageButton"), forState: .Normal)
        self.addSubview(messageButton)
    }
    
    func addXButton() {
        xButton.frame = CGRectMake(60, 485, 59, 59)
        xButton.setImage(UIImage(named: "xButton"), forState: .Normal)
        addSubview(xButton)
    }
    
    func addCheckButton() {
        checkButton.frame = CGRectMake(200, 485, 59, 59)
        checkButton.setImage(UIImage(named: "checkButton"), forState: .Normal)
        addSubview(checkButton)
    }
    
    func setLoadedCardsCap() {
        numLoadedCardsCap = 0;
        if (exampleCardLabels.count > MAX_BUFFER_SIZE) {
            numLoadedCardsCap = exampleCardLabels.count
        } else {
            numLoadedCardsCap = MAX_BUFFER_SIZE
        }
        
    }
    
    func createCards() {
        if (numLoadedCardsCap > 0) {
            let cardFrame = CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)
            
            for cardLabel in exampleCardLabels {
                var newCard = DraggableView(frame: cardFrame, information: cardLabel)
                newCard.delegate = self;
                allCards.addObject(newCard)
            }
        }
    }

    func displayCards() {
        for(var i = 0; i < numLoadedCardsCap; i++) {
            loadedCards.addObject(allCards[i])
            if (i > 0) {
                insertSubview(loadedCards[i] as UIView, belowSubview: loadedCards[i-1] as UIView)
                // is there a way to define the array with UIView elements so I don't have to cast?
            } else {
                addSubview(loadedCards[0] as UIView)
            }
            cardsLoadedIndex++;
        }
    }
    
    func cardSwipedLeft(card: UIView) {
        print ("Swiped left")
    }
    func cardSwipedRight(card: UIView) {
        print ("Swiped right")
    }

    
}