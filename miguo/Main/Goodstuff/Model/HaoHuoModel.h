//
//  HaoHuoModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface market_camp :NSObject
@property (nonatomic , copy) NSString              * pic_pc;
@property (nonatomic , copy) NSString              * is_web;
@property (nonatomic , strong) NSNumber              * time;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * pic_768;
@property (nonatomic , copy) NSString              * text;
@property (nonatomic , copy) NSString              * pic_375;
@property (nonatomic , copy) NSString              * pic_414;
@property (nonatomic , copy) NSString              * pic_320;
@property (nonatomic , copy) NSString              * url;

@end

@interface HaoHuolist :NSObject
@property (nonatomic , copy) NSString              * tag_bt0;
@property (nonatomic , strong) NSNumber              * origin_price;
@property (nonatomic , copy) NSString              * item_url;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * tag_bt1;
@property (nonatomic , strong) NSNumber              * num_iid;
@property (nonatomic , copy) NSString              * rp_type;
@property (nonatomic , copy) NSString              * start_discount;
@property (nonatomic , strong) NSNumber              * limitCount;
@property (nonatomic , strong) NSNumber              * is_onsale;
@property (nonatomic , strong) NSNumber              * discount;
@property (nonatomic , copy) NSString              * item_urls;
@property (nonatomic , copy) NSString              * lefttop_pic;
@property (nonatomic , copy) NSString              * tezhengjurl;
@property (nonatomic , copy) NSString              * tezheng;
@property (nonatomic , strong) NSNumber              * now_price;
@property (nonatomic , strong) NSNumber              * is_vip_price;
@property (nonatomic , copy) NSString              * is_view_show;
@property (nonatomic , copy) NSString              * cache_time;
@property (nonatomic , copy) NSString              * tagimage;
@property (nonatomic , strong) NSNumber              * rp_quantity;
@property (nonatomic , copy) NSString              * show_time;
@property (nonatomic , copy) NSString              * des;
@property (nonatomic , strong) NSNumber              * total_love_number;
@property (nonatomic , strong) NSNumber              * deal_num;
@property (nonatomic , copy) NSString              * rp_sold;
@property (nonatomic , copy) NSString              * pic_url;
@property (nonatomic , copy) NSString              * tag_bt0url;
@property (nonatomic , copy) NSString              * tag_bt1url;

@end

@interface HaoHuoModel :NSObject
@property (nonatomic , strong) NSNumber              * is_end;
@property (nonatomic , strong) NSNumber              * next_page;
@property (nonatomic , copy) NSString              * hot_words;
@property (nonatomic , strong) NSNumber              * repai_lb;
@property (nonatomic , copy) NSString              * images_url;
@property (nonatomic , strong) NSArray              * market_camp;
@property (nonatomic , strong) NSArray              * HaoHuolist;
@property (nonatomic , strong) NSNumber              * total;
@property (nonatomic , strong) NSNumber              * current_count;
@property (nonatomic , strong) NSNumber              * next_limit;

@end

