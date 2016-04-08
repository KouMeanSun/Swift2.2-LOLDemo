//
//

#ifndef _______DEFINE_h
#define _______DEFINE_h


//服务器
#define  HOST @"http://lol.data.shiwan.com"


//新闻
//最新
#define kLatestNewsUrlString HOST@"/getArticleListImprove/?cid_rel=207&page=%d"
//活动
#define kS4UrlString HOST@"/getArticleListImprove/?cid_rel=215&page=%d"
//赛事
#define kMatchUrlStirng HOST@"/getArticleListImprove/?cid_rel=216&page=%d"
//视频
#define kLatestNewsUrlString HOST@"/getArticleListImprove/?cid_rel=207&page=%d"
//娱乐
#define kGreatUrlString HOST@"/getArticleListImprove/?cid_rel=212&page=%d"
//官方
#define kOfficialUrlString HOST@"/getArticleListImprove/?cid_rel=211&page=%d"
//美女
#define kBeautifulGirlUrlString HOST@"/getArticleListImprove/?cid_rel=210&page=%d"
//攻略
#define kStrategyUrlString HOST@"/getArticleListImprove/?cid_rel=214&page=%d"


//新闻详情
#define kNewsDetailUrlString HOST@"/getArticleInfo/loldata?article_id=%@"


//装备物品
#define kEquipmentUrlString HOST@"/lolItemFilter/lolvideo?index=99"

//召唤师技能
#define kSkillUrlString HOST@"/lolSpell"
//召唤师详情  web   server  player
#define kPlayerUrlString @"http://lolbox.duowan.com/phone/playerDetail.php?sn=%@&target=%@&from=search&sk=398723%254019T"
//json 召唤师详情  player  server
#define kJasonPlayerUrlString @"http://115.29.206.154:8080/LOL_Query/service/ZDLQuery?playerName=%@&serverName=%@"

//全部英雄
#define kAllHeroUrlString HOST@"/lolHeros/?filter=&type=all"
//本周免费英雄
#define kFreeHeroUrlString HOST@"/lolHeros/?filter=&type=free"
#define kHeroDetailInfoUrlString HOST@"/lolHeroInfo/?id=%@"
//英雄出装
#define kHeroEquipmentUrlString @"http://db.duowan.com/lolcz/img/ku11/api/lolcz.php?championName=%@&limit=7"
//装备图片
#define kEquipmentImageUrlString @"http://img.lolbox.duowan.com/zb/%@_64x64.png"
//英雄技能
#define kSkillImageUrlString @"http://img.lolbox.duowan.com/abilities/%@_%@_64x64.png"



// 获取全局并发队列
#define HMGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// 获取主线程队列
#define HMMainQueue dispatch_get_main_queue()








#endif

