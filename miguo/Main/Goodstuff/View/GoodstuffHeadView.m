//
//  GoodstuffHeadView.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GoodstuffHeadView.h"

@interface GoodstuffHeadView ()

@property (nonatomic, strong) UIImageView *hhBigImageView;

@property (nonatomic, strong) UIImageView *hhSmallImageView;

@property (nonatomic, strong) UIButton *hhButton1;

@property (nonatomic, strong) UIButton *hhButton2;

@property (nonatomic, strong) UIButton *hhButton3;

@end

@implementation GoodstuffHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB_White;
        [self commitInitViews];
    }
    return self;
}

#pragma mark - UI
- (void)commitInitViews{
    

    _hhBigImageView = [[UIImageView alloc] init];
    _hhBigImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    _hhBigImageView.backgroundColor = RGB_LightBlue;
    
    _hhSmallImageView = [[UIImageView alloc] init];
    _hhSmallImageView.frame = CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH * 46 / 490);
    _hhSmallImageView.backgroundColor = RGB_LightRed;
    
    [self addSubview:_hhBigImageView];
    [self addSubview:_hhSmallImageView];
    
    // 2 ButtonView
    // 184 * 220
    CGFloat spaceX = 8;
    CGFloat _mButtonW = (SCREEN_WIDTH - spaceX * 6)/3;
    CGFloat _mButtonH = _mButtonW * 220/184;
    CGFloat spaceY = (self.height - _mButtonH - 100)/2;
    
    _hhButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _hhButton1.frame = CGRectMake(spaceX, CGRectGetMaxY(_hhSmallImageView.frame) + spaceY, _mButtonW, _mButtonH);
    _hhButton1.tag = 1009;
    [_hhButton1 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _hhButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _hhButton2.frame = CGRectMake(CGRectGetMaxX(_hhButton1.frame) + 2 * spaceX, CGRectGetMaxY(_hhSmallImageView.frame) + spaceY, _mButtonW, _mButtonH);
    _hhButton2.tag = 1010;
    [_hhButton2 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _hhButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _hhButton3.frame = CGRectMake(CGRectGetMaxX(_hhButton2.frame) + 2 * spaceX, CGRectGetMaxY(_hhSmallImageView.frame) + spaceY, _mButtonW, _mButtonH);
    _hhButton3.tag = 1011;
    [_hhButton3 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _hhButton1.backgroundColor = RGB_Random;
    _hhButton2.backgroundColor = RGB_Random;
    _hhButton3.backgroundColor = RGB_Random;
    
    [self addSubview:_hhButton1];
    [self addSubview:_hhButton2];
    [self addSubview:_hhButton3];
    
}

- (void)mButtonViewPush:(UIButton *)sender{
    if (sender.tag == 1009) {
        NSLog(@"button1");
        
    }else if (sender.tag == 1010) {
        NSLog(@"button2");
        
    }else if (sender.tag == 1011) {
        NSLog(@"button3");
        
    }
}

- (void)fillHeaderViewWithArray:(NSArray *)imageModelArray{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
