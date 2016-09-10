//
//  CommodityViewController.m
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityViewController.h"
#import "CommodityHeadView.h"
#import "CommodityCarouselModel.h"
#import "TestViewController.h"

@interface CommodityViewController ()

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    
    NSMutableArray *urlArray = [NSMutableArray array];
    
    self.resuableViewClassName = @"CommodityHeadView";
    
    self.mCarouselViewUrl = @"http://cloud.repaiapp.com/yunying/spzt.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";
    
    NSString *url0 = @"http://zhekou.repai.com/shop/discount/api/listnew1.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&page=1";
    [urlArray addObject:url0];
    self.contentUrlArray = urlArray;
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setUpTitleView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(carouselADPush:) name:@"mCarouselADPush" object:nil];
    
     [self addObserverToNotificationCenter];
}

#pragma mark 添加监听
/*
 通知中心可以将一个通知发送给多个监听者，而每个对象的代理却只能有一个。当然代理也有其优点，例如使用代理代码分布结构更加清晰，它不像通知一样随处都可以添加订阅等，实际使用过程中需要根据实际情况而定。
 */
-(void)addObserverToNotificationCenter{
    /*添加应用程序进入后台监听
     * observer:监听者
     * selector:监听方法（监听者监听到通知后执行的方法）
     * name:监听的通知名称(下面的UIApplicationDidEnterBackgroundNotification是一个常量)
     * object:通知的发送者（如果指定nil则监听任何对象发送的通知）
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:[UIApplication sharedApplication]];
    
    /* 添加应用程序获得焦点的通知监听
     * name:监听的通知名称
     * object:通知的发送者（如果指定nil则监听任何对象发送的通知）
     * queue:操作队列，如果制定非主队线程队列则可以异步执行block
     * block:监听到通知后执行的操作
     */
    NSOperationQueue *operationQueue=[[NSOperationQueue alloc]init];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication] queue:operationQueue usingBlock:^(NSNotification *note) {
        NSLog(@"Application become active.");
    }];
}

#pragma mark 应用程序启动监听方法
-(void)applicationEnterBackground{
    NSLog(@"Application enter background.");
}

- (void)carouselADPush:(NSNotification *)notify{
    
    NSDictionary *dic = (NSDictionary *)notify.userInfo;
    data *model = [dic objectForKey:@"data"];
    TestViewController *vc = [[TestViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
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
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showMessageView:(UIButton *)sender{
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
//    LOG_METHOD;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
//    LOG_METHOD;

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
