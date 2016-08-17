//
//  MyCollectionFlowLayout.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MCollectionFlowLayout.h"

@implementation MCollectionFlowLayout

- (instancetype)initHeaderReferenceSize:(CGSize)headerSize{
    
    if ([self init]) {
        self.headerReferenceSize = headerSize;
    }
    return self;
}

- (instancetype)init{

    self = [super init];
    if (self) {
        CGFloat collectionW = (SCREEN_WIDTH - 5)/2;
        CGFloat collectionH = 290;
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
        self.itemSize = CGSizeMake(collectionW, collectionH);
        self.scrollDirection = UICollectionViewScrollDirectionVertical; 
    }
    return self;

}

@end
