//
//  MyCollectionViewCell.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()

@property (nonatomic, strong) UIImageView *goodsImageV;

@property (nonatomic, strong) UILabel *descriptionLbl;

@property (nonatomic, strong) UILabel *nowPriceLbl;

@property (nonatomic, strong) UILabel *oldPriceLbl;

@end

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
        [self commitInitView];
    }
    return self;
}

- (void)commitInitView{
    _goodsImageV = [[UIImageView alloc] init];
    [self addSubview:_goodsImageV];
    
    _descriptionLbl = [[UILabel alloc] init];
    _descriptionLbl.textAlignment = NSTextAlignmentCenter;
    _descriptionLbl.font = SysFontOfSize_15;
    _descriptionLbl.textColor = RGB_Black;
    [self addSubview:_descriptionLbl];
    
    _nowPriceLbl = [[UILabel alloc] init];
    _nowPriceLbl.textAlignment = NSTextAlignmentCenter;
    _nowPriceLbl.font = SysFontOfSize_15;
    _nowPriceLbl.textColor = [UIColor redColor];
    [self addSubview:_nowPriceLbl];
    
    _oldPriceLbl = [[UILabel alloc] init];
    _oldPriceLbl.textAlignment = NSTextAlignmentCenter;
    _oldPriceLbl.font = SysFontOfSize_15;
    _oldPriceLbl.textColor = RGB_Black;
    [self addSubview:_oldPriceLbl];
    
    
    _goodsImageV.backgroundColor    = RGB_LightBlue;
    _descriptionLbl.backgroundColor = RGB_LightRed;
    _nowPriceLbl.backgroundColor    = RGB_Lightgreen;
    _oldPriceLbl.backgroundColor    = RGB_LightOrange;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _goodsImageV.frame = CGRectMake(0, 0, self.width, self.width);
    CGFloat smallH = (self.height - self.width - 30)/2;
    
    _descriptionLbl.frame = CGRectMake(0, CGRectGetMaxY(_goodsImageV.frame) + 10, self.width, smallH);
    _nowPriceLbl.frame = CGRectMake((self.width - 50)/2, CGRectGetMaxY(_descriptionLbl.frame) + 10, 50, smallH);
    _oldPriceLbl.frame = CGRectMake(CGRectGetMaxX(_nowPriceLbl.frame) + 5, CGRectGetMaxY(_descriptionLbl.frame) + 10, 50, smallH);
}

@end
