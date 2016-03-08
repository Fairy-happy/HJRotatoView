//
//  HJRotatoView.swift
//  HJRotatoView
//
//  Created by 黄珏 on 16/3/8.
//  Copyright © 2016年 黄珏. All rights reserved.
//

import UIKit

class HJRotatoView: UIView {

    enum HJRotatoViewStyle {
        case leftRightSlid
        case bottomSlid
        case dipSlid
    }
    let animationTime: NSTimeInterval = 0.5
    var isRotato = false
    
    var fristV : UIView
    var secondV : UIView
    
    
    init(fristV:UIView,secondV:UIView){
        self.fristV = fristV
        self.secondV = secondV
        super.init(frame: CGRectMake(0, 0, 200, 200))
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        let panGesture = UIPanGestureRecognizer(target:self, action:Selector("handleGesture:"))
        addGestureRecognizer(panGesture)
        if self.superview is HJRotatoView {
            self.layer.transform = self.transformForPercent(1.0)
        }
    }
    
    
    func setupUI(){
        //        backgroundColor = UIColor(red: CGFloat(rand()%255) / 255.0, green: CGFloat(rand()%255) / 255.0, blue: CGFloat(rand()%255) / 255.0, alpha: 1.0)
        //        self.layer.transform = self.transformForPercent(1.0)
        
        addSubview(fristV)
        
        
    }
    
    func handleGesture(recognizer : UIPanGestureRecognizer){
        
        let translation : CGPoint
        
        if self.superview is HJRotatoView {
            translation = recognizer.translationInView(recognizer.view!.superview!.superview)
        }else{
            translation = recognizer.translationInView(recognizer.view!.superview!)
        }
        var progress = translation.x / self.bounds.width * (isRotato ? 1.0 : -1.0)
        
        progress = abs(progress)
        
        switch recognizer.state {
            //        case .Began:self.setToPercent(isRotato ? progress: (1.0 - progress))
        case .Changed:
            let rotatoPercent = translation.x / bounds.width

            if self.superview is HJRotatoView {
                (self.superview as! HJRotatoView).setToPercent(1+rotatoPercent)
                
                if isRotato && progress >= 0.50 {
                    layer.hidden = true
                }else{
                    layer.hidden = false
                }
                break
            }
            if !isRotato && progress >= 0.5 {
                secondView.layer.hidden = false
            }else{
                secondView.layer.hidden = true
            }
            setToPercent(rotatoPercent)
        case .Ended:
            //恢复
            UIView.animateWithDuration(animationTime, animations: { () -> Void in
                if progress > 0.5{
                    self.layer.transform = self.transformForPercent(1.0)
                    if self.superview is HJRotatoView {
                        self.superview?.layer.transform = self.transformForPercent(0.0)
                    }else{
                        
                    }
                }else{
                    if self.superview is HJRotatoView {
                        self.superview?.layer.transform = self.transformForPercent(1.0)
                    }else{
                        self.layer.transform = self.transformForPercent(0.0)
                    }
                }
            })
        case .Failed:
            
            var targetProgress: CGFloat
            if (isRotato) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animateWithDuration(0.25, animations: {
                self.setToPercent(targetProgress)
                }, completion: {_ in
                    self.layer.shouldRasterize = false
            })
        default:
            break
        }
    }
    
    func setToPercent(percent: CGFloat) {
        layer.transform = transformForPercent(percent)
    }
    
    
    func transformForPercent(var percent:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        
        if percent <= -0.5 && percent <= 0 {
            percent = -abs(percent)
        }else if percent >= 0.5 && percent >= 0{
            
        }
        let angle = ( percent) * CGFloat(M_PI)
        return CATransform3DRotate(identity, angle, 0, 1, 0)
    }
    
    lazy var secondView : HJRotatoView = {
        let v = HJRotatoView(fristV: self.secondV, secondV: self.fristV)
        self.addSubview(v)
        v.isRotato = true
        return v
        }()


}
