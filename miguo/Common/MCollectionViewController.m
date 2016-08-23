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

#import "CommodityCollectionViewModel.h"
#import "CommodityCarouselViewModel.h"

#import "HaoHuoViewModel.h"

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

@property (nonatomic, strong) NSArray *mListArray;
@property (nonatomic, strong) NSArray *mButtonArray;
@property (nonatomic, strong) NSArray *mScrollDataArray;

@property (nonatomic, strong) MCollectionView *firstCollection;

@property (nonatomic, strong) UIButton *backAllBtn;

@property (nonatomic, strong) NSArray *mGoodstuffListArray;
@property (nonatomic, strong) NSArray *mGoodstuffHeadArray;


@end

@implementation MCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO; // ScrollView影响因子
    
    if (self.titleArrar.count > 1) {
        
        [self setUpHeadTitleScrollView];
    }
    [self setUpData];
    
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpData{
    
    if (_mCarouselViewUrl.length > 0) {//首页是否有轮播图
        
        _mScrollDataArray = [NSArray array];
        [self getCarouselDataWithNetUrl:_mCarouselViewUrl];
    }
    if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
        
        _mListArray = [NSArray array];
        _mButtonArray = [NSArray array];
        [self getCommodityDataWithNetUrl:_mMainContentUrl];
        
    }else if ([_resuableViewClassName isEqualToString:@"GoodstuffHeadView"]){
        
        _mGoodstuffHeadArray = [NSArray array];
        _mGoodstuffListArray = [NSArray array];
        [self getGoodstuffDataWithNetUrl:_mMainContentUrl];
    }

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
    
    _backAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backAllBtn.frame = CGRectMake(SCREEN_WIDTH - 15 - 47, SCREEN_HEIGHT - 73 - 47 - 47 - 10, 47, 47);
    [_backAllBtn addTarget:self action:@selector(backToTopAction) forControlEvents:UIControlEventTouchUpInside];
    [_backAllBtn setImage:[UIImage imageNamed:@"all_btn"] forState:UIControlStateNormal];
    _backAllBtn.clipsToBounds = YES;
    [self.view addSubview:_backAllBtn];

    
}

- (void)backToTopAction{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _firstCollection.contentOffset = CGPointZero;
    }];
    
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
        headerSize = CGSizeMake(SCREEN_WIDTH, 300);
    }else{
        headerSize = CGSizeMake(SCREEN_WIDTH, 325);
    }
    MCollectionFlowLayout *leftFlowLayout = [[MCollectionFlowLayout alloc] initHeaderReferenceSize:headerSize];
    _firstCollection =[[MCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:leftFlowLayout withHeaderClassName:_resuableViewClassName];
    if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
        _firstCollection.mCarouselViewUrl = _mCarouselViewUrl;
    }
    __weak typeof(self) weakself = self;
    
    _firstCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) self = weakself;
        [self reloadMoreCommodityListData];
        
    }];
    [_contentScrollView addSubview:_firstCollection];
    [_mCollectionViewArray addObject:_firstCollection];
    
}

- (void)reloadMoreCommodityListData{
    NSLog(@"reloadMoreCommodityListData");
    [_firstCollection.mj_footer beginRefreshing];
    sleep(2);
    [_firstCollection.mj_footer endRefreshing];
}

- (void)getCarouselDataWithNetUrl:(NSString *)neturl{
    
    CommodityCarouselViewModel *carouselViewModel = [[CommodityCarouselViewModel alloc] init];
    carouselViewModel.carouselReturnBlock = ^(id returnValue){
        
        _mScrollDataArray = returnValue;
        NSLog(@"--- _mScrollDataArray --- %@", _mScrollDataArray);
        [_firstCollection commitCarouselImageDataArray:_mScrollDataArray];
        
    };
    carouselViewModel.carouselErrorBlock = ^(id errorCode){
        
        NSLog(@"%@",errorCode);
    };
    [carouselViewModel getCarouselData:neturl];
    
}

- (void)getCommodityDataWithNetUrl:(NSString *)url{
    
    CommodityCollectionViewModel *collectionViewModel = [[CommodityCollectionViewModel alloc] init];
    collectionViewModel.returnBlock = ^(id returnValue1, id returnValue2){
        _mListArray = returnValue1;
        _mButtonArray = returnValue2;
        [_firstCollection commitListContentDataArray:_mListArray withButtonDataArray:_mButtonArray];
        _firstCollection.itemCount = _mListArray.count;
    };
    collectionViewModel.errorBlock = ^(id error){
        NSLog(@"%@", error);
    };
    [collectionViewModel getCollectionData:_mMainContentUrl withPageNum:0];
}

- (void)getGoodstuffDataWithNetUrl:(NSString *)url{
    
    HaoHuoViewModel *haoHuoViewModel = [[HaoHuoViewModel alloc] init];
    haoHuoViewModel.hhreturnBlock = ^(id value1, id value2){
    
        _mGoodstuffListArray = value1;
        _mGoodstuffHeadArray = value2;
        [_firstCollection commitHeaderImageDataArray:_mGoodstuffHeadArray ListContentDataArray:_mGoodstuffListArray];
        
    };
    haoHuoViewModel.hherrorBlock = ^(id error){
        NSLog(@"%@", error);
    };
    [haoHuoViewModel getHaoHuoData:_mMainContentUrl];
    
}

- (void)setUpMoreCollectionView{
    
    for (NSInteger i = 1; i < _titleArrar.count; i ++) {
        
        CGFloat mCollectionX = SCREEN_WIDTH * i;
        MCollectionView *mCollection = [[MCollectionView alloc] initWithFrame:CGRectMake(mCollectionX, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_otherFlowLayout];
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
