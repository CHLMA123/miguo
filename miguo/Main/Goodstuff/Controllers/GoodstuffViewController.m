//
//  GoodstuffViewController.m
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "GoodstuffViewController.h"

@interface GoodstuffViewController ()

@end

@implementation GoodstuffViewController

- (void)viewDidLoad {
    
    self.titleArrar = @[@"最新上架",@"数码",@"女装",@"文娱",@"家居",@"母婴",@"鞋包",@"运动",@"美妆"];
    self.resuableViewClassName = @"GoodstuffHeadView";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
