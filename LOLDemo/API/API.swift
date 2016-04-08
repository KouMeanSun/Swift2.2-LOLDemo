//
//  API.swift
//  LOLDemo
//
//  Created by gaomingyang1987 on 16/4/6.
//  Copyright © 2016年 gaomingyang1987. All rights reserved.
//

import UIKit

class API: NSObject {
//服务器
    static  let HOST = "http://lol.data.shiwan.com"
 
//新闻
//最新
   static  let kLatestNewsUrlString = HOST + "/getArticleListImprove/?cid_rel=207&page=%d"
//活动
//#define kS4UrlString HOST@"/getArticleListImprove/?cid_rel=215&page=%d"
   static  let kS4UrlString         = HOST + "/getArticleListImprove/?cid_rel=215&page=%d"
//赛事
//    #define kMatchUrlStirng HOST@"/getArticleListImprove/?cid_rel=216&page=%d"
   static  let kMatchUrlStirng         = HOST + "/getArticleListImprove/?cid_rel=216&page=%d"
//视频
//    #define kLatestNewsUrlString HOST@"/getArticleListImprove/?cid_rel=207&page=%d"
//娱乐
//    #define kGreatUrlString HOST@"/getArticleListImprove/?cid_rel=212&page=%d"
   static  let kGreatUrlString         = HOST + "/getArticleListImprove/?cid_rel=212&page=%d"
//官方
//    #define kOfficialUrlString HOST@"/getArticleListImprove/?cid_rel=211&page=%d"
   static  let kOfficialUrlString         = HOST + "/getArticleListImprove/?cid_rel=211&page=%d"
//美女
   // #define kBeautifulGirlUrlString HOST@"/getArticleListImprove/?cid_rel=210&page=%d"
   static  let kBeautifulGirlUrlString    = HOST + "/getArticleListImprove/?cid_rel=210&page=%d"
//攻略
//    #define kStrategyUrlString HOST@"/getArticleListImprove/?cid_rel=214&page=%d"
   static  let kStrategyUrlString    = HOST + "/getArticleListImprove/?cid_rel=214&page=%d"
//==========
    
    //新闻详情
//    #define kNewsDetailUrlString HOST@"/getArticleInfo/loldata?article_id=%@"
   static  let kNewsDetailUrlString    = HOST + "/getArticleInfo/loldata?article_id=%@"
}
