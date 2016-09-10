//
//  specialViewModel.m
//  miguo
//
//  Created by MCL on 16/9/10.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "specialViewModel.h"
#import "specialModel.h"

@implementation specialViewModel

- (void)getContentWithUrl:(NSString *)url{

    [[NetworkManager shareInstance] GET:url Parameters:nil Success:^(id responseObject) {
        
       NSDictionary *dataResponse = (NSDictionary *)responseObject;
        specialModel *model = [specialModel mj_objectWithKeyValues:dataResponse];
        NSArray *array = model.tableData;
        if (_returnBlock) {
            _returnBlock (array);
        }
        
    } Failure:^(NSError *error) {
        if (_errorBlock) {
            NSLog(@"--- error --- : %@", error);
            _errorBlock(error);
        }
        
    }];
    
}

@end
