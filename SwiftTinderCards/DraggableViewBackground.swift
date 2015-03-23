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
    let menuButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let messageButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let checkButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let xButton:UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
    }
    func cardSwipedLeft(card: UIView) {
        print ("Swiped left")
    }
    func cardSwipedRight(card: UIView) {
        print ("siema")
    }
    func setupView() {
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1);
        self.menuButton.frame = CGRectMake(17, 34, 22, 15);
        let menuButtonImage = UIImage(named: "menuButton") as UIImage!
        self.menuButton.setImage(menuButtonImage, forState: .Normal)
        
    }

}