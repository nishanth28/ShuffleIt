//
//  Spinner.swift
//  ShuffleIt
//
//  Created by Nishanth P on 1/14/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import Foundation
import UIKit

class AnimatedEqualizerView: UIView {
    
    var containerView: UIView!
    let containerLayer = CALayer()
    
    var childLayers = [CALayer]()
    let lowBezierPath = UIBezierPath()
    let middleBezierPath = UIBezierPath()
    let highBezierPath = UIBezierPath()
    
    var animations = [CABasicAnimation]()
    
    var isShowing = false;
    
    init(containerView: UIView) {
        self.containerView = containerView
        super.init(frame: containerView.frame)
        self.initCommon()
        self.initContainerLayer()
        self.initBezierPath()
        self.initBars()
        self.initAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate() {
        if (isShowing) {
            isShowing = false
            return
        }
        isShowing = true
        for index in 0...4 {
            let delay = 0.1 * Double(index)
            let dispatchTime: DispatchTime = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                self.addAnimation(index)
            })
        }
    }
    
    func stopAnimate(){
        
        
        
    }
    
    func initCommon() {
        self.frame = CGRect(x: 0, y: 0, width: containerView!.frame.size.width, height: containerView!.frame.size.height)
    }
    
    func initContainerLayer() {
        containerLayer.frame = CGRect(x: 0, y: 0, width: 60, height: 65)
        containerLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        containerLayer.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.layer.addSublayer(containerLayer)
    }
    
    func initBezierPath() {
        lowBezierPath.move(to: CGPoint(x: 0, y: 55));
        lowBezierPath.addLine(to: CGPoint(x: 0, y: 65));
        lowBezierPath.addLine(to: CGPoint(x: 3, y: 65));
        lowBezierPath.addLine(to: CGPoint(x: 3, y: 55));
        lowBezierPath.addLine(to: CGPoint(x: 0, y: 55));
        lowBezierPath.close();
        
        middleBezierPath.move(to: CGPoint(x: 0, y: 15));
        middleBezierPath.addLine(to: CGPoint(x: 0, y: 65));
        middleBezierPath.addLine(to: CGPoint(x: 3, y: 65));
        middleBezierPath.addLine(to: CGPoint(x: 3, y: 15));
        middleBezierPath.addLine(to: CGPoint(x: 0, y: 15));
        middleBezierPath.close();
        
        highBezierPath.move(to: CGPoint(x: 0, y: 0));
        highBezierPath.addLine(to: CGPoint(x: 0, y: 65));
        highBezierPath.addLine(to: CGPoint(x: 3, y: 65));
        highBezierPath.addLine(to: CGPoint(x: 3, y: 0));
        highBezierPath.addLine(to: CGPoint(x: 0, y: 0));
        highBezierPath.close();
    }
    
    func initBars() {
        for index in 0...4 {
            let bar = CAShapeLayer()
            bar.frame = CGRect(x: CGFloat(15 * index), y: 0, width: 3, height: 65)
            bar.path = lowBezierPath.cgPath
            bar.fillColor = UIColor.white.cgColor
            containerLayer.addSublayer(bar)
            childLayers.append(bar)
        }
    }
    
    func initAnimation() {
        for index in 0...4 {
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = lowBezierPath.cgPath
            if (index % 2 == 0) {
                animation.toValue = middleBezierPath.cgPath
            } else {
                animation.toValue = highBezierPath.cgPath
            }
            animation.autoreverses = true
            animation.duration = 0.5
            animation.repeatCount = MAXFLOAT
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
            animations.append(animation)
        }
    }
    
    func addAnimation(_ index: Int) {
        let animationKey = "\(index)Animation"
        childLayers[index].add(animations[index], forKey: animationKey)
    }
}

