//
//  CommodityCollectionViewModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommodityCollectionViewModel : NSObject

- (void)getCollectionData:(NSString *)url withPageNum:(NSInteger)page;

@end
