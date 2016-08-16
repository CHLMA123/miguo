//
//  MyViewController.h
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, cellViewTypeIndex) {
    cellTableViewTypeIndex = 0,
    cellCollectionViewTypeIndex,
};

@interface MyViewController : BaseViewController

@property (nonatomic, assign) BOOL bHaveHeadTitleScrollView;

@property (nonatomic, strong) NSArray *titleArrar;

@property (nonatomic, assign) cellViewTypeIndex cellTypeIndex;

@end
