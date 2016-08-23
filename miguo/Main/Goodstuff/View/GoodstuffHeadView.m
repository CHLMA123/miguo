//
//  GoodstuffHeadView.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GoodstuffHeadView.h"
#import "HaoHuoModel.h"
#import "UIButton+WebCache.h"

@interface GoodstuffHeadView ()

@property (nonatomic, strong) UIImageView *hhBigImageView;

@property (nonatomic, strong) UIImageView *hhSmallImageView;

@property (nonatomic, strong) UIView *lineView;

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
    _hhBigImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
//    _hhBigImageView.backgroundColor = RGB_LightBlue;
    
    _hhSmallImageView = [[UIImageView alloc] init];
    _hhSmallImageView.frame = CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_WIDTH * 46 / 490);
//    _hhSmallImageView.backgroundColor = RGB_LightRed;
    
    [self addSubview:_hhBigImageView];
    [self addSubview:_hhSmallImageView];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(0, CGRectGetMaxY(_hhSmallImageView.frame), SCREEN_WIDTH, 1);
    _lineView.backgroundColor = MIGUOBackgroundColor;
    [self addSubview:_lineView];
    // 2 ButtonView
    // 184 * 220
    CGFloat spaceX = 8;
    CGFloat _mButtonW = (SCREEN_WIDTH - spaceX * 6)/3;
    CGFloat _mButtonH = _mButtonW * 220/184;
    CGFloat spaceY = (self.height - _mButtonH - CGRectGetMaxY(_hhSmallImageView.frame))/2;
    
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
    
//    _hhButton1.backgroundColor = RGB_Random;
//    _hhButton2.backgroundColor = RGB_Random;
//    _hhButton3.backgroundColor = RGB_Random;
    
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
    
    market_camp *model = [[market_camp alloc] init];
    model = [market_camp mj_objectWithKeyValues:imageModelArray[0]];
    [_hhBigImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"repai"]];
    
    market_camp *model1 = [[market_camp alloc] init];
    model1 = [market_camp mj_objectWithKeyValues:imageModelArray[1]];
    [_hhSmallImageView sd_setImageWithURL:[NSURL URLWithString:model1.pic] placeholderImage:[UIImage imageNamed:@"repai"]];
    
    market_camp *btnModel1 = [[market_camp alloc] init];
    btnModel1 = [market_camp mj_objectWithKeyValues:imageModelArray[2]];
    NSString *imageUrl1 = btnModel1.pic;
    NSLog(@" sd_setBackgroundImageWithURL1 : %@", imageUrl1);
//    [_hhButton1 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl1] forState:UIControlStateNormal];
    [_hhButton1 sd_setImageWithURL:[NSURL URLWithString:imageUrl1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"repai"]];
    
    market_camp *btnModel2 = [[market_camp alloc] init];
    btnModel2 = [market_camp mj_objectWithKeyValues:imageModelArray[3]];
    NSString *imageUrl2 = btnModel2.pic;
    NSLog(@" sd_setBackgroundImageWithURL2 : %@", imageUrl2);
//    [_hhButton2 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl2] forState:UIControlStateNormal];
    [_hhButton2 sd_setImageWithURL:[NSURL URLWithString:imageUrl2] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"repai"]];
    
    market_camp *btnModel3 = [[market_camp alloc] init];
    btnModel3 = [market_camp mj_objectWithKeyValues:imageModelArray[4]];
    NSString *imageUrl3 = btnModel3.pic;
    NSLog(@" sd_setBackgroundImageWithURL3 : %@", imageUrl3);
//    [_hhButton3 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl3] forState:UIControlStateNormal];
     [_hhButton3 sd_setImageWithURL:[NSURL URLWithString:imageUrl3] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"repai"]];

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
