//
//  OtherHaoHuoModel.h
//  miguo
//
//  Created by MCL on 16/9/10.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface level3 :NSObject
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * cid;

@end

@interface category_two :NSObject
@property (nonatomic , strong) NSArray              * level3;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * cid;

@end

@interface brand :NSObject
@property (nonatomic , copy) NSString              * id;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * item_cate;
@property (nonatomic , copy) NSString              * url;

@end

@interface OtherHaoHuolist :NSObject
@property (nonatomic , copy) NSString              * tag_bt0;
@property (nonatomic , strong) NSNumber              * origin_price;
@property (nonatomic , copy) NSString              * item_url;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * tag_bt1;
@property (nonatomic , copy) NSString              * num_iid;
@property (nonatomic , copy) NSString              * rp_type;
@property (nonatomic , copy) NSString              * start_discount;
@property (nonatomic , strong) NSNumber              * is_onsale;
@property (nonatomic , copy) NSString              * item_urls;
@property (nonatomic , strong) NSNumber              * discount;
@property (nonatomic , copy) NSString              * lefttop_pic;
@property (nonatomic , strong) NSNumber              * now_price;
@property (nonatomic , strong) NSNumber              * is_vip_price;
@property (nonatomic , copy) NSString              * tagimage;
@property (nonatomic , strong) NSNumber              * rp_quantity;
@property (nonatomic , copy) NSString              * show_time;
@property (nonatomic , strong) NSNumber              * total_love_number;
@property (nonatomic , strong) NSNumber              * deal_num;
@property (nonatomic , strong) NSNumber              * rp_sold;
@property (nonatomic , copy) NSString              * pic_url;
@property (nonatomic , copy) NSString              * tag_bt0url;
@property (nonatomic , copy) NSString              * tag_bt1url;

@end

@interface OtherHaoHuoModel :NSObject
@property (nonatomic , strong) NSNumber              * current_count;
@property (nonatomic , copy) NSString              * category_c;
@property (nonatomic , strong) NSArray              * category_two;
@property (nonatomic , strong) NSNumber              * next_page;
@property (nonatomic , strong) NSArray              * brand;
@property (nonatomic , strong) NSNumber              * total;
@property (nonatomic , copy) NSString              * category_b;
@property (nonatomic , copy) NSString              * category_thr;
@property (nonatomic , strong) NSArray              * OtherHaoHuolist;
@property (nonatomic , strong) NSNumber              * is_end;
@property (nonatomic , strong) NSNumber              * next_limit;
@property (nonatomic , copy) NSString              * category_t;

@end
