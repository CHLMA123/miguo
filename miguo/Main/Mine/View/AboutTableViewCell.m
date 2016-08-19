//
//  AboutTableViewCell.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "AboutTableViewCell.h"

@implementation AboutTableViewCell

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    for (UIView *subview in self.contentView.superview.subviews) {
//        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
//            subview.hidden = NO;
//        }
//    }
//}

/*
 如下
 
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
