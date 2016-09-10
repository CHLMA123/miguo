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
#import "specialViewModel.h"

#define FlexHight SCREEN_HEIGHT - 95

@interface MTableViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) HeadTitleScrollView *headTitleScrollView;

@property (nonatomic, strong) NSMutableArray *mTableViewArray;

//@property (nonatomic, strong) UITableView *mLeftTable;
//@property (nonatomic, strong) UITableView *mMiddTable;
//@property (nonatomic, strong) UITableView *mRightTable;

@property (nonatomic, strong) NSMutableArray *curDataArray;//当前tableview的数据源

@end

@implementation MTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO; // ScrollView影响因子
    
    if (self.titleArrar.count > 1) {
        
        [self setUpHeadTitleScrollView];
    }
    /**
     *  1.创建被监听的对象：person
     */
    self.currentIndex = 0;
    _curDataArray = [NSMutableArray array];
    [self setupDataWithCurrentIndex:_currentIndex];
    /**
     *  2.监听person对象的age属性的变化
     */
    /*
     第一个参数: 告诉系统哪个对象监听
     第二个参数: 监听当前对象的哪个属性
     第三个参数: 监听到属性改变之后, 传递什么值
     第四个参数: 需要传递的参数 (这个参数不是传递给属性的)
     */
    // 添加一个监听 , 监听对象的currentIndex属性的改变, 只要age属性改变就通知self
    [self addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHeadTitleScrollView{
    
    _headTitleScrollView = [[HeadTitleScrollView alloc] initWithSmallScroll:_titleArrar titleNorColor:RGB_Black titleSelColor:[UIColor redColor]];
    _headTitleScrollView.bounces = NO;
    _headTitleScrollView.backgroundColor = RGB_White;
    
    __weak MTableViewController *WeakSelf = self;
    void(^changeValue)(NSInteger)=^(NSInteger indexs){
        self.currentIndex = indexs;
        NSLog(@"用户点击了 %ld", (long)_currentIndex);
        [WeakSelf changeTableViewAndLoadData];
    };
    _headTitleScrollView.changeIndexValue = changeValue;
    [self.view addSubview:_headTitleScrollView];
}

#pragma mark - NSKeyValueObserving
/**
 *  3.实现监听方法 : observeValueForKeyPath: .......
 */
// 注意: KVO只能监听通过set方法修改的值
// 监听到属性的改变就会调用
// keyPath: 被监听的属性名称
// object : 被监听的对象
// context: 注册监听的时候传入的值
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

- (void)setupDataWithCurrentIndex:(NSInteger)index{
    
    specialViewModel *specialDataModel = [[specialViewModel alloc] init];
    specialDataModel.returnBlock = ^(id value){
        
        _curDataArray = [(NSArray *)value mutableCopy];
//        NSLog(@"### 获取到网络数据");
        [_mTableViewArray[index] reloadData];
    };
    specialDataModel.errorBlock = ^(NSError *error){
        NSLog(@"%@", error.description);
    };
    [specialDataModel getContentWithUrl:self.contentUrlArray[index]];
}

- (void)setUpViews{
    
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (_titleArrar.count > 1) {
        _contentScrollView.frame = CGRectMake(0, 95.5, SCREEN_WIDTH, SCREEN_HEIGHT);
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
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGBCOLOR(178, 178, 178);
    [self.view addSubview:lineView];
    
}

- (void)createScrollTableView{
    
    _mTableViewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < _titleArrar.count; i ++) {
        
        CGFloat mTableViewX = i * SCREEN_WIDTH;
        UITableView *mTableView = [[UITableView alloc]initWithFrame:CGRectMake(mTableViewX, 0, SCREEN_WIDTH, FlexHight)];
        mTableView.delegate=self;
        mTableView.dataSource=self;
//        if (i % 3 == 0) {
//            mTableView.backgroundColor = [UIColor redColor];
//        }else if (i % 3 == 1){
//            mTableView.backgroundColor = [UIColor yellowColor];
//        }else if (i % 3 == 2){
//            mTableView.backgroundColor = [UIColor greenColor];
//        }
        [_contentScrollView addSubview:mTableView];
        [_mTableViewArray addObject:mTableView];
        
    }
    
}

- (void)changeTableViewAndLoadData{
    
//    if (_currentIndex == 0) {
//        
//        //index = 0 情况，只需要刷新左边tableView和中间tableView
//        _mLeftTable = _mTableViewArray[_currentIndex];
//        _mMiddTable = _mTableViewArray[_currentIndex +1];
//        [_mLeftTable reloadData];
//        [_mLeftTable reloadData];
//        
//    }else if(_currentIndex == _mTableViewArray.count - 1){
//        
//        //index 为最后的下标时，刷新右边tableView 和中间tableView
//        _mRightTable = _mTableViewArray[_currentIndex];
//        _mMiddTable  = _mTableViewArray[_currentIndex - 1];
//        [_mRightTable reloadData];
//        [_mMiddTable  reloadData];
//        
//    }else{
//        
//        //除了上边两种情况，三个tableView 都要刷新，为了左右移动时都能够显示数据
//        _mRightTable = _mTableViewArray[_currentIndex+1];
//        _mMiddTable = _mTableViewArray[_currentIndex];
//        _mLeftTable = _mTableViewArray[_currentIndex - 1];
//        [_mRightTable reloadData];
//        [_mMiddTable  reloadData];
//        [_mLeftTable  reloadData];
//    }
    _contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH*_currentIndex, 0);
}

#pragma mark -UIScrollViewDelegate
//滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView != _contentScrollView) {
        return;
    }
    //tableView继承scrollView，如果没有上面的判断下拉tableView的时候默认scrollView.contentOffset.x == 0也就是认为向右滑动
    self.currentIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSLog(@"### _currentIndex : %ld", (long)_currentIndex);
    _headTitleScrollView.index = _currentIndex;
    [self changeTableViewAndLoadData];
}



#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH * 330 /640;// 640 * 330 220
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_curDataArray.count > 0) {
//        NSLog(@"### _curDataArray.count : %lu", (unsigned long)_curDataArray.count);
        return _curDataArray.count;
    }else{
    
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MTableViewCell *cell = [MTableViewCell cellWithTableView:tableView];
    if (_curDataArray.count >0) {
        [cell fillCellContentWithModel:(tableData *)_curDataArray[indexPath.row]];
    }else{
        cell.cellImageV.image = [UIImage imageNamed:@"repai"];
    }
    return cell;
}

// 4.对象销毁一定要移除监听
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"currentIndex"];
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
