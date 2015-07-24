//
//  Interface.h
//  OuLianWang
//
//  Created by allenariel on 15/6/25.
//  Copyright (c) 2015年 皇室美家. All rights reserved.
//

#ifndef OuLianWang_Interface_h
#define OuLianWang_Interface_h


//*********************************************************************************//首页接口
#pragma mark - 首页接口


#define HomePro_URL @"http://weixin.hsmja.com/wolian/homenav.php?action=app_open_default&openMode=city_change&longitude=%@&latitude=%@&provid=%d&goodstab=%d&page=%d"
//lon,lan,provid,goodstab, goodtab =0, 1,2,3

#define HomeCity_URL @"http://weixin.hsmja.com/wolian/homenav.php?action=app_open_default&openMode=city_change&longitude=%@&latitude=%@&cityid=%d&goodstab=%d&page=%d&pageSize="

#define HomeArea_URL @"http://weixin.hsmja.com/wolian/myweb/homenav.php?action=app_open_default&openMode=city_change&longitude=%@&latitude=%@&areaid=%d&goodstab=%d&page=%d&pageSize="


//  首页全部分类接口

#define  FenLeiUrl  @"http://weixin.hsmja.com/wolian/homenav.php?action=app_open_default&openMode=city_change&provid=1&goodstab=0&handle=dropdown"

//商品详情
#define   ShopDetail_URL @"http://www.hsmja.com/myweb/homenav.php?action=goods_detail&gid=34"

//充值
#define   ChongZhi_URL   @"http://weixin.hsmja.com/wolian/personcenter.php?action=phonerecharge"

//巨划算
#define   JUHuaSUrl      @"http://weixin.hsmja.com/wolian/homenav.php?action=cost&longitude=100&latitude=10&provid=1&handle=default"


//*********************************************************************************//同城接口
#pragma mark - 同城接口


//家具部分
#define TC_JIAJU @"http://www.hsmja.com/wolian/oneCity.php?action=onCity_list&provid=%d&cat=%d"
//http://weixin.hsmja.com/wolian/oneCity.php?action=onCity_list&cat_big=1&cat=5&longitude=113&latitude=23&provid=&cityid=&areaid=&page=&pageSize=
#define CITY @"&cityid=%d"

#define AREA @"&areaid=%d"

#define TC_JiaJu_URL @"http://weixin.hsmja.com/wolian/oneCity.php?action=onCity_list&cat_big=%d&cat=%d&longitude=%@&latitude=%@&provid=%@&cityid=%@&areaid=%@&page=%d&pageSize="
//big-cat%d  cat%d  lon lat proid citid areaid  page%d

//家居店铺详情
#define TC_JiaJuStore_URL @"http://weixin.hsmja.com/wolian/oneCity.php?action=onCity_store&storeid=%@&userid=&gcryid=&s_catgryid=&pageSize=&page=&where="

//家具预定
#define TC_JiaJuYuDing_URL @"http://192.168.1.147/myweb/oneCity.php?action=onCity_store&goodsid=%@&userid=%@&storeid=%@&key=%@"

//类别
#define LEIBIE_URL @"http://weixin.hsmja.com/wolian/homenav.php?action=kinds&handle=default&longitude=100.294518&latitude=10.294518&provid=&cityid=&areaid=%20v"

//*********************************************************************************//其他接口
#pragma mark - 其他接口

//检查更新接口
#define UPDATA_URL @"http://www.hsmja.com/wolian/personcenter.php?action=checkupdate&type=2"

//获取定位回馈
#define LOCATION_URL @"http://weixin.hsmja.com/wolian/oneCity.php?action=fuzzy_query&city=%@"

//中国全部城市接口
#define ALLCITY_URL @"http://www.hsmja.com/wolian/china.php?action=china_ios"


//*********************************************************************************//我的接口
#pragma mark - 我的接口

//
#define PERSONCENTER_URL @"http://weixin.hsmja.com/wolian/personcenter.php?"
#define PhotoAlbum_URL @"http://weixin.hsmja.com/wolian/personcenter.php?"
//action=personphoto&userid=1&key=147cbf4362fa62bafd101996e276b4b5
//*********************************************************************************//热卖接口

#pragma mark--热卖接口

//   热卖商品详情接口
#define HouDetail  @"http://weixin.hsmja.com/wolian/homenav.php?action=goods_detail&gid=34"

//   热卖首页第二栏分类接口
#define HotFLUrl   @"http://weixin.hsmja.com/wolian/hotsale.php?action=navigation"

//   热卖首页第一栏循环图片接口
#define HotSPUrl   @"http://weixin.hsmja.com/wolian/hotsale.php?action=goodsimg&storeid=80&key=5c4aef0381b19efe26e75191b263b33f"

//   热卖首页第三栏的商品接口
#define HotShpiurl  @"http://weixin.hsmja.com/wolian/hotsale.php?action=page&page=%d&pageSize=%d&provid=%d&cityid=%d&areaid=%d"

//  分类二级接口
#define FenerLeiUrl   @""

//  分类一级接口
#define FenLdeiErUrl  @"http://weixin.hsmja.com/wolian/homenav.php?action=app_open_default&openMode=city_change&provid=1&goodstab=0&handle=dropdown"




#endif

