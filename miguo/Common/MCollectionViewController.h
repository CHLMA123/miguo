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

@property (nonatomic, strong) NSArray *titleArrar;

@property (nonatomic, assign) NSString *resuableViewClassName;

@property (nonatomic, strong) HeadTitleScrollView *headTitleScrollView;

@end
