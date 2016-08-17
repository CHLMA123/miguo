//
//  MyViewController.m
//  miguo
//
//  Created by MCL on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MTableViewController.h"
#import "HeadTitleScrollView.h"
#import "MTableViewCell.h"

#define FlexHight SCREEN_HEIGHT - 95

@interface MTableViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) HeadTitleScrollView *headTitleScrollView;

@property (nonatomic, strong) NSMutableArray *mTableViewArray;

@property (nonatomic, strong) UITableView *mLeftTable;
@property (nonatomic, strong) UITableView *mMiddTable;
@property (nonatomic, strong) UITableView *mRightTable;

@end

@implementation MTableViewController

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
    
    __weak MTableViewController *WeakSelf = self;
    void(^changeValue)(NSInteger)=^(NSInteger indexs){
        _currentIndex=indexs;
        NSLog(@"用户点击了 %ld", (long)_currentIndex);
        [WeakSelf changeTableViewAndLoadData];
    };
    _headTitleScrollView.changeIndexValue = changeValue;
    [self.view addSubview:_headTitleScrollView];
}

- (void)setUpViews{
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (_titleArrar.count > 1) {
        _contentScrollView.frame = CGRectMake(0, 95, SCREEN_WIDTH, SCREEN_HEIGHT);
        _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _titleArrar.count, SCREEN_HEIGHT);
    }
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.bounces=NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate=self;
    _contentScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_contentScrollView];
    
    [self createScrollTableView];
    
}

- (void)createScrollTableView{
    
    _mTableViewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _titleArrar.count; i ++) {
        
        CGFloat mTableViewX = i * SCREEN_WIDTH;
        UITableView *mTableView = [[UITableView alloc]initWithFrame:CGRectMake(mTableViewX, 0, SCREEN_WIDTH, FlexHight)];
        mTableView.delegate=self;
        mTableView.dataSource=self;
        if (i % 3 == 0) {
            mTableView.backgroundColor = [UIColor redColor];
        }else if (i % 3 == 1){
            mTableView.backgroundColor = [UIColor yellowColor];
        }else if (i % 3 == 2){
            mTableView.backgroundColor = [UIColor greenColor];
        }
        [_contentScrollView addSubview:mTableView];
        [_mTableViewArray addObject:mTableView];
        
    }
    
}

- (void)changeTableViewAndLoadData{
    
    if (_currentIndex == 0) {
        
        //index = 0 情况，只需要刷新左边tableView和中间tableView
        _mLeftTable = _mTableViewArray[_currentIndex];
        _mMiddTable = _mTableViewArray[_currentIndex +1];
        [_mLeftTable reloadData];
        [_mLeftTable reloadData];
        
    }else if(_currentIndex == _mTableViewArray.count - 1){
        
        //index 为最后的下标时，刷新右边tableView 和中间tableView
        _mRightTable = _mTableViewArray[_currentIndex];
        _mMiddTable  = _mTableViewArray[_currentIndex - 1];
        [_mRightTable reloadData];
        [_mMiddTable  reloadData];
        
    }else{
        
        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
        _mRightTable = _mTableViewArray[_currentIndex+1];
        _mMiddTable = _mTableViewArray[_currentIndex];
        _mLeftTable = _mTableViewArray[_currentIndex - 1];
        [_mRightTable reloadData];
        [_mMiddTable  reloadData];
        [_mLeftTable  reloadData];
    }
    _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*_currentIndex, 0);
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
    [self changeTableViewAndLoadData];
}



#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MTableViewCell *cell = [MTableViewCell cellWithTableView:tableView];
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
