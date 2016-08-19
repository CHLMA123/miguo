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
    NSString *mMainCollectionUrl = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=-1&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";
    /*
     {
     "backCover": "http://img.alicdn.com/bao/uploaded/TB1Jv5LLpXXXXbtaXXXSutbFXXX.jpg",
     "bannerUrl": "http://img.alicdn.com/bao/uploaded/TB1IUC2LpXXXXXqXFXXSutbFXXX.jpg_640x640.jpg",
     "bannerUrlForPad": "http://img.alicdn.com/bao/uploaded/TB17deTLpXXXXbJXVXXSutbFXXX.jpg",
     "coverForPadUrl": "http://img.alicdn.com/bao/uploaded/TB1kHWOLpXXXXX7aXXXSutbFXXX.jpg",
     "introForPad": "萌娃的新衣从甜美开始",
     "textBg": 1,
     "title": "萌娃的新衣从甜美开始！",
     "topicContentId": 46271,
     "updateTime": "Update on August 18"
     }
     */
    
    NSString *mMainCollectionUrl2 = @"http://zhekou.repai.com/lws/wangyu/index.php?control=tm&model=ws&tabId=5&page=1&app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";
    /*
     {
     "backCover": "http://img.alicdn.com/bao/uploaded/TB1U2mDLpXXXXXXaFXXSutbFXXX.jpg",
     "bannerUrl": "http://img.alicdn.com/bao/uploaded/TB1TDSILpXXXXcgaXXXSutbFXXX.jpg_640x640.jpg",
     "bannerUrlForPad": "http://img.alicdn.com/bao/uploaded/TB1YjWFLpXXXXa_apXXSutbFXXX.jpg",
     "coverForPadUrl": "http://img.alicdn.com/bao/uploaded/TB1jSeSLpXXXXbqXVXXSutbFXXX.jpg",
     "introForPad": "百搭衣橱的白衬衫",
     "textBg": 1,
     "title": "百搭衣橱的白衬衫",
     "topicContentId": 46269,
     "updateTime": "Update on August 18"
     }
     */
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
