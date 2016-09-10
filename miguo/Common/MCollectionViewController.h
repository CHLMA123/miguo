//
//  CollectionViewController.h
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseViewController.h"
#import "HeadTitleScrollView.h"

@interface MCollectionViewController : BaseViewController

@property (nonatomic, strong) NSArray *titleArrar;              //标题栏Init数据源

@property (nonatomic, strong) NSArray *contentUrlArray;

//以下两个属性用与初始化MCollectionView的SectionHeader
@property (nonatomic, assign) NSString *mCarouselViewUrl;       //Carousel View URL

@property (nonatomic, assign) NSString *resuableViewClassName;  //SectionHeader Class

@end
