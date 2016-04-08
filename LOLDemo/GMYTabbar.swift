//
//  GMYTabbar.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/5.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

protocol GMYTabbarDelegate:NSObjectProtocol {
    /**
    告诉调用者，从哪里跳转到哪里
     **/
   func selectedGMYTabbar(tabbar:GMYTabbar,from:Int,to:Int)
}

class GMYTabbar: UIView {
    var delegate:GMYTabbarDelegate!
  //存储选中状态的状态
 private  var  selectedBtn:UIButton = UIButton ()
    /**
      根据用户传过来的图片，创建button，按顺序添加图片
     **/
    func addButtonWithImage(image:UIImage,selectedImg:UIImage){
    let button = UIButton(type: .Custom)
    button.setImage(image, forState: .Normal)
    button.setImage(selectedImg, forState: .Selected)
    self.addSubview(button)
        button.addTarget(self, action: #selector(self.click(_:)), forControlEvents: .TouchUpInside)
    //首先天假的button设置为选中状态
        if self.subviews.count==1 {
            self.click(button)
        }
    }
    
    @objc private func click(btn:UIButton){
    self.selectedBtn.selected = false
    btn.selected = true
    //把点击的消息传给调用者
    self.delegate.selectedGMYTabbar(self, from: selectedBtn.tag, to: btn.tag)
 
    //将传进来的button赋值
    self.selectedBtn = btn
    }
    //view 加载子view方法
    override func layoutSubviews() {
      //获取子view的数据
        let  count:Int = self.subviews.count
        for i in 0..<count {
        let button = self.subviews[i]
        button.tag = i
        //设置button的frame
        let height = self.bounds.size.height
            //需要将int转化为CGFloat
        let width  = self.bounds.size.width / CGFloat(count)
            let y:CGFloat = 0
            let x:CGFloat = CGFloat(i)*width
            button.frame  = CGRect(x: x , y: y, width: width, height: height)
        }
      self.backgroundColor = UIColor.blackColor()
    }
}
