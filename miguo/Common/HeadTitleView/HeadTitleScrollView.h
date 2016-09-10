//
//  SmallScroll.h
//  新闻资讯Demo
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  页面头部的类新闻资讯ScrollView
 *
 *  @param titleArray 初始化标题数组
 *
 */
@interface HeadTitleScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic) NSInteger index;

@property (nonatomic, strong) void (^changeIndexValue)(NSInteger);

- (instancetype)initWithSmallScroll:(NSArray *)titleArray titleNorColor:(UIColor *)norColor titleSelColor:(UIColor *)selColor;

- (CGFloat)getStringWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont;

@end
