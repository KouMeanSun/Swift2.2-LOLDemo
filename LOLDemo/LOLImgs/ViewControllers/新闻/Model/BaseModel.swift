//
//  BaseModel.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
 
    var lid:String!
    var title:String!
    
    var icon:String!
    var subTitle:String!
    
    //判断是那个页面的
    var type:String!
    
    override init() {
        
    }
    
     init(dict:NSDictionary) {
     super.init()
     self.lid = dict["id"]  as! String
     self.subTitle = dict["short"] as! String
    
     self.title = dict["title"]  as! String
     self.icon  = dict["icon"]   as! String
        
     self.type  = dict["type"] as! String
     
    }
}
