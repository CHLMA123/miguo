//
//  BaseTabBarController.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "CommodityViewController.h"
#import "ClassifyViewController.h"
#import "GoodstuffViewController.h"
#import "SpecialViewController.h"
#import "MineViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllers{
    
    [self addChildViewController:[[CommodityViewController alloc] init] TitleName:@"首页" tabBarTitleName:@"商品" tabBarImageName:@"index_btn"];
    [self addChildViewController:[[ClassifyViewController alloc] init] TitleName:@"Classify" tabBarTitleName:@"分类" tabBarImageName:@"btn_class"];
    [self addChildViewController:[[GoodstuffViewController alloc] init] TitleName:@"最新上架" tabBarTitleName:@"好货" tabBarImageName:@"btn_nice"];
    [self addChildViewController:[[SpecialViewController alloc] init] TitleName:@"最新上架" tabBarTitleName:@"专题" tabBarImageName:@"search_btn"];
    [self addChildViewController:[[MineViewController alloc] init] TitleName:@"Mine" tabBarTitleName:@"我的" tabBarImageName:@"mine_btn"];
    
}

-(void)addChildViewController:(UIViewController *)vc
                    TitleName:(NSString *)titleName
              tabBarTitleName:(NSString *)tabBarTitleName
              tabBarImageName:(NSString *)tabBarImageName
{
    vc.title = titleName;
    
    vc.tabBarItem.title = @"";
    // 修改标题位置
    //self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
    
    NSString *imgStr = [NSString stringWithFormat:@"%@_normal_64x49_", tabBarImageName];
    NSString *imgHLStr = [NSString stringWithFormat:@"%@_active_64x49_", tabBarImageName];
    UIImage *img = GetImageByName(imgStr);
    UIImage *selimg = GetImageByName(imgHLStr);
    vc.tabBarItem.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (BOOL)isTabBarHidden{
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    return tabBarFrame.origin.y >= viewFrame.size.height;
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    BOOL isHidden = self.tabBarHidden;
    if (hidden == isHidden) {
        return;
    }
    
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        NSLog(@"could not get the container view!");
        return;
    }
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.35];
    }
    self.tabBar.frame = tabBarFrame;
    transitionView.frame = containerFrame;
    if (animated) {
        [UIView commitAnimations];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
