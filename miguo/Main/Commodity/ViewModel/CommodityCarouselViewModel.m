//
//  CommodityCarouselViewModel.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityCarouselViewModel.h"
#import "CommodityCarouselModel.h"

@implementation CommodityCarouselViewModel

- (void)getCarouselData:(NSString *)url{

    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        
        NSDictionary *dataResponse = (NSDictionary *)responseObject;
        CommodityCarouselModel *carouseModel = [CommodityCarouselModel mj_objectWithKeyValues:dataResponse];
        
        NSArray *array = carouseModel.data;
        if (_carouselReturnBlock) {
            _carouselReturnBlock(array);
        }
        
    } Failure:^(NSError *error) {
        
        NSLog(@"--- error --- : %@", error);
        _carouselErrorBlock(error);
        
    }];
}

@end
