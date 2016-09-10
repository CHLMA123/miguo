//
//  MyCollectionViewCell.h
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityCollectionModel.h"
#import "HaoHuoModel.h"
#import "OtherHaoHuoModel.h"

@interface MyCollectionViewCell : UICollectionViewCell

- (void)fillCellWithPlaceholderImage;

- (void)fillCellWithModel:(collectlist *)datamodel;

//Goodstuff 数据处理
- (void)fillCellWithHaoHuoModel:(HaoHuolist *)datamodel;//首页

- (void)fillCellWithOtherHaoHuoModel:(OtherHaoHuolist *)datamodel;//other

@end
