//
//  CommodityHeadView.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseCollectionResuableView.h"

@interface CommodityHeadView : BaseCollectionResuableView

- (void)fillCarouselViewWithArray:(NSArray *)imageModelArray;

- (void)fillButtonViewWithArray:(NSArray *)imageModelArray;

@end
