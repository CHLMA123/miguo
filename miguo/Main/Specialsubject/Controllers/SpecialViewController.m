//
//  SpecialViewController.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "SpecialViewController.h"

@interface SpecialViewController ()

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.bHaveHeadTitleScrollView = YES;
    self.titleArrar = @[@"最新上架",@"臭美妞",@"生活家",@"骚包男",@"吃不胖",@"魔法镜",@"爱运动",@"熊孩子",@"数码控"];
    self.cellTypeIndex = cellTableViewTypeIndex;
    
    [super viewDidLoad];
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
