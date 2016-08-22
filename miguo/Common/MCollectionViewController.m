//
//  CollectionViewController.m
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MCollectionViewController.h"
#import "MCollectionView.h"
#import "MCollectionFlowLayout.h"

#define FlexHight SCREEN_HEIGHT - 95

@interface MCollectionViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HeadTitleScrollView *headTitleScrollView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) MCollectionFlowLayout *otherFlowLayout;

@property (nonatomic, strong) NSMutableArray *mCollectionViewArray;

@property (nonatomic, strong) MCollectionView *mLeftCollection;
@property (nonatomic, strong) MCollectionView *mMiddCollection;
@property (nonatomic, strong) MCollectionView *mRightCollection;

@end

@implementation MCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO; // ScrollView影响因子
    
    if (self.titleArrar.count > 1) {
        
        [self setUpHeadTitleScrollView];
    }
    
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHeadTitleScrollView{
    
    _headTitleScrollView = [[HeadTitleScrollView alloc] initWithSmallScroll:_titleArrar];
    _headTitleScrollView.bounces = NO;
    
    __weak MCollectionViewController *WeakSelf = self;
    void(^changeValue)(NSInteger)=^(NSInteger indexs){
        _currentIndex=indexs;
        NSLog(@"用户点击了 %ld", (long)_currentIndex);
        [WeakSelf changeCollectionViewAndLoadData];
    };
    _headTitleScrollView.changeIndexValue = changeValue;
    [self.view addSubview:_headTitleScrollView];
}

- (void)setUpViews{
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (_titleArrar.count > 1) {
        //有标题栏 则_contentScrollView向下偏移
        _contentScrollView.frame = CGRectMake(0, 95, SCREEN_WIDTH, SCREEN_HEIGHT);
        _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _titleArrar.count, SCREEN_HEIGHT);
    }
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.bounces = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_contentScrollView];
    
    [self createScrollCollectionView];
    
}

- (void)createScrollCollectionView{
    
    _mCollectionViewArray = [NSMutableArray array];
    
    [self setUpleftCollectionView];
    
    if (_titleArrar.count > 1) {
        
        _otherFlowLayout = [[MCollectionFlowLayout alloc] init];
        
        [self setUpMoreCollectionView];
    }
}

- (void)setUpleftCollectionView{
    
    CGSize headerSize = CGSizeZero;
    if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
        headerSize = CGSizeMake(SCREEN_WIDTH, 330);
    }else{
        headerSize = CGSizeMake(SCREEN_WIDTH, 360);
    }
    MCollectionFlowLayout *leftFlowLayout = [[MCollectionFlowLayout alloc] initHeaderReferenceSize:headerSize];
    MCollectionView *leftCollection = [[MCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FlexHight) collectionViewLayout:leftFlowLayout withCount:30 withSectionHeaderClassName:_resuableViewClassName];
    leftCollection.mCarouselViewUrl = _mCarouselViewUrl;
    [_contentScrollView addSubview:leftCollection];
    [_mCollectionViewArray addObject:leftCollection];
    
}

- (void)setUpMoreCollectionView{
    
    for (NSInteger i = 1; i < _titleArrar.count; i ++) {
        
        CGFloat mCollectionX = SCREEN_WIDTH * i;
        MCollectionView *mCollection = [[MCollectionView alloc] initWithFrame:CGRectMake(mCollectionX, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_otherFlowLayout withCount:30 withSectionHeaderClassName:nil];
        [_contentScrollView addSubview:mCollection];
        [_mCollectionViewArray addObject:mCollection];
        
        if (i % 3 == 0) {
            mCollection.backgroundColor = [UIColor redColor];
        }else if (i % 3 == 1){
            mCollection.backgroundColor = [UIColor yellowColor];
        }else if (i % 3 == 2){
            mCollection.backgroundColor = [UIColor greenColor];
        }

    }
    
}

- (void)changeCollectionViewAndLoadData{
    
    if (_currentIndex == 0) {
        
        //index = 0 情况，只需要刷新左边tableView和中间tableView
        _mLeftCollection = _mCollectionViewArray[_currentIndex];
        _mMiddCollection = _mCollectionViewArray[_currentIndex +1];
        [_mLeftCollection reloadData];
        [_mMiddCollection reloadData];
        
    }else if(_currentIndex == _mCollectionViewArray.count - 1){
        
        //index 为最后的下标时，刷新右边tableView 和中间tableView
        _mRightCollection = _mCollectionViewArray[_currentIndex];
        _mMiddCollection  = _mCollectionViewArray[_currentIndex - 1];
        [_mRightCollection reloadData];
        [_mMiddCollection  reloadData];
        
    }else{
        
        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
        _mRightCollection = _mCollectionViewArray[_currentIndex+1];
        _mMiddCollection = _mCollectionViewArray[_currentIndex];
        _mLeftCollection = _mCollectionViewArray[_currentIndex - 1];
        [_mRightCollection reloadData];
        [_mMiddCollection  reloadData];
        [_mLeftCollection  reloadData];
    }
    _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentIndex, 0);
}

#pragma mark -UIScrollViewDelegate
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView != _contentScrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    _currentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    _headTitleScrollView.index = _currentIndex;
    [self changeCollectionViewAndLoadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
