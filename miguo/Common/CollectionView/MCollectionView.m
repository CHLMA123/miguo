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
#import "CommodityCollectionModel.h"

static NSString *collectionID = @"MyCollectionItem";
@interface MCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) NSArray *buttonArray;

@property (nonatomic, strong) NSArray *carouselArray;

@property (nonatomic, assign) NSString *resuableViewClassName;

@property (nonatomic, strong) CommodityHeadView *commodityHeader;

@property (nonatomic, strong) UIButton *backToTopBtn;

@end

@implementation MCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _listArray = [NSArray array];
        self.backgroundColor = MIGUOBackgroundColor;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = YES;
        self.delegate = self;
        self.dataSource = self;
//        [self setBounces:NO];
        [self registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:collectionID];
        
        _backToTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backToTopBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 47, self.height - 73, 47, 47);
        _backToTopBtn.hidden = YES;
        [_backToTopBtn addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
        [_backToTopBtn setImage:[UIImage imageNamed:@"top_btn"] forState:UIControlStateNormal];
        _backToTopBtn.clipsToBounds = YES;
        [self addSubview:_backToTopBtn];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)viewlayout
          withHeaderClassName:(NSString *)headerclassname
{
    self = [self initWithFrame:frame collectionViewLayout:viewlayout];
    if (self) {
        
        _resuableViewClassName = headerclassname;
        
        if ([headerclassname isEqualToString:@"CommodityHeadView"]) {
            
            [self registerClass:[CommodityHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommodityHeadView"];
            
        }else if ([headerclassname isEqualToString:@"GoodstuffHeadView"]){
            [self registerClass:[CommodityHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodstuffHeadView"];
        }

    }
    
    return self;
}



- (void)backToTop{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.contentOffset = CGPointZero;
    }];
    
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    if (_listArray.count != 0) {
        
        list *model = [list mj_objectWithKeyValues:_listArray[indexPath.item]];
        [cell fillCellWithModel:model];
    }
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
            
            _commodityHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CommodityHeadView" forIndexPath:indexPath];
            reusableView = _commodityHeader;
            
        }else if ([_resuableViewClassName isEqualToString:@"GoodstuffHeadView"]){
            GoodstuffHeadView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodstuffHeadView" forIndexPath:indexPath];
            reusableView = sectionHeader;
            reusableView.backgroundColor = RGB_LightRed;
        }
    }
    return reusableView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint pointOffSet = scrollView.contentOffset;
    _backToTopBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 47, self.height - 73 + pointOffSet.y, 47, 47);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint pointOffSet = scrollView.contentOffset;
    if (pointOffSet.y > SCREEN_HEIGHT) {
        _backToTopBtn.hidden = NO;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"点击的item---%zd",indexPath.item);
}


- (void)commitCarouselImageDataArray:(NSArray *)imagearray{
    
    _carouselArray = imagearray;
    [_commodityHeader fillCarouselViewWithArray:_carouselArray];
    
}

- (void)commitListContentDataArray:(NSArray *)listarray withButtonDataArray:(NSArray *)buttonarray{
    
    _listArray = listarray;
    _buttonArray = buttonarray;
    
    [_commodityHeader fillButtonViewWithArray:_buttonArray];
    [self reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
