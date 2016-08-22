    //
//  MineViewController.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MineViewController.h"
#import "AboutTableViewCell.h"

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
    self.view.backgroundColor = [UIColor greenColor];
//    MIGUOBackgroundColor;
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
    
    _tableDataArrar1    = @[@"淘宝订单"];
    _tableImageArrar1   = @[@"bar_one",@"bar_two",@"bar_three",@"bar_four",@"bar_five"];
    _tableDataArrar2    = @[@"购物车",@"兑换记录",@"收货地址",@"客服中心",@"我的收藏",@"设置"];
    _tableImageArrar2   = @[@"gouwuche_btn_17x17_",@"liulanjilu_17x17_",@"shouhuodizhi_17x17_",@"kefu_17x17_",@"shoucang_17x17_",@"shezhi_17x17_"];

    _headImageView = [[UIImageView alloc] init];
    _headImageView.frame = CGRectMake(0, 0,SCREEN_WIDTH, 130);
    [_headImageView setImage:[UIImage imageNamed:@"img_bg_320x121_"]];
    [self.navigationController.view addSubview:_headImageView];
    
    _aboutTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _aboutTableView.delegate = self;
    _aboutTableView.dataSource = self;
    [self.view addSubview:_aboutTableView];
    
    _aboutTableView.tableFooterView = [[UIView alloc] init];
    

}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return _tableDataArrar2.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return 58;
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellID00 = @"id00";
            AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID00];
            if (cell == nil) {
                cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID00];
            }
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 11, 67, 22);
            [button setImage:[UIImage imageNamed:@"haoduodingdan_btn_67x21_"] forState:UIControlStateNormal];
            [cell.contentView addSubview:button];
            return cell;
        }else if(indexPath.row == 1){
            static NSString *cellID01 = @"id01";
            AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID01];
            if (cell == nil) {
                cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID01];
            }
            for (NSInteger i = 0; i < 5; i ++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat x_btn = i * (SCREEN_WIDTH/5);
                button.frame = CGRectMake(x_btn, 0, SCREEN_WIDTH/5, 58);
                button.tag = 100 + i;
                NSString *imageName = _tableImageArrar1[i];
                [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(ButtonBarAction:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:button];
            }
            return cell;
        }else{
            static NSString *cellID02 = @"id02";
            AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID02];
            if (cell == nil) {
                cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID02];
            }
            cell.textLabel.text = _tableDataArrar1[0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else{
    
        static NSString *cellID2 = @"id2";
        AboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[AboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        [cell.contentView removeAllSubviews];
        cell.textLabel.text = _tableDataArrar2[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        NSString *imageName = _tableImageArrar2[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:imageName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    return nil;
}

/**
 *  分割线不到边
 */
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    if ([_aboutTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_aboutTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_aboutTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_aboutTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)ButtonBarAction:(UIButton *)sender{
    NSLog(@"---- sender.tag : %ld ----", (long)sender.tag);
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
