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

    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        
        CommodityCollectionModel *model = [[CommodityCollectionModel alloc] init];
        model = [CommodityCollectionModel mj_objectWithKeyValues:responseObject];
        NSArray *listArray = model.collectlist;
        NSArray *category = model.category_s;
        
        _returnBlock(listArray, category);
        
    } Failure:^(NSError *error) {
        
        _errorBlock(error);
    }];

}

@end
