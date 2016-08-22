//
//  CommodityCollectionViewModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue1, id returnValue2);

typedef void (^ErrorCodeBlock) (id errorCode);

@interface CommodityCollectionViewModel : NSObject

@property (nonatomic,copy) ReturnValueBlock returnBlock;

@property (nonatomic,copy) ErrorCodeBlock errorBlock;

- (void)getCollectionData:(NSString *)url withPageNum:(NSInteger)page;

@end
