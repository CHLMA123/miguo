//
//  CommodityCarouselViewModel.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/18.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CarouselReturnValueBlock) (id returnValue);

typedef void (^CarouselErrorCodeBlock) (id errorCode);

@interface CommodityCarouselViewModel : NSObject

@property (nonatomic,copy) CarouselReturnValueBlock carouselReturnBlock;

@property (nonatomic,copy) CarouselErrorCodeBlock carouselErrorBlock;

- (void)getCarouselData:(NSString *)url;


@end
