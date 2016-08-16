//
//  MyViewController.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MyViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionResuableView.h"//CommodityHeadView
#import "HeadTitleScrollView.h"
#import "MyTableViewCell.h"

static NSString *collectionID = @"MyCollectionItem";
static NSString *tableViewID = @"MyTableViewcell";

@interface MyViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) HeadTitleScrollView *headTitleScrollView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *myFlowLayout;

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic,strong) UIScrollView *contentScrollView;
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *midTable;
@property (nonatomic,strong) UITableView *rightTable;

@property (nonatomic,strong) NSArray *tabArr;
@property (nonatomic,strong) NSArray *leftArr;
@property (nonatomic,strong) NSArray *midArr;
@property (nonatomic,strong) NSArray *rigthArr;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO; // ScrollView影响因子
    NSLog(@" ---------- %f : %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    
    if (_bHaveHeadTitleScrollView) {
        
        [self setUpHeadTitleScrollView];
    }
    
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHeadTitleScrollView{
    
    _headTitleScrollView = [[HeadTitleScrollView alloc]initWithSmallScroll:_titleArrar];
    _headTitleScrollView.bounces = NO;
    
    __weak MyViewController *WeakSelf = self;
    void(^changeValue)(NSInteger)=^(NSInteger indexs){
        _currentIndex=indexs;
        NSLog(@"用户点击了 %ld", (long)_currentIndex);
        [WeakSelf changeTableViewAndLoadData];
    };
    _headTitleScrollView.changeIndexValue = changeValue;
    [self.view addSubview:_headTitleScrollView];
}

- (void)setUpViews{
    
    if (_cellTypeIndex == cellTableViewTypeIndex) {
        
        [self creatScrollTableView];
        
    }else if (_cellTypeIndex == cellCollectionViewTypeIndex){
        
        [self setUpCollectionViews];
        
    }
}

- (void)creatScrollTableView{
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 31, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.bounces=NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate=self;
    _contentScrollView.contentOffset = CGPointMake(0, 0);
    
    _leftTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _midTable = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH,0 , SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2,0 , SCREEN_WIDTH, SCREEN_HEIGHT-30)];
    _leftTable.delegate=self;
    _leftTable.dataSource=self;
    _midTable.delegate=self;
    _midTable.dataSource=self;
    _rightTable.delegate=self;
    _rightTable.dataSource=self;
    //注册单元格
    [_leftTable  registerClass:[MyTableViewCell class] forCellReuseIdentifier:tableViewID];
    [_midTable   registerClass:[MyTableViewCell class] forCellReuseIdentifier:tableViewID];
    [_rightTable registerClass:[MyTableViewCell class] forCellReuseIdentifier:tableViewID];
    
    [_contentScrollView addSubview:_leftTable];
    [_contentScrollView addSubview:_midTable];
    [_contentScrollView addSubview:_rightTable];
    [self.view addSubview:_contentScrollView];

}

- (void)setUpCollectionViews{

    self.itemCount = 30;
    CGFloat collectionW = (SCREEN_WIDTH - 5)/2;
    CGFloat collectionH = 300;
    _myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _myFlowLayout.minimumLineSpacing = 5;
    _myFlowLayout.minimumInteritemSpacing = 5;
    _myFlowLayout.itemSize = CGSizeMake(collectionW, collectionH);
    _myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _myFlowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 312);
    
    CGFloat y1 = _bHaveHeadTitleScrollView ? 95 : 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y1, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:_myFlowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBounces:NO];
    [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:collectionID];
    [_collectionView registerClass:[MyCollectionResuableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:_collectionView];
    
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
        
        MyCollectionResuableView *sectionHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = sectionHeader;
        
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

- (void)changeTableViewAndLoadData{
    
    if (_currentIndex == 0) {
        
        //index = 0 情况，只需要刷新左边tableView和中间tableView
        _leftArr = self.tabArr[_currentIndex];
        _midArr = self.tabArr[_currentIndex +1];
        [_leftTable reloadData];
        [_midTable reloadData];
        _contentScrollView.contentOffset = CGPointMake(0, 0);
        
    }else if(_currentIndex == _tabArr.count - 1){
        
        //index 是为最后的下标时，刷新右边tableView 和中间tableView
        _rigthArr = self.tabArr[_currentIndex];
        _midArr = self.tabArr[_currentIndex - 1];
        [_rightTable reloadData];
        [_midTable reloadData];
        _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*2, 0);
        
    }else{
        
        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
        _rigthArr = self.tabArr[_currentIndex+1];
        _midArr = self.tabArr[_currentIndex];
        _leftArr = self.tabArr[_currentIndex - 1];
        [_rightTable reloadData];
        [_midTable reloadData];
        [_leftTable reloadData];
        _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }
}

#pragma mark -UIScrollViewDelegate
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView != _contentScrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    if (scrollView.contentOffset.x == 0) {//右滑（看上一张）
        _currentIndex--;
    }
    if (scrollView.contentOffset.x == SCREEN_WIDTH * 2){//左滑（看下一张）
        _currentIndex++;
    }
    //在最左边往左滑看下一张
    if (_currentIndex == 0 && scrollView.contentOffset.x == SCREEN_WIDTH){
        _currentIndex++;
    }
    //在最右边往右滑看上一张
    if(_currentIndex == self.titleArrar.count-1 && scrollView.contentOffset.x == SCREEN_WIDTH){
        _currentIndex--;
    }
    if ([scrollView isEqual:_contentScrollView]) {
        if (_currentIndex<0) {
            _currentIndex=0;
        }
        if (_currentIndex>self.titleArrar.count-1) {
            _currentIndex=self.titleArrar.count-1;
        }
        _headTitleScrollView.index = _currentIndex;
    }
    
    [self indexForEnable:_currentIndex];
    [self changeTableViewAndLoadData];
}

//确保索引可用
-(NSInteger)indexForEnable:(NSInteger)index{
    if (index < 0 || index == 0) {
        return _currentIndex=0;
    }else if (index > self.tabArr.count - 1 || index == self.tabArr.count - 1){
        return _currentIndex = self.tabArr.count-1;
    }else{
        return _currentIndex==index;
    }
}


#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID forIndexPath:indexPath];
    if (tableView==_leftTable) {
        cell.textLabel.text=self.leftArr[indexPath.row];
        cell.backgroundColor = [UIColor redColor];
    }
    if (tableView==_midTable) {
        cell.textLabel.text=self.midArr[indexPath.row];
        cell.backgroundColor = [UIColor greenColor];
    }
    if (tableView==_rightTable) {
        cell.textLabel.text=self.rigthArr[indexPath.row];
        cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
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
