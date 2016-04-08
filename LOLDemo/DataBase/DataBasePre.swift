//
//  DataBasePre.swift
//  LOLDemo
//  数据库配置类
//  Created by gaomingyang1987 on 16/4/7.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class DataBasePre: NSObject {
//数据库名字
private static let dataBaseName = "LOLDemo.db"

//==BaseModel 表配置信息
    
//表名
static let  kBaseModelTableName = "baseModel"
//
static let  kBaseModelLid       = "lid"
static let  kBaseModelTitle     = "title"
static let  kBaseModelIcon      = "icon"
static let  kBaseModelSubTitle  = "subTitle"
    
static let  kBaseModelType      = "type"
//===HeaderBaseModel 表配置信息
//表名
static let  kHeaderBaseModelTableName  = "HeaderBaseModel"
//
static let  kHeaderBaseModelArticle_id = "article_id"
static let  kHeaderBaseModelBan_img    = "ban_img"
static let  kHeaderBaseModelName       = "name"

static let  kHeaderBaseModelType       = "type"
    /**
     获取数据库路径
     **/
    class func getDataBasePath() ->String{
    var path:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    path = path.stringByAppendingString("/\(dataBaseName)")
    print("数据库路径为:\(path)")
    return path
    }
    
}
