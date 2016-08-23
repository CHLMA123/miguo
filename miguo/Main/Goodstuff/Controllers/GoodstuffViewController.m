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
    
    self.mMainContentUrl = @"http://zhekou.repai.com/jkjby/view/rp_b2c_list_v5.php?limit=100&&access_token=&appkey=100071&app_oid=2ad000dbe962fff914983edbf273b427&app_id=594792631&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&pay=weixin&senddata=20150922";
    /*
     {
     "rp_type": "103",
     "num_iid": 2014563645504887,
     "des": "优雅时尚的造型设计 特长高弹性刷丝 适合清理缝隙 ",
     "title": "家庭10支装 韩国抗菌成人螺纹刷柄超细耐用软毛牙刷 ",
     "limitCount": 0,
     "pic_url": "http://pic.repaiapp.com/pic/c4/77/26/c47726525068cf35d88324a3b9b1d388883aa003.png",
     "tezheng": "",
     "tezhengjurl": "http://m.repai.com/item/view/id/2014563645504887/?push=target",
     "now_price": 9.9,
     "show_time": "无",
     "origin_price": 19.8,
     "discount": 5,
     "start_discount": "2016-07-19 00:00:00",
     "deal_num": 5,
     "is_vip_price": 0,
     "is_onsale": 1,
     "total_love_number": 0,
     "rp_quantity": 138,
     "rp_sold": "2.0万",
     "item_url": "https://m.repai.com/item/view/id/2014563645504887",
     "item_urls": "https://m.repai.com/item/view/id/2014563645504887?arg=ok",
     "is_view_show": "0",
     "tagimage": "http://m.repai.com/static/new_img/buy_f.png?v=1",
     "lefttop_pic": "",
     "tag_bt0": "居家必备",
     "tag_bt1": "懒人装备",
     "tag_bt0url": "http://zhekou.repai.com/jkjby/view/rp_b2c_update1.php?type=1&amp;jid=17&amp;snew=1",
     "tag_bt1url": "http://zhekou.repai.com/jkjby/view/rp_b2c_update1.php?type=1&amp;jid=8&amp;snew=1",
     "cache_time": "2016-08-18 21:34:05"
     }
     */
    /*
     market_camp
     {
     "pic": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "pic_320": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "pic_375": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "pic_414": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "pic_768": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "pic_pc": "http://pic.repaiapp.com/pic/16/cb/cf/16cbcf14eb992ff986634fb0bfa1e0eca7747b1e.png",
     "url": "http://m.repai.com/act/yhq_centre_0?appkey=100071&amp;tcid=",
     "is_web": "1",
     "text": "1",
     "time": 1459148901
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
