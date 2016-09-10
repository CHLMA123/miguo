//
//  MyTableViewCell.h
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "specialModel.h"

@interface MTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *cellImageV;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)fillCellContentWithModel:(tableData *)model;

@end
