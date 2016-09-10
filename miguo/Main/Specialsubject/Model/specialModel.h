//
//  specialModel.h
//  miguo
//
//  Created by MCL on 16/9/10.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tableData :NSObject
@property (nonatomic , copy) NSString              * coverForPadUrl;
@property (nonatomic , copy) NSString              * bannerUrl;
@property (nonatomic , copy) NSString              * manUrl;
@property (nonatomic , strong) NSNumber              * textBg;
@property (nonatomic , strong) NSNumber              * topicContentId;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * backCover;
@property (nonatomic , copy) NSString              * updateTime;
@property (nonatomic , copy) NSString              * bannerUrlForPad;
@property (nonatomic , copy) NSString              * introForPad;

@end

@interface specialModel :NSObject
@property (nonatomic , strong) NSNumber              * status;
@property (nonatomic , strong) NSArray              * tableData;
@property (nonatomic , copy) NSString              * ltime;
@property (nonatomic , copy) NSString              * msg;

@end
