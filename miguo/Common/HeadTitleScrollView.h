//
//  SmallScroll.h
//  新闻资讯Demo
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadTitleScrollView : UIScrollView<UIScrollViewDelegate>

- (instancetype)initWithSmallScroll:(NSArray *)titleArray;

@property (nonatomic) NSInteger index;

@property (nonatomic, strong) void (^changeIndexValue)(NSInteger);

@end
