//
//  TitleMenuView.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "TitleMenuView.h"

typedef NS_ENUM(NSInteger, UIButtonTypeIndex)
{
    UIButtonTypeWomenIndex = 0,
    UIButtonTypeMensIndex,
    UIButtonTypeWenYuIndex,
    UIButtonTypeXieBaoIndex,
    UIButtonTypePeiShiIndex,
    UIButtonTypeJiaJuIndex,
    UIButtonTypeMeiShiIndex,
    UIButtonTypeMuYingIndex,
    UIButtonTypeMeiZhuangIndex,
    UIButtonTypeShuMaIndex
};

@interface TitleMenuView ()

@end

@implementation TitleMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commitInitView];
    }
    return self;
}

- (void)commitInitView{
//    NSArray *imgArr =
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
