//
//  HaoHuoViewModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HaoHuoReturnValueBlock) (id returnValue1, id returnValue2);

typedef void (^HaoHuoErrorCodeBlock) (id errorCode);

@interface HaoHuoViewModel : NSObject

@property (nonatomic,copy) HaoHuoReturnValueBlock hhreturnBlock;

@property (nonatomic,copy) HaoHuoErrorCodeBlock hherrorBlock;

- (void)getHaoHuoData:(NSString *)url;

- (void)getOtherHaoHuoData:(NSString *)url;

@end
