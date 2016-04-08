//
//  GameViewController.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController {
let  TAG = "GameViewController"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orangeColor()

        super.datas.addObjectsFromArray(BaseModelDB.getInstance().findAll(API.kMatchUrlStirng))
        super.headerDatas.addObjectsFromArray(HeaderBaseModelDB.getInstance().findAll(API.kMatchUrlStirng))
        super.tableView.reloadData()
    }
    override func getNetDatas(){
        let urlStr =  String(format:  API.kMatchUrlStirng, super.page)
        //  print("TAG,urlStr:\(urlStr)")
        HTTPConnection.getRequestWithUrl(urlStr, param: nil) { (data, error) in
            if error != nil {
                print("\(self.TAG)数据获取失败！error:\(error)")
                if super.page == 1 {
                    super.tableView.headerEndRefreshing()
                }else{
                    super.tableView.footerEndRefreshing()
                }
                return
            }
            //下拉刷新时，先删除旧数据
            if super.page == 1 {
                super.datas .removeAllObjects()
                super.headerDatas.removeAllObjects()
                BaseModelDB.getInstance().deleteAll(API.kMatchUrlStirng)
            HeaderBaseModelDB.getInstance().deleteAll(API.kMatchUrlStirng)
            }
            //获取数据成功
            //result
            let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            let resultData:Array<NSDictionary> = jsonData["result"] as! Array
            for dict in resultData {
                // print("\(self.TAG),dict:\(dict)")
                dict.setValue(API.kMatchUrlStirng, forKey: "type")
                let bModel  = BaseModel(dict: dict)
                super.datas.addObject(bModel)
                //只缓存第一页数据
                if super.page == 1{
                    BaseModelDB.getInstance().insertIntoModel(bModel)
                }
            }
            //recomm
            let recommData:Array<NSDictionary> = jsonData["recomm"] as! Array
            for dict in recommData {
                dict.setValue(API.kMatchUrlStirng, forKey: "type")
                let hModel = HeaderBaseModel(dict: dict)
                super.headerDatas.addObject(hModel)
                //只缓存第一页数据
                if super.page == 1 {
                    HeaderBaseModelDB.getInstance().insertIntoModel(hModel)
                }
            }
            //刷新tableview
            
            dispatch_async(dispatch_get_main_queue(), {
                super.tableView.reloadData()
                //结束动画
                super.tableView.headerEndRefreshing()
                super.tableView.footerEndRefreshing()
            })
        }
    }

}
