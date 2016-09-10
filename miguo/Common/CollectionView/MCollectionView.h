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

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)viewlayout
          withHeaderClassName:(NSString *)headerclassname;// 有headerSection的初始化方法

- (void)commitCarouselImageDataArray:(NSArray *)imagearray;// 轮播UI

//Commodity 数据处理
- (void)commitListContentDataArray:(NSArray *)listarray withButtonDataArray:(NSArray *)buttonarray;
//Goodstuff 数据处理
- (void)commitHeaderImageDataArray:(NSArray *)imagearray ListContentDataArray:(NSArray *)listarray;
@end
