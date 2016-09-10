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
    self.titleArrar = @[@"最新上架",@"臭美妞",@"生活家",@"骚包男",@"吃不胖",@"魔法镜",@"爱运动",@"熊孩子",@"数码控"];
    
    NSMutableArray *urlArray = [NSMutableArray array];
    
    NSString *mUrl1 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=0&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 最新上架..
    [urlArray addObject:mUrl1];
    
    NSString *mUrl2 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=5&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 臭美妞..
    [urlArray addObject:mUrl2];
    
    NSString *mUrl3 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=2&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 生活家..
    [urlArray addObject:mUrl3];
    
    NSString *mUrl4 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=4&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 骚包男
    [urlArray addObject:mUrl4];
    
    NSString *mUrl5 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=3&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 吃不胖..
    [urlArray addObject:mUrl5];
    
    NSString *mUrl6 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=7&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 魔法镜
    [urlArray addObject:mUrl6];
    
    NSString *mUrl7 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=6&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 爱运动
    [urlArray addObject:mUrl7];
    
    NSString *mUrl8 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=8&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 熊孩子
    [urlArray addObject:mUrl8];
    
    NSString *mUrl9 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=1&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";// 数码控
    [urlArray addObject:mUrl9];
    
    
    self.contentUrlArray = [urlArray mutableCopy];
    
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
