//
//  OverlayView.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import Foundation
import UIKit

enum OverlayViewMode {
    case None
    case Left
    case Right
}


class OverlayView:UIView {
    var imageView = UIImageView()
    var mode = OverlayViewMode.None
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setView()
        addImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func addImageView() {
        setImageViewFrame()
        self.addSubview(imageView)
    }
    
    func setImageViewFrame() {
        imageView.frame = CGRectMake(50, 50, 100, 100)

    }
    func setImageView(buttonString: String) {
        imageView.image = UIImage(named: buttonString)
    }
    
    func setMode(mode: OverlayViewMode) {
        if (self.mode == mode) {
            return;
        }
        
        self.mode = mode;
        
        switch (mode) {
        case .Left:
            setImageView("noButton")
            break;
        case .Right:
            setImageView("yesButton")
            break;
        case .None:
            break;
            
        }
    }
    
}