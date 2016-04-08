//
//  HeaderBaseModel.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class HeaderBaseModel: NSObject {

    var article_id:String!
    var ban_img:String!
    var name:String!
    
    //区分是哪个界面的缓存
    var type:String!
    override init() {
        
    }
    
    init(dict:NSDictionary) {
    super.init()
    self.article_id = dict["article_id"] as! String
    let tmp:NSString  = dict["ban_img"] as! String
    self.ban_img    = tmp.URLDecodedString()
   // print("HeaderBaseModel,self.ban_img:\(self.ban_img)")
    self.name       = dict["name"] as! String
    
    self.type   = dict["type"] as! String
    }
}
