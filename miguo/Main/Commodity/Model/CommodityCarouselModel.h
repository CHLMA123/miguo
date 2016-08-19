//
//  CommodityCarouselModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface data :NSObject
@property (nonatomic , copy) NSString              * iphoneimg;
@property (nonatomic , copy) NSString              * iphonezimg;
@property (nonatomic , copy) NSString              * ipadzimg;
@property (nonatomic , copy) NSString              * ipadimg;
@property (nonatomic , copy) NSString              * link;
@property (nonatomic , copy) NSString              * iphoneimgnew;
@property (nonatomic , copy) NSString              * iphonehomebig;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * rgb;
@property (nonatomic , copy) NSString              * target;
@property (nonatomic , copy) NSString              * iphonemimg;
@property (nonatomic , copy) NSString              * linktype;

@end

@interface CommodityCarouselModel :NSObject
@property (nonatomic , strong) NSArray              * data;

@end
/*
 {
 "ipadimg": "http://image.repaiapp.com/spzt/images/list/ipad_1471421732/",
 "iphoneimg": "http://image.repaiapp.com/spzt/images/list/iphone_1471421732/",
 "iphonezimg": "http://image.repaiapp.com/spzt/images/list/iphonez_1471421732/",
 "ipadzimg": "http://image.repaiapp.com/spzt/images/list/ipadz_1471421732/",
 "iphonemimg": "http://image.repaiapp.com/spzt/images/list/iphonem_1471421732/",
 "iphoneimgnew": "http://image.repaiapp.com/spzt/images/list/iphoneimgnew_1471421732/",
 "iphonehomebig": "http://image.repaiapp.com/spzt/images/list/iphonehomebig_1471421732/",
 "title": "818全民发烧节",
 "rgb": "#f4f4f4",
 "target": "push",
 "linktype": "num_iid",
 "link": "http://app.api.repai.com/wotaotao/web/new_spzt.php?topic_id=9&amp;spzt_id=947&amp;app_id=594792631&amp;app_oid=2ad000dbe962fff914983edbf273b427&amp;app_version=1.1.1&amp;app_channel=iphoneappstore&amp;sche=repai&amp;target=push&amp;"
 }
 */
