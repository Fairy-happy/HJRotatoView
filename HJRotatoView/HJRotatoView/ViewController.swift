//
//  ViewController.swift
//  HJRotatoView
//
//  Created by 黄珏 on 16/3/8.
//  Copyright © 2016年 黄珏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fronV.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        view.addSubview(fronV)
    }
    
    lazy var fronV:HJRotatoView = HJRotatoView(fristV: self.testV1, secondV: self.testV2)
    
    lazy var testV1 : UIView = {
        let tV1 = UIView()
        tV1.backgroundColor = UIColor.blackColor()
        tV1.frame = CGRectMake(0, 0, 200, 200)
        
        let testView = UIImageView(image: UIImage(named:"1"))
        testView.frame = tV1.bounds
        tV1.addSubview(testView)
        return tV1
        }()
    
    lazy var testV2 : UIView = {
        let tV1 = UIView()
        tV1.backgroundColor = UIColor.yellowColor()
        tV1.frame = CGRectMake(0, 0, 200, 200)
        
        let testView = UIImageView(image: UIImage(named:"2"))
        testView.frame = tV1.bounds
        tV1.addSubview(testView)
        return tV1
        }()

}

