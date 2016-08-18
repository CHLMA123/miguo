//
//  MyCollectionView.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MCollectionView.h"
#import "MyCollectionViewCell.h"
#import "CommodityHeadView.h"
#import "GoodstuffHeadView.h"

static NSString *collectionID = @"MyCollectionItem";
@interface MCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation MCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self setBounces:NO];
        [self registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:collectionID];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withCount:(NSInteger)count withcellKind:(NSString *)cellKind
{
    self = [self initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _itemCount = count;
        _resuableViewClassName = cellKind;
        if ([cellKind isEqualToString:@"CommodityHeadView"]) {
            
            [self registerClass:[CommodityHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommodityHeadView"];
            
        }else if ([cellKind isEqualToString:@"GoodstuffHeadView"]){
            [self registerClass:[CommodityHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodstuffHeadView"];
        }

    }
    
    return self;
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
            
           CommodityHeadView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommodityHeadView" forIndexPath:indexPath];
            [sectionHeader fillHeaderSectionViewwithImageArray:@[@"1",@"2",@"1",@"2",@"1"]];
            reusableView = sectionHeader;
            
        }else if ([_resuableViewClassName isEqualToString:@"GoodstuffHeadView"]){
            GoodstuffHeadView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodstuffHeadView" forIndexPath:indexPath];
            reusableView = sectionHeader;
        }
    }
    reusableView.backgroundColor = RGB_LightRed;
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的item---%zd",indexPath.item);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
