//
//  specialViewModel.h
//  miguo
//
//  Created by MCL on 16/9/10.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);

typedef void (^ErrorCodeBlock) (id errorCode);

@interface specialViewModel : NSObject

@property (nonatomic, copy) ReturnValueBlock returnBlock;

@property (nonatomic, copy) ErrorCodeBlock errorBlock;

- (void)getContentWithUrl:(NSString *)url;

@end
