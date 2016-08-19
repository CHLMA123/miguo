//
//  CommodityCollectionModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface category_s :NSObject
@property (nonatomic , copy) NSString              * is_web;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * pingtai_type;
@property (nonatomic , copy) NSString              * text;

@end

@interface list :NSObject
@property (nonatomic , copy) NSString              * discount;
@property (nonatomic , copy) NSString              * xpic;
@property (nonatomic , copy) NSString              * des;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * num_iid;
@property (nonatomic , copy) NSString              * pic_url;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * pingtai_type;
@property (nonatomic , copy) NSString              * origin_price;
@property (nonatomic , copy) NSString              * end_time;
@property (nonatomic , copy) NSString              * now_price;
@property (nonatomic , copy) NSString              * begin_time;

@end

@interface schename :NSObject

@end

@interface CommodityCollectionModel :NSObject
@property (nonatomic , strong) NSArray              * category_s;
@property (nonatomic , strong) NSArray              * list;
@property (nonatomic , copy) NSString              * js;
@property (nonatomic , strong) NSArray              * schename;

@end
