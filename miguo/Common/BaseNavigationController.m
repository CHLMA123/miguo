//
//  BaseNavigationController.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *attriDic = @{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:[UIColor blackColor]};
    [self.navigationBar setTitleTextAttributes:attriDic];
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        
        [self createBackBarItemWithViewController:viewController];
//        [self createrightBarItemWithViewController:viewController];
    }
    
    [self setTabBarState];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self setTabBarState];
    return vc;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *vcs = [super popToViewController:viewController animated:animated];
    [self setTabBarState];
    return vcs;
}

- (void)createBackBarItemWithViewController:(UIViewController *)viewController{
    
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(0, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backToParentView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

- (void)createrightBarItemWithViewController:(UIViewController *)viewController{
    
    UIButton *backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    backItem.frame = CGRectMake(SCREEN_WIDTH - 42, 6, 32.f, 32.f);
    [backItem setImage:[UIImage imageNamed:@"share_button"] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(backToParentView) forControlEvents:UIControlEventTouchUpInside];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    UIBarButtonItem *rBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backItem];
    viewController.navigationItem.rightBarButtonItem = rBarButtonItem;
    
}

- (void)backToParentView{
    
    if ([self presentationController] && self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (void)setTabBarState{
    
    [SharedAppDelegate.rootViewController setTabBarHidden:self.viewControllers.count > 1 animated:NO];
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
