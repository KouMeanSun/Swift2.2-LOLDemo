//
//  HeaderBaseModelDB.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/7.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class HeaderBaseModelDB: NSObject {
    let TAG = "HeaderBaseModelDB"

    //====
    private static let instance:HeaderBaseModelDB = HeaderBaseModelDB()
    
    class func getInstance()->HeaderBaseModelDB{
        
        return instance
    }
    
    private  override init() {
        
    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    queue.inDatabase { (db) in
        let sqlStr  = "CREATE TABLE IF NOT EXISTS \(DataBasePre.kHeaderBaseModelTableName) (ID INTEGER PRIMARY KEY AUTOINCREMENT,\(DataBasePre.kHeaderBaseModelArticle_id) TEXT,\(DataBasePre.kHeaderBaseModelBan_img) TEXT,\(DataBasePre.kHeaderBaseModelName) TEXT,\(DataBasePre.kHeaderBaseModelType) TEXT)"
        
        db.executeUpdate(sqlStr, withArgumentsInArray: nil)
        print("创建表完毕！")
        }
        

    }
    /**
     查询所有数据
     **/
    func findAll(type:String) ->Array<HeaderBaseModel> {

let queue = StoreManagerHelper.getSharedDatabaseQueue()
    var list:Array<HeaderBaseModel> = Array()
queue.inDatabase { (db) in
    let sqlStr = "SELECT * FROM \(DataBasePre.kHeaderBaseModelTableName) WHERE type = ?"
    let rs:FMResultSet = db.executeQuery(sqlStr, withArgumentsInArray: [type])

    while rs.next() {
        let article_id:String = rs.stringForColumn(DataBasePre.kHeaderBaseModelArticle_id)
        let ban_img:String = rs.stringForColumn(DataBasePre.kHeaderBaseModelBan_img)
        let name:String = rs.stringForColumn(DataBasePre.kHeaderBaseModelName)
        let type:String = rs.stringForColumn(DataBasePre.kHeaderBaseModelType)
        let model:HeaderBaseModel = HeaderBaseModel()
        model.article_id = article_id
        model.ban_img = ban_img
        model.name   = name
        model.type   = type
        
        list.append(model)
    }
  }
        return list
    }
    /**
     插入数据
     **/
    func  insertIntoModel(model:HeaderBaseModel){
    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    queue.inDatabase { (db) in
        let sqlStr = "INSERT INTO \(DataBasePre.kHeaderBaseModelTableName) (\(DataBasePre.kHeaderBaseModelArticle_id),\(DataBasePre.kHeaderBaseModelBan_img),\(DataBasePre.kHeaderBaseModelName),\(DataBasePre.kHeaderBaseModelType)) VALUES (?,?,?,?)"
        db.executeUpdate(sqlStr, withArgumentsInArray: [model.article_id,model.ban_img,model.name,model.type])
        }
   
    }
    /**
     删除所有数据
     **/
    func  deleteAll(type:String){

    let queue = StoreManagerHelper.getSharedDatabaseQueue()
    queue.inDatabase { (db) in
        let sqlStr = "DELETE FROM \(DataBasePre.kHeaderBaseModelTableName) WHERE type = ?"
       db.executeUpdate(sqlStr, withArgumentsInArray: [type])
        }

        
    }
}
