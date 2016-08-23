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

@interface MyCollectionViewCell : UICollectionViewCell

- (void)fillCellWithModel:(collectlist *)datamodel;

- (void)fillCellWithHaoHuoModel:(HaoHuolist *)datamodel;

@end
