//
//  CommodityViewController.m
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityViewController.h"
#import "CommodityHeadView.h"

@interface CommodityViewController ()

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    
    self.resuableViewClassName = @"CommodityHeadView";
    
    NSString *mScrollViewUrl = @"http://cloud.repaiapp.com/yunying/spzt.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";
        
    NSString *mMainCollectionUrl = @"http://zhekou.repai.com/shop/discount/api/listnew1.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&page=1";
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setUpTitleView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTitleView{
    
    // Title
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(listMore:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    //search
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    
    // List
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setImage:[UIImage imageNamed:@"menu_2"] forState:UIControlStateNormal];
    [listButton setImage:[UIImage imageNamed:@"menu_1"] forState:UIControlStateSelected];
    [listButton addTarget:self action:@selector(listMore:) forControlEvents:UIControlEventTouchUpInside];
    [listButton sizeToFit];
    
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    UIBarButtonItem *listItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
    UIBarButtonItem *flexibaleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.navigationItem setRightBarButtonItems:@[searchItem, flexibaleItem, listItem]];
    
    //message
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageButton setImage:[UIImage imageNamed:@"xiaoxi_btn1_20x20_"] forState:UIControlStateNormal];
    [messageButton addTarget:self action:@selector(showMessageView:) forControlEvents:UIControlEventTouchUpInside];
    [messageButton sizeToFit];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    [self.navigationItem setLeftBarButtonItem:messageItem];
}

- (void)listMore:(UIButton *)sender{
    sender.selected = !sender.selected;
    
}

- (void)showSearchView:(UIButton *)sender{
    
}

- (void)showMessageView:(UIButton *)sender{
    
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
