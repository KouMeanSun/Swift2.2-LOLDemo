//
//  GMYTabbarController.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/5.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class GMYTabbarController: UITabBarController ,GMYTabbarDelegate{
    /**
     隐藏tabbar
     **/
    func hidenTabar(){
    UIView.animateWithDuration(0.25) { 
        self.myTabbar.frame = CGRect(x: 0, y:  UIScreen.mainScreen().bounds.size.height, width: UIScreen.mainScreen().bounds.size.width, height: self.tabBar.bounds.size.height)
        }
    }
    /**
     展示tabbar
     **/
    func showTabbar(){
    UIView.animateWithDuration(0.25) { 
         self.myTabbar.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height - self.tabBar.bounds.size.height, width: UIScreen.mainScreen().bounds.size.width, height: self.tabBar.bounds.size.height)   
        }
    }
    private  let myTabbar = GMYTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    private func initUI(){
    //1.移除系统自带的tabbar
    self.tabBar.removeFromSuperview()
    //2.设置自定义tabbar的frame
    self.myTabbar.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height - self.tabBar.bounds.size.height, width: UIScreen.mainScreen().bounds.size.width, height: self.tabBar.bounds.size.height)
    //3.设置代理
    self.myTabbar.delegate = self
    self.tabBarController?.tabBar.delegate = self
    //4.添加到view上
    self.view.addSubview(self.myTabbar)
    //5.添加button
    self.myTabbar.addButtonWithImage(UIImage(named: "tab_icon_news_normal")!, selectedImg: UIImage(named: "tab_icon_news_press")!)
    self.myTabbar.addButtonWithImage(UIImage(named: "tab_icon_friend_normal")!, selectedImg: UIImage(named: "tab_icon_friend_press")!)
    self.myTabbar.addButtonWithImage(UIImage(named: "tab_icon_quiz_normal")!, selectedImg: UIImage(named: "tab_icon_quiz_press")!)
    self.myTabbar.addButtonWithImage(UIImage(named: "tab_icon_more_normal")!, selectedImg: UIImage(named: "tab_icon_more_press")!)
    //6.添加响应的viewcontroller
    let  news     = NewsViewController()
    news.title    = "新闻"
    let  newsNav  = UINavigationController(rootViewController: news)
    
    let  hero     = HeroViewController()
    hero.title    = "英雄"
    let  heroNav  = UINavigationController(rootViewController: hero)
    
    let  info     = InfoViewController()
    info.title    = "资料"
    let  infoNav  = UINavigationController(rootViewController: info)
    
    let  set      = SettingViewController()
    set.title     = "设置"
    let  setNav   = UINavigationController(rootViewController: set)
    
    self.viewControllers = [newsNav,heroNav,infoNav,setNav]

    }
//========GMYTabbarDelegate
    func selectedGMYTabbar(tabbar: GMYTabbar, from: Int, to: Int) {
      self.selectedIndex = to
    }
}
