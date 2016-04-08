//
//  NewsDetailViewController.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/7.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

let kScreenWidth  = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
    
    //新闻Id
    var newsId:String!
    override func viewDidLoad() {
        super.viewDidLoad()
     self.initUI()
    }
    func initUI(){
    self.title = "新闻详情"
    self.view.backgroundColor = UIColor.purpleColor()
    //创建nav
    self.createNav()
    self.createWebView()
    }
    /**
     创建webview
     **/
    func createWebView(){
        let urlStr:String = String(format: API.kNewsDetailUrlString, self.newsId)
   let webView = UIWebView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-64))
    webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
    self.view.addSubview(webView)
    }
    /**
     创建nav
     **/
    func createNav(){
      //背景图片
    let navBgImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 64))
    navBgImgView.image = UIImage(named: "nav_bar_bg_for_seven")
    navBgImgView.userInteractionEnabled = true
    self.view.addSubview(navBgImgView)
    
    //标题
    let titleLbl = UILabel(frame: CGRect(x: 100, y: 20, width: kScreenWidth-200, height: 44))
    titleLbl.text = "新闻详情"
    titleLbl.textColor = UIColor.whiteColor()
    titleLbl.textAlignment = NSTextAlignment.Center
    navBgImgView.addSubview(titleLbl)
    
    //返回按钮
    let backBtn = UIButton(type: .Custom)
    backBtn.frame = CGRect(x: 10, y: 27, width: 60, height: 30)
    backBtn.setBackgroundImage(UIImage(named: "nav_btn_back_normal"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(self.backClick), forControlEvents: .TouchUpInside)
    navBgImgView.addSubview(backBtn)

    
    }
    /**
     返回
     **/
    func backClick(){
    self.navigationController?.popViewControllerAnimated(true)
    }
        //修改状态栏字体颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
