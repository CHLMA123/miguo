//
//  CommodityCarouselViewModel.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityCarouselViewModel.h"
#import "CommodityCarouselModel.h"
#import "NetworkManager.h"

@implementation CommodityCarouselViewModel

- (void)getCarouselData:(NSString *)url{
    url = @"http://cloud.repaiapp.com/yunying/spzt.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo";
    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"----- %@ -----", dic);
        
    } Failure:^(NSError *error) {
        
        
    }];
}

@end
