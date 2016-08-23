//
//  HaoHuoViewModel.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HaoHuoViewModel.h"
#import "HaoHuoModel.h"

@implementation HaoHuoViewModel

- (void)getHaoHuoData:(NSString *)url{
    
    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        
        HaoHuoModel *hhModel = [[HaoHuoModel alloc] init];
        hhModel = [HaoHuoModel mj_objectWithKeyValues:responseObject];
        NSArray *hhListArray = hhModel.HaoHuolist;
        NSArray *hhheadArray = hhModel.market_camp;
        _hhreturnBlock(hhListArray, hhheadArray);
        
    } Failure:^(NSError *error) {
        
        _hherrorBlock(error);
        
    }];
}

@end
