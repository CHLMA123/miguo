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
//        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
        self.backgroundColor = RGB_White;
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
    
    
//    _goodsImageV.backgroundColor    = RGB_LightBlue;
//    _descriptionLbl.backgroundColor = RGB_LightRed;
//    _nowPriceLbl.backgroundColor    = RGB_Lightgreen;
//    _oldPriceLbl.backgroundColor    = RGB_LightOrange;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _goodsImageV.frame = CGRectMake(0, 0, self.width, self.width);//800 * 800
//    _goodsImageV.alpha = 0.3;//检查View复用问题
    CGFloat smallH = (self.height - self.width)/2;
    
    _descriptionLbl.frame = CGRectMake(0, CGRectGetMaxY(_goodsImageV.frame), self.width, smallH);
    _nowPriceLbl.frame = CGRectMake((self.width - 45)/2, CGRectGetMaxY(_descriptionLbl.frame), 45, smallH);
    _oldPriceLbl.frame = CGRectMake(CGRectGetMaxX(_nowPriceLbl.frame), CGRectGetMaxY(_descriptionLbl.frame), 45, smallH);
}

- (void)fillCellWithModel:(list *)datamodel{
    
    [_goodsImageV sd_setImageWithURL:[NSURL URLWithString:datamodel.pic_url]];
    _descriptionLbl.text = datamodel.des;
    _nowPriceLbl.text = datamodel.now_price;
    NSMutableAttributedString *stringLbl = [[NSMutableAttributedString alloc] initWithString:datamodel.origin_price];
    NSInteger len = stringLbl.length;
    
    [stringLbl addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, len)];
    _oldPriceLbl.attributedText = stringLbl;
    
}

@end
