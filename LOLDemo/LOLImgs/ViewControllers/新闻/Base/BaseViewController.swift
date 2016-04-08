//
//  BaseViewController.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let kScreenWidth = UIScreen.mainScreen().bounds.size.width
    let kScreenHeight = UIScreen.mainScreen().bounds.size.height
    
    //cell 的数据源
     var datas:NSMutableArray!
    //header 的数据
     var headerDatas:NSMutableArray!
    //页码
     var page = 1
    
    var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.getNetDatas()
    }
    /**
     初始化ui
     **/
    private func initUI(){
    datas = NSMutableArray()
    headerDatas = NSMutableArray()
        
    self.tableView = UITableView(frame: CGRect(x: 0, y:0, width: kScreenWidth, height: kScreenHeight-64-49), style: UITableViewStyle.Grouped)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    //注册cell
    self.tableView.registerClass(BaseCell.classForKeyedUnarchiver(), forCellReuseIdentifier: BaseCell.getID())
    //注册header
    self.tableView.registerClass(HeaderBaseCell.classForKeyedUnarchiver(), forHeaderFooterViewReuseIdentifier: HeaderBaseCell.getID())
    self.view.addSubview(self.tableView)
    
    self.tableView.addHeaderWithCallback { 
        print("触发了下啦刷新")
        self.page = 1
        self.getNetDatas()
        }
    self.tableView.addFooterWithCallback { 
        print("触发了上啦加载更多")
        self.page+=1
        self.getNetDatas()
        }

    }
    /**
     获取网络数据
     **/
     func getNetDatas(){
    //print("获取网络数据!")
    }
//== UITableViewDelegate,UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  self.datas.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BaseCell! = tableView.dequeueReusableCellWithIdentifier(BaseCell.getID()) as! BaseCell
        let model:BaseModel = self.datas[indexPath.row] as! BaseModel
        //
        cell.setModel(model)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 200
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 165
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("=========")
        let model:BaseModel = self.datas[indexPath.row] as! BaseModel
        let newsVC = NewsDetailViewController()
        newsVC.newsId = model.lid
        self.navigationController?.pushViewController(newsVC, animated: true)
        self.hiddenTabbar()
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:HeaderBaseCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeaderBaseCell.getID()) as! HeaderBaseCell
        //传入数组数据
        headerView.setDatas(self.headerDatas)
        
        return headerView
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func viewWillAppear(animated: Bool) {
        self.showTabbar()
    }
    /**
     隐藏tabbar
     **/
    func hiddenTabbar(){
        let adel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let tabbar = adel.gmyTabbarVC
        tabbar.hidenTabar()
    }
    /**
     显示tabbar
     **/
    func showTabbar(){
        let adel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let tabbar = adel.gmyTabbarVC
        tabbar.showTabbar()
    }
}
