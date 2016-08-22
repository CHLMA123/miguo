//
//  CommodityCarouselViewModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);

@interface CommodityCarouselViewModel : NSObject

@property (nonatomic,copy) ReturnValueBlock returnBlock;
@property (nonatomic,copy) ErrorCodeBlock errorBlock;

- (void)getCarouselData:(NSString *)url;


@end
