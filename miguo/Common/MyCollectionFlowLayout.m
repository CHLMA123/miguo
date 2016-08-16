//
//  MyCollectionFlowLayout.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MyCollectionFlowLayout.h"

@implementation MyCollectionFlowLayout

//- (instancetype)configInitHeadData:(BOOL)bHaveHeadSection{
//    
//    if (self) {
//        if (bHaveHeadSection) {
//            if (bHaveHeadSection) {
//                NSLog(@"-------2016-----------------");
//                self.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 312);
//            }
//        }
//    }
//    return self;
//}

- (instancetype)init{

    self = [super init];
    if (self) {
        CGFloat collectionW = (SCREEN_WIDTH - 5)/2;
        CGFloat collectionH = 300;
        self.minimumLineSpacing = 5;
        self.minimumInteritemSpacing = 5;
        self.itemSize = CGSizeMake(collectionW, collectionH);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
    }
    return self;

}

@end
