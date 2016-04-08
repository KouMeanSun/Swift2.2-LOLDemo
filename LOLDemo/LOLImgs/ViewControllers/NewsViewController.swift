//
//  NewsViewController.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/5.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit
import AudioToolbox

class NewsViewController: UIViewController ,UIScrollViewDelegate{
    
   let kScreenWidth  = UIScreen.mainScreen().bounds.size.width
   let kScreenHeight = UIScreen.mainScreen().bounds.size.height
//分栏标题scrollview
    private let smallScrollView:UIScrollView = UIScrollView()
//下面的大scrollview
    private let bigScrollView:UIScrollView   = UIScrollView()
    
//分栏标题
    private let titleNames = ["最新","活动","赛事","视频","娱乐","官方","美女","攻略"]
    
//子视图
    private var viewControllers:Array<UIViewController>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
       
        self.initUI()
        self.playNoticeMp3()
    }

    
 private   func initUI(){
      self.navigationController?.navigationBarHidden = true
      self.smallScrollView.frame = CGRect(x: 0, y: 20, width: kScreenWidth, height: 50)
      self.automaticallyAdjustsScrollViewInsets = false
      self.smallScrollView.showsVerticalScrollIndicator = false
      self.smallScrollView.showsHorizontalScrollIndicator = false
    
      self.addTitleLbl()
      self.view.addSubview(self.smallScrollView)
    //==添加子view
    self.bigScrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(self.smallScrollView.frame), width: kScreenWidth, height: kScreenHeight-CGRectGetMaxY(self.smallScrollView.frame))
    print("bigContentFrame:\(NSStringFromCGRect(self.bigScrollView.frame))")
    
    let contentX:CGFloat = CGFloat(8)*kScreenWidth
    self.bigScrollView.contentSize = CGSize(width: contentX, height: 0)
    print("bigContentSize:\(NSStringFromCGSize(self.bigScrollView.contentSize))")
    self.bigScrollView.pagingEnabled = true
    self.bigScrollView.scrollEnabled = true
    self.bigScrollView.delegate = self
  
    self.view.addSubview(self.bigScrollView)
    
    
    let label:MYTitleLabel = self.smallScrollView.subviews.first as! MYTitleLabel
    label.setScale(1.0)
    self.bigScrollView.showsHorizontalScrollIndicator = false
    //==添加导航控制器
    let vc1 = LastestViewController()
    vc1.title = "最新"
    
    let vc2 = ActivityViewController()
    vc2.title = "活动"
    
    let vc3 = GameViewController()
    vc3.title = "赛事"
    
    let vc4 = VideoViewController()
    vc4.title  = "视频"
    
    let vc5 = FunViewController()
    vc5.title = "娱乐"
    
    let vc6 = OfficialViewController()
    vc6.title = "官方"
    
    let vc7 = BeautyViewController()
    vc7.title = "美女"
    
    let vc8 = RaidersViewController()
    vc8.title = "攻略"
    
    //==添加子视图控制器和view,只添加第一个，当滑动，或者点击到其他vc再加载
    self.viewControllers = [vc1,vc2,vc3,vc4,vc5,vc6,vc7,vc8]
    self.addChildViewController(vc1)
    vc1.view.frame = CGRect(x: 0, y: 0, width: self.bigScrollView.bounds.size.width, height: self.bigScrollView.bounds.size.height)
    self.bigScrollView.addSubview(vc1.view)

    
    }
    /**
     播放提示音
     **/
    private func playNoticeMp3(){
        let path:String! = NSBundle.mainBundle().pathForResource("garen", ofType: "mp3")
        if  path != nil {
          let url = NSURL(fileURLWithPath: path)
           var id:SystemSoundID = 0
           AudioServicesCreateSystemSoundID(url, &id)
           AudioServicesPlayAlertSound(id)
        }
    }
    /**
    添加标题栏
     **/
 private   func addTitleLbl(){
    for i in 0..<8 {
        let lblWidth = CGFloat(70)
        let lblHeight = CGFloat(40)
        let lblY  = CGFloat(0)
        let lblX = CGFloat(i)*lblWidth
        
        let myTitleLbl = MYTitleLabel()
        myTitleLbl.text =  self.titleNames[i]
        myTitleLbl.setScale(0.5)
        myTitleLbl.frame = CGRect(x: lblX, y: lblY, width: lblWidth, height: lblHeight)
        self.smallScrollView.addSubview(myTitleLbl)
        myTitleLbl.tag = i
        myTitleLbl.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.lblClick(_:)))
        myTitleLbl.addGestureRecognizer(tap)
    }
    self.smallScrollView.contentSize = CGSize(width: 70*8, height: 0)
    }
    
    @objc private func lblClick(tap:UITapGestureRecognizer){
    let lbl = tap.view as! MYTitleLabel
    lbl.setScale(1.0)

    let offsetX = CGFloat(lbl.tag)*self.bigScrollView.frame.size.width
    let offsetY = self.bigScrollView.contentOffset.y
    let offset  = CGPoint(x: offsetX, y: offsetY)
    self.bigScrollView.setContentOffset(offset, animated: false)
        for i in 0..<self.smallScrollView.subviews.count {
            if i != Int(lbl.tag) {
              let title:MYTitleLabel = self.smallScrollView.subviews[i] as! MYTitleLabel
                title.setScale(0.5)
            }
        }
        let index = lbl.tag
        let vc = self.viewControllers[index]
        if vc.view.superview != nil {
            return
        }
        self.addChildViewController(vc)
        vc.view.frame  = CGRect(x: CGFloat(index)*self.bigScrollView.bounds.size.width, y: 0, width: self.bigScrollView.bounds.size.width, height: self.bigScrollView.bounds.size.height)
        self.bigScrollView.addSubview(vc.view)
    }
    
    // - ******************** scrollView代理方法
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //print("scrollViewDidEndDecelerating")
        let offX = scrollView.contentOffset.x
        let width = self.bigScrollView.frame.size.width
        let index = offX/width
        //滚动标题栏
        let label:MYTitleLabel = self.smallScrollView.subviews[Int(index)] as! MYTitleLabel
        label.setScale(1.0)
        var offsetX = label.center.x - self.smallScrollView.contentSize.width*0.5
        let offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.width
        if offsetX < 0 {
            offsetX = 0
        }else if offsetX > offsetMax {
            offsetX = offsetMax
        }
        let offset = CGPoint(x: offsetX, y: self.smallScrollView.contentOffset.y)
        self.smallScrollView.setContentOffset(offset, animated: false)
        
        //添加控制器
        // let vc = self.childViewControllers[Int(index)]
        for i in 0..<self.smallScrollView.subviews.count {
            if i != Int(index) {
                let title:MYTitleLabel = self.smallScrollView.subviews[i] as! MYTitleLabel
                title.setScale(0.5)
            }
        }
      //=======
      let vc = self.viewControllers[Int(index)]
        if vc.view.superview != nil {
        return
        }
      self.addChildViewController(vc)
      vc.view.frame  = CGRect(x: index*self.bigScrollView.bounds.size.width, y: 0, width: self.bigScrollView.bounds.size.width, height: self.bigScrollView.bounds.size.height)
      self.bigScrollView.addSubview(vc.view)
    }
}
