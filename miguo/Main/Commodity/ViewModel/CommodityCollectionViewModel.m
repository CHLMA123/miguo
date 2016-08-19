//
//  CommodityCollectionViewModel.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityCollectionViewModel.h"
#import "CommodityCollectionModel.h"

@implementation CommodityCollectionViewModel

- (void)getCollectionData:(NSString *)url withPageNum:(NSInteger)page{

    url = @"http://zhekou.repai.com/shop/discount/api/listnew1.php?app_id=594792631&app_oid=2ad000dbe962fff914983edbf273b427&app_version=1.1.1&app_channel=iphoneappstore&shce=miguo&page=1";
    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"----- %@ -----", dic);
        
    } Failure:^(NSError *error) {
        
        
    }];

}

@end
