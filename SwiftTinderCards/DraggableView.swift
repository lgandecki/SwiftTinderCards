//
//  DraggableView.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import Foundation
import UIKit

class DraggableView:UIView{
    var delegate:DraggableViewDelegate?
    var information:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, information: String) {
        self.init(frame: frame)
        setupView()
//        addGestureRecognizer()
        setInformation(information)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView() {
        self.layer.cornerRadius = 4;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = UIColor.whiteColor()
        
    }
    func setInformation(information: String) {
        self.information.frame = CGRectMake(0, 50, self.frame.size.width, 100)
        self.information.textAlignment = .Center
        self.information.text = information;
        self.information.textColor = UIColor.blackColor();
        self.addSubview(self.information)
    }
}

protocol DraggableViewDelegate {
    func cardSwipedLeft(card: UIView)
    func cardSwipedRight(card: UIView)
}