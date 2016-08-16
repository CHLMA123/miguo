//
//  MyCollectionView.h
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionView : UICollectionView

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) NSString *resuableViewClassName;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout withCount:(NSInteger)count withcellKind:(NSString *)cellKind;
@end
