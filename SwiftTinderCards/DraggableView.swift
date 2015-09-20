//
//  DraggableView.swift
//  SwiftTinderCards
//
//  Created by Lukasz Gandecki on 3/23/15.
//  Copyright (c) 2015 Lukasz Gandecki. All rights reserved.
//

import Foundation
import UIKit

let ACTION_MARGIN = CGFloat(120) //%%% distance from center where the action applies. Higher = swipe further in order for the action to be called
let SCALE_STRENGTH = CGFloat(4) //%%% how quickly the card shrinks. Higher = slower shrinking
let SCALE_MAX = CGFloat(0.93) //%%% upper bar for how much the card shrinks. Higher = shrinks less
let ROTATION_MAX = CGFloat(1) //%%% the maximum rotation allowed in radians.  Higher = card can keep rotating longer
let ROTATION_STRENGTH = CGFloat(320) //%%% strength of rotation. Higher = weaker rotation
let ROTATION_ANGLE = CGFloat(M_PI/8) //%%% Higher = stronger rotation angle


class DraggableView:UIView{
    var delegate:DraggableViewDelegate?
    
    var xFromCenter = CGFloat()
    var yFromCenter = CGFloat()
    
    var originalPoint = CGPoint()
    
    var information = UILabel()
    
    var panGestureRecognizer = UIPanGestureRecognizer()
    
    var overlayView:OverlayView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, information: String) {
        self.init(frame: frame)
        setupView()
        addOverlayView()
        addGestureRecognizer()
        setMyInformation(information)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.layer.cornerRadius = 4;
        self.layer.shadowRadius = 3;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    func addOverlayView() {
        let overlayViewFrame = CGRectMake(self.frame.size.width/2-100, 0, 100, 100)
        overlayView = OverlayView(frame: overlayViewFrame)
        addSubview(overlayView!)
    }

    func addGestureRecognizer() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "beingDragged:")
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) {
        xFromCenter = gestureRecognizer.translationInView(self).x;
        yFromCenter = gestureRecognizer.translationInView(self).y;
        
        switch (gestureRecognizer.state) {
            case .Began:
                self.originalPoint = self.center;
                break;
            
            
            case .Changed:
                //%%% dictates rotation (see ROTATION_MAX and ROTATION_STRENGTH for details)
                let rotationStrength = min(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
                
                //%%% degree change in radians
                let rotationAngel = (ROTATION_ANGLE * rotationStrength);
                
                //%%% amount the height changes when you move the card up to a certain point
                let scale = max(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
                
                //%%% move the object's center by center + gesture coordinate
                self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
                
                //%%% rotate by certain amount
                let transform = CGAffineTransformMakeRotation(rotationAngel);
                
                //%%% scale by certain amount
                let scaleTransform = CGAffineTransformScale(transform, scale, scale);
                
                //%%% apply transformations
                self.transform = scaleTransform;
                
                 self.updateOverlay(xFromCenter)
                break;
            case .Ended:
                afterSwipeAction()
            break;
            default:
            break;
        }
        
    }
    
    func afterSwipeAction() {
        if (xFromCenter > ACTION_MARGIN) {
            rightAction();
        } else if (xFromCenter < -ACTION_MARGIN){
            leftAction();
        } else {
            animateCardBack()
           
        }
    }
    
    func rightAction() {
        animateCardToTheRight()
        delegate?.cardSwipedRight(self)
    }
    
    func animateCardToTheRight() {
        let rightEdge = CGFloat(500)
        animateCardOutTo(rightEdge)
    }
    
    func leftAction() {
        animateCardToTheLeft()
        delegate?.cardSwipedLeft(self)
    }
    
    func animateCardToTheLeft() {
        let leftEdge = CGFloat(-500)
        animateCardOutTo(leftEdge)
    }
    
    func animateCardOutTo(edge: CGFloat) {
        let finishPoint = CGPointMake(edge, 2*yFromCenter + self.originalPoint.y)
        UIView.animateWithDuration(0.3, animations: {
            self.center = finishPoint;
            }, completion: {
                (value: Bool) in
                self.removeFromSuperview()
        })
        
    }

    func animateCardBack() {
        UIView.animateWithDuration(0.3, animations: {
            self.center = self.originalPoint;
            self.transform = CGAffineTransformMakeRotation(0);
                self.overlayView?.alpha = 0;
            }
        )
    }
    
    func updateOverlay(distance: CGFloat) {
        if (distance > 0) {
            overlayView?.setMode(.Right)
        } else {
            overlayView?.setMode(.Left)
        }
        overlayView?.alpha = min(fabs(distance)/100, 0.4)
    }
    func rightClickAction() {
        rightAction()
    }
    
    func leftClickAction() {
        leftAction()
    }
    
    func setMyInformation(information: String) {
        self.information.frame = CGRectMake(0, 50, self.frame.size.width, 100)
        self.information.textAlignment = .Center
        self.information.text = information;
        self.information.textColor = UIColor.blackColor();
        self.addSubview(self.information)
    }
    
    
}

protocol DraggableViewDelegate {
    func cardSwipedLeft(card: DraggableView)
    func cardSwipedRight(card: DraggableView)
}