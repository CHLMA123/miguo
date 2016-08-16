//
//  BaseTabBarController.h
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

@property (nonatomic, getter=isTabBarHidden,readonly)BOOL tabBarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
