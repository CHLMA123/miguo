//
//  MyTableViewCell.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MyTableViewCell.h"

@interface MyTableViewCell ()

@property (nonatomic, strong) UIImageView *cellImageV;

@property (nonatomic, strong) UIView *maskBGView;

@property (nonatomic, strong) UILabel *cellNameLbl;

@property (nonatomic, strong) UILabel *cellDateLbl;

@end

@implementation MyTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *maincellID = @"MyTable";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:maincellID];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:maincellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self commitInitView];
    }
    return self;
}

- (void)commitInitView{
    _cellImageV = [[UIImageView alloc] init];
    [self addSubview:_cellImageV];
    
    _maskBGView = [[UIView alloc] init];
    [self addSubview:_maskBGView];
    
    _cellNameLbl = [[UILabel alloc] init];
    _cellNameLbl.textAlignment = NSTextAlignmentCenter;
    _cellDateLbl.textColor = RGB_Black;
    _cellDateLbl.font = SysFontOfSize_15;
    [_maskBGView addSubview:_cellNameLbl];
    
    _cellDateLbl = [[UILabel alloc] init];
    _cellDateLbl.textAlignment = NSTextAlignmentCenter;
    _cellDateLbl.textColor = [UIColor lightGrayColor];
    _cellDateLbl.font = SysFontOfSize_13;
    [_maskBGView addSubview:_cellDateLbl];
    
    _cellImageV.backgroundColor = RGB_LightOrange;
    _maskBGView.backgroundColor = RGB_LightBlue;
    _cellNameLbl.backgroundColor = RGB_LightRed;
    _cellDateLbl.backgroundColor = RGB_Lightgreen;
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    _cellImageV.frame = CGRectMake(0, 0, self.width, self.height);
    CGFloat BGViewWidth = self.width *0.5 - 20;
    _maskBGView.frame = CGRectMake(self.width * 0.5 - 20 , self.height - 108, BGViewWidth, 88);
    _cellNameLbl.frame = CGRectMake(0, 0, BGViewWidth, 44);
    _cellDateLbl.frame = CGRectMake(0, CGRectGetMaxY(_cellNameLbl.frame)+ 5 , BGViewWidth, 39);
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
