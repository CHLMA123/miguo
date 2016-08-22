//
//  MyCollectionViewCell.h
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityCollectionModel.h"

@interface MyCollectionViewCell : UICollectionViewCell

- (void)fillCellWithModel:(list *)datamodel;

@end
