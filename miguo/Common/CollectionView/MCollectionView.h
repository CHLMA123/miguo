//
//  MyCollectionView.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCollectionView : UICollectionView

@property (nonatomic, assign) NSString *mCarouselViewUrl;       //Carousel View URL

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withCount:(NSInteger)count withSectionHeaderClassName:(NSString *)headerclassname;

@end
