    //
//  MineViewController.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UITableView *aboutTableView;

@property (nonatomic, strong) NSArray *tableDataArrar1;

@property (nonatomic, strong) NSArray *tableImageArrar1;

@property (nonatomic, strong) NSArray *tableDataArrar2;

@property (nonatomic, strong) NSArray *tableImageArrar2;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setStatusColor];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.title = @"";
    self.view.backgroundColor = MIGUOBackgroundColor;
    [self setUpViews];
}

//设置状态栏背景为任意的颜色
- (void)setStatusColor
{
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 20)];
    statusBarView.backgroundColor = [UIColor clearColor];
    [self.navigationController.view addSubview:statusBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViews{
    
    _tableDataArrar1 = @[@"淘宝订单"];
    _tableImageArrar1 = @[@"",@"",@"",@"",@""];
    _tableDataArrar2 = @[@"购物车",@"兑换记录",@"收货地址",@"客服中心",@"我的收藏",@"设置"];
    _tableImageArrar2 = @[@"购物车",@"兑换记录",@"收货地址",@"客服中心",@"我的收藏",@"设置"];
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.frame = CGRectMake(0, 0,SCREEN_WIDTH, 130);
    [_headImageView setImage:[UIImage imageNamed:@"img_bg_320x121_"]];
    [self.navigationController.view addSubview:_headImageView];
    
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headImageView.frame) + 5, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _aboutTableView.delegate = self;
    _aboutTableView.dataSource = self;
    _aboutTableView.height = 44;

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        
    }else{
    
        static NSString *cellID2 = @"id2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        cell.textLabel.text = _tableDataArrar2[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
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
