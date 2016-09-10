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

//@property (nonatomic, strong) MCollectionView *mLeftCollection;
//@property (nonatomic, strong) MCollectionView *mMiddCollection;
//@property (nonatomic, strong) MCollectionView *mRightCollection;

//@property (nonatomic, strong) NSArray *mListArray;
//@property (nonatomic, strong) NSArray *mButtonArray;
//@property (nonatomic, strong) NSArray *mScrollDataArray;

//@property (nonatomic, strong) MCollectionView *firstCollection;

@property (nonatomic, strong) UIButton *backAllBtn;

//@property (nonatomic, strong) NSArray *mGoodstuffListArray;
//@property (nonatomic, strong) NSArray *mGoodstuffHeadArray;

@property (nonatomic, strong) NSMutableArray *curDataArray;//当前tableview的数据源

@end

@implementation MCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO; // ScrollView影响因子
    
    if (self.titleArrar.count > 1) {
        
        [self setUpHeadTitleScrollView];
    }
    
    self.currentIndex = 0;
    _curDataArray = [NSMutableArray array];
    [self setupDataWithCurrentIndex:_currentIndex];
    // 添加一个监听 , 监听对象的currentIndex属性的改变, 只要age属性改变就通知self
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSKeyValueObserving
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"currentIndex"]) {
        
        // 对比change字典中new与old，可判断监听属性是变大还是变小.
        int new = [change[NSKeyValueChangeNewKey] intValue]; // 取key为new对应的值
        int old = [change[NSKeyValueChangeOldKey] intValue]; // 取key为old对应的值
        
        if (new != old) {
            [self.curDataArray removeAllObjects];
            [self setupDataWithCurrentIndex:self.currentIndex];
        }
        
    }
}

#pragma mark - setupData
- (void)setupDataWithCurrentIndex:(NSInteger)index{
    NSLog(@"页面切换, 开始获取网络数据...");
    if (index == 0) {
        
        if (_mCarouselViewUrl.length > 0) {//首页是否有轮播图
            
            [self getCarouselDataWithNetUrl:_mCarouselViewUrl];
        }
        if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
            
            [self getCommodityDataWithNetUrl:self.contentUrlArray[0]];
            
        }else if ([_resuableViewClassName isEqualToString:@"GoodstuffHeadView"]){
            
            [self getGoodstuffDataWithNetUrl:self.contentUrlArray[0]];
        }
    }else{
    
        [self getOtherStuffDataWithNetUrl:self.contentUrlArray[index]];
    }
    

}

#pragma mark - setUpViews
- (void)setUpHeadTitleScrollView{
    
    _headTitleScrollView = [[HeadTitleScrollView alloc] initWithSmallScroll:_titleArrar titleNorColor:RGB_White titleSelColor:RGB_White];
    _headTitleScrollView.bounces = NO;
    _headTitleScrollView.backgroundColor = RGB_Black;
    
    __weak MCollectionViewController *WeakSelf = self;
    void(^changeValue)(NSInteger)=^(NSInteger indexs){
        self.currentIndex=indexs;
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
    
    MCollectionView *collectionV = _mCollectionViewArray[_currentIndex];
    [UIView animateWithDuration:0.25 animations:^{
        
        collectionV.contentOffset = CGPointZero;
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
    
    MCollectionView *leftCollection =[[MCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:leftFlowLayout withHeaderClassName:_resuableViewClassName];
    
    if ([_resuableViewClassName isEqualToString:@"CommodityHeadView"]) {
        leftCollection.mCarouselViewUrl = _mCarouselViewUrl;
    }
    __weak typeof(self) weakself = self;
    
    leftCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) self = weakself;
        [self reloadMoreCommodityListData];
        
    }];
    [_contentScrollView addSubview:leftCollection];
    [_mCollectionViewArray addObject:leftCollection];
    
}

- (void)reloadMoreCommodityListData{
    NSLog(@"reloadMoreCommodityListData");
    MCollectionView *collectionV = _mCollectionViewArray[_currentIndex];
    [collectionV.mj_footer beginRefreshing];
    sleep(2);
    [collectionV.mj_footer endRefreshing];
}

- (void)getCarouselDataWithNetUrl:(NSString *)neturl{
    
    CommodityCarouselViewModel *carouselViewModel = [[CommodityCarouselViewModel alloc] init];
    carouselViewModel.carouselReturnBlock = ^(id returnValue){

        NSLog(@"--- _mScrollDataArray --- %@", (NSArray *)returnValue);
        MCollectionView *collectionV = _mCollectionViewArray[0];
        [collectionV commitCarouselImageDataArray:(NSArray *)returnValue];
        
    };
    carouselViewModel.carouselErrorBlock = ^(id errorCode){
        
        NSLog(@"%@",errorCode);
    };
    [carouselViewModel getCarouselData:neturl];
    
}

- (void)getCommodityDataWithNetUrl:(NSString *)url{
    
    CommodityCollectionViewModel *collectionViewModel = [[CommodityCollectionViewModel alloc] init];
    collectionViewModel.returnBlock = ^(id returnValue1, id returnValue2){

        MCollectionView *collectionV = _mCollectionViewArray[0];
        [collectionV commitListContentDataArray:(NSArray *)returnValue1 withButtonDataArray:(NSArray *)returnValue2];
    };
    collectionViewModel.errorBlock = ^(id error){
        NSLog(@"%@", error);
    };
    [collectionViewModel getCollectionData:url withPageNum:0];
}

- (void)getGoodstuffDataWithNetUrl:(NSString *)url{
    
    HaoHuoViewModel *haoHuoViewModel = [[HaoHuoViewModel alloc] init];
    haoHuoViewModel.hhreturnBlock = ^(id value1, id value2){
    
        MCollectionView *collectionV = _mCollectionViewArray[0];
        [collectionV commitHeaderImageDataArray:(NSArray *)value2 ListContentDataArray:(NSArray *)value1];
    };
    haoHuoViewModel.hherrorBlock = ^(id error){
        NSLog(@"%@", error);
    };
    [haoHuoViewModel getHaoHuoData:url];
    
}

- (void)getOtherStuffDataWithNetUrl:(NSString *)url{
    
    HaoHuoViewModel *haoHuoViewModel = [[HaoHuoViewModel alloc] init];
    haoHuoViewModel.hhreturnBlock = ^(id value1, id value2){

        //NSLog(@"####### GET到列表数据 ###########");
        MCollectionView *collectionV = _mCollectionViewArray[_currentIndex];
        [collectionV commitHeaderImageDataArray:nil ListContentDataArray:(NSArray *)value1];
        
    };
    haoHuoViewModel.hherrorBlock = ^(id error){
        NSLog(@"%@", error);
    };
    [haoHuoViewModel getOtherHaoHuoData:url];
}

- (void)setUpMoreCollectionView{
    
    for (NSInteger i = 1; i < _titleArrar.count; i ++) {
        
        CGFloat mCollectionX = SCREEN_WIDTH * i;
        MCollectionView *mCollection = [[MCollectionView alloc] initWithFrame:CGRectMake(mCollectionX, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_otherFlowLayout withHeaderClassName:nil];
        [_contentScrollView addSubview:mCollection];
        [_mCollectionViewArray addObject:mCollection];
        
//        if (i % 3 == 0) {
//            mCollection.backgroundColor = [UIColor blueColor];
//        }else if (i % 3 == 1){
//            mCollection.backgroundColor = [UIColor yellowColor];
//        }else if (i % 3 == 2){
//            mCollection.backgroundColor = [UIColor greenColor];
//        }

    }
    
}

- (void)changeCollectionViewAndLoadData{
    
//    if (_currentIndex == 0) {
//        
//        //index = 0 情况，只需要刷新左边tableView和中间tableView
//        _mLeftCollection = _mCollectionViewArray[_currentIndex];
//        _mMiddCollection = _mCollectionViewArray[_currentIndex +1];
//        [_mLeftCollection reloadData];
//        [_mMiddCollection reloadData];
//        
//    }else if(_currentIndex == _mCollectionViewArray.count - 1){
//        
//        //index 为最后的下标时，刷新右边tableView 和中间tableView
//        _mRightCollection = _mCollectionViewArray[_currentIndex];
//        _mMiddCollection  = _mCollectionViewArray[_currentIndex - 1];
//        [_mRightCollection reloadData];
//        [_mMiddCollection  reloadData];
//        
//    }else{
//        
//        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
//        _mRightCollection = _mCollectionViewArray[_currentIndex+1];
//        _mMiddCollection = _mCollectionViewArray[_currentIndex];
//        _mLeftCollection = _mCollectionViewArray[_currentIndex - 1];
//        [_mRightCollection reloadData];
//        [_mMiddCollection  reloadData];
//        [_mLeftCollection  reloadData];
//    }
    _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentIndex, 0);
}

#pragma mark -UIScrollViewDelegate
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView != _contentScrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    self.currentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSLog(@"### self.currentIndex : %ld", (long)self.currentIndex);
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
