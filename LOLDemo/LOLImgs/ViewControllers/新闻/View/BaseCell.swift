//
//  BaseCell.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

 let kScreenWidth  = UIScreen.mainScreen().bounds.size.width
 let kScreenHeight = UIScreen.mainScreen().bounds.size.height
    
    var icon:UIImageView!
    var titleLbl:UILabel!
    var descLbl:UILabel!
 
    
    var myModel:BaseModel!
 override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.icon = UIImageView(frame: CGRect(x: 10, y: 10, width: 150, height: 150))
    self.icon.layer.cornerRadius = 8
    self.icon.layer.masksToBounds = true
    self.contentView.addSubview(self.icon)
    
    self.titleLbl = UILabel(frame: CGRect(x: CGRectGetMaxX(self.icon.frame)+10, y: 10, width: kScreenWidth-self.icon.bounds.width-30, height: 60))
    self.titleLbl.font = UIFont.systemFontOfSize(16)
    self.titleLbl.textColor = UIColor.blackColor()
    self.titleLbl.numberOfLines = 2
    self.contentView.addSubview(self.titleLbl)
    
    self.descLbl = UILabel(frame: CGRect(x: CGRectGetMaxX(self.icon.frame)+10, y: CGRectGetMaxY(self.titleLbl.frame), width: kScreenWidth-self.icon.bounds.width-30, height: 50))
    self.descLbl.font = UIFont.systemFontOfSize(13)
    self.descLbl.textColor = UIColor.grayColor()
    self.descLbl.numberOfLines = 4
    self.contentView.addSubview(self.descLbl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model:BaseModel){
    self.myModel = model
    //赋值
//    WebCache.sd_setImageWithString(model.icon, placlHolder: nil, imageView: self.icon)
    self.icon.sd_setImageWithURL(NSURL(string: model.icon))
    self.titleLbl.text = model.title
    self.descLbl.text  = model.subTitle
        
    }
    
    class func getID() ->String {
    return "BaseCell"
    }
}
