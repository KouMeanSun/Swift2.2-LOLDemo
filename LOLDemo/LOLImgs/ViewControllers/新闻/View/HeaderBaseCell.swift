//
//  HeaderBaseCell.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class HeaderBaseCell: UITableViewHeaderFooterView,UIScrollViewDelegate {

//传入头部试图的数组
    var headerDatas:NSArray!
    
 let kScreenWidth = UIScreen.mainScreen().bounds.size.width
 let kHeaderHeight = CGFloat(200)
    
    var myScrollView:UIScrollView!
    var titleLbl:UILabel!
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        
//        
//       self.myScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
//       self.myScrollView.delegate = self
//       self.contentView.addSubview(self.myScrollView)
//        
//       self.titleLbl = UILabel(frame: CGRect(x: 0, y: kHeaderHeight-30, width: kScreenWidth, height: 30))
//       self.titleLbl.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
//       self.contentView.addSubview(self.titleLbl)
//    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
               self.myScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 200))
               self.myScrollView.delegate = self
               self.myScrollView.pagingEnabled = true
               self.contentView.addSubview(self.myScrollView)
        
               self.titleLbl = UILabel(frame: CGRect(x: 0, y: kHeaderHeight-30, width: kScreenWidth, height: 30))
               self.titleLbl.textColor = UIColor.whiteColor()
               self.titleLbl.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
               self.contentView.addSubview(self.titleLbl)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setDatas(datas:NSArray){
    self.headerDatas = datas
    //设置contentsize
    self.myScrollView.contentSize = CGSize(width: self.headerDatas.count*Int(kScreenWidth), height: 0)
    //先移除旧的UI
        for view in self.myScrollView.subviews{
           view.removeFromSuperview()
        }
    //添加新的ui,并且赋值
        for i in 0..<self.headerDatas.count {
            let headerModel:HeaderBaseModel = self.headerDatas[i] as! HeaderBaseModel
            let imgSrc:String = headerModel.ban_img
            let name:String   = headerModel.name
            
            let imgView:UIImageView = UIImageView(frame: CGRect(x: CGFloat(i)*kScreenWidth, y: 0, width: kScreenWidth, height: 200))
//            WebCache.sd_setImageWithString(imgSrc, placlHolder: nil, imageView: imgView)
            imgView.sd_setImageWithURL(NSURL(string: imgSrc))
            self.myScrollView.addSubview(imgView)
            //名称
            if  i==0 {
                self.titleLbl.text = name
            }
        }
    }
    
    // - scrollView 代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        let index  = offset.x/kScreenWidth
        
        let baseModel = self.headerDatas[Int(index)]
        self.titleLbl.text = baseModel.name
    }
    
    
    class func getID() ->String {
        return "HeaderBaseCell"
    }

}
