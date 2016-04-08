//
//  MYTitleLabel.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/5.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class MYTitleLabel: UILabel {

    var scale:CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = NSTextAlignment.Center
        self.font = UIFont.systemFontOfSize(18)
        self.scale = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /**
     设置缩放
     **/
    func  setScale(scale:CGFloat){
    self.scale = scale
    self.textColor = UIColor(red: scale, green: 0.0, blue: 0.0, alpha: 1)
    let minScale  = CGFloat(0.7)
    let trueScale = minScale + (1-minScale)*scale
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale)
    }
}
