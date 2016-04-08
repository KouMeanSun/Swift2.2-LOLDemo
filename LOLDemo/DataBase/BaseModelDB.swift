//
//  BaseModelDB.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/7.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class BaseModelDB: NSObject {
    let TAG = "BaseModelDB"
    var db:FMDatabase!
    
    
 //====
    private static let instance:BaseModelDB = BaseModelDB()
    
    class func getInstance()->BaseModelDB{
        
    return instance
    }
    
    private  override init() {
       
        let queue = StoreManagerHelper.getSharedDatabaseQueue()
        queue.inDatabase { (db) in
            if db.open() {
                let sqlStr  = "CREATE TABLE IF NOT EXISTS \(DataBasePre.kBaseModelTableName) (ID INTEGER PRIMARY KEY AUTOINCREMENT,\(DataBasePre.kBaseModelLid) TEXT,\(DataBasePre.kBaseModelTitle) TEXT,\(DataBasePre.kBaseModelIcon) TEXT,\(DataBasePre.kBaseModelSubTitle) TEXT,\(DataBasePre.kBaseModelType) TEXT)"
                
                db.executeUpdate(sqlStr, withArgumentsInArray: nil)
                print("创建表完毕！")
            }else {
            print("打开数据库失败")
            }
        }

    }
    /**
     查询所有数据
     **/
    func findAll(type:String) ->Array<BaseModel> {
    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    var list:Array<BaseModel> = Array()
    queue.inDatabase { (db) in
        let sqlStr = "SELECT * FROM \(DataBasePre.kBaseModelTableName) WHERE type = ?"
        let rs:FMResultSet = db.executeQuery(sqlStr, withArgumentsInArray: [type])
        
        while rs.next() {
            let lid:String = rs.stringForColumn(DataBasePre.kBaseModelLid)
            let title:String = rs.stringForColumn(DataBasePre.kBaseModelTitle)
            let icon:String = rs.stringForColumn(DataBasePre.kBaseModelIcon)
            let subTitle:String = rs.stringForColumn(DataBasePre.kBaseModelSubTitle)
            let type:String = rs.stringForColumn(DataBasePre.kBaseModelType)
            let model:BaseModel = BaseModel()
            model.lid = lid
            model.title = title
            model.icon = icon
            model.subTitle = subTitle
            model.type = type
            list.append(model)
        }
       
        }
        return list
    }
    /**
     插入数据
     **/
    func  insertIntoModel(model:BaseModel){
    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    queue.inDatabase { (db) in
        let sqlStr = "INSERT INTO \(DataBasePre.kBaseModelTableName) (\(DataBasePre.kBaseModelLid),\(DataBasePre.kBaseModelTitle),\(DataBasePre.kBaseModelIcon),\(DataBasePre.kBaseModelSubTitle),\(DataBasePre.kBaseModelType)) VALUES (?,?,?,?,?)"
        db.executeUpdate(sqlStr, withArgumentsInArray: [model.lid,model.title,model.icon,model.subTitle,model.type])
        }

    }
    /**
     删除所有数据
     **/
    func  deleteAll(type:String){

    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    queue.inDatabase { (db) in
        let sqlStr = "DELETE FROM \(DataBasePre.kBaseModelTableName) WHERE type = ?"
        db.executeUpdate(sqlStr, withArgumentsInArray: [type])
        }

    }

}
