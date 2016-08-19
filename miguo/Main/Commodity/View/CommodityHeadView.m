//
//  CommodityHeadView.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityHeadView.h"

@interface CommodityHeadView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *mScrollView;
@property (nonatomic, strong) UIPageControl *mPageControl;
@property (nonatomic, strong) NSArray *mScrollSubjecData;   // 轮播数据源
@property (nonatomic, strong) NSTimer *timer;               // 轮播定时器

@property (nonatomic, assign) NSInteger mScrollViewH;       // 轮播图高度
@property (nonatomic, assign) NSInteger mPageControlW;      // 分页指示宽度

@end

@implementation CommodityHeadView

- (void)fillHeaderSectionViewwithImageArray:(NSArray *)imagearray{
    _mScrollSubjecData = imagearray;
    [self handleScrollView];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _mScrollViewH = 160;
        _mPageControlW = 150;
        _mScrollSubjecData = @[@"1", @"2", @"3", @"4", @"5"];
        [self commitInitViews];
    }
    return self;
}

- (void)commitInitViews{

    _mScrollView = [[UIScrollView alloc] init];
    _mScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _mScrollViewH);
    _mScrollView.backgroundColor = [UIColor lightGrayColor];
    _mScrollView.pagingEnabled = YES;
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.showsVerticalScrollIndicator = NO;
    _mScrollView.delegate = self;
    [_mScrollView setBounces:NO];
    [_mScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    
    _mPageControl = [[UIPageControl alloc] init];
    _mPageControl.frame = CGRectMake(SCREEN_WIDTH - _mPageControlW - 15, _mScrollViewH - 30, _mPageControlW, 15);
    _mPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _mPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _mPageControl.userInteractionEnabled = NO;
//    _mPageControl.center = CGPointMake(_mScrollView.center.x, _mScrollViewH - 30);
    
    [self addSubview:_mScrollView];
    [self addSubview:_mPageControl];
}

#pragma mark - ScrollView数据处理
- (void)handleScrollView{
    
    _mPageControl.numberOfPages = _mScrollSubjecData.count;
    _mScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *(_mScrollSubjecData.count +2), _mScrollViewH);
    //实现循环滚动
    //在前后各添加一个冗余的view
    //1.在最前面添加一个view,用来显示和最后一页相同的内容
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _mScrollViewH)];
    //2.在最后一页的后面添加一个view,用来显示和第一页相同的内容
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake((_mScrollSubjecData.count+1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, _mScrollViewH)];
    [_mScrollView addSubview:firstImage];
    [_mScrollView addSubview:lastImage];
    
    for (int i = 0; i < _mScrollSubjecData.count; i++) {
//        GoodsSubjectModel * model = [[GoodsSubjectModel alloc] init];
//        model = (GoodsSubjectModel *)self.subjectModelMArr[i];
//        
//        NSString *imageUrl = model.home_banner;
//        if (i == 0) {
//            [lastImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_load"]];
//        }
//        if (i == self.subjectModelMArr.count -1) {
//            [firstImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_load"]];
//        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((i+1) *SCREEN_WIDTH, 0, SCREEN_WIDTH, _mScrollViewH);
        imageView.tag = 100 + i;
        
        imageView.image = [UIImage imageNamed:@"img_bg_320x121_"];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_load"]];
        
        [_mScrollView addSubview:imageView];
        [self startTimer];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    int page = offsetX / SCREEN_WIDTH;
    if (page == (_mScrollSubjecData.count +1)) {
        //解决最后一张有延时的问题
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        _mPageControl.currentPage = 0;
    }
}

//用手开始拖拽的时候，就停止定时器，不然用户拖拽的时候，也会出现换页的情况
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self stopTimer];
    
}

//用户停止拖拽的时候，就启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self startTimer];
}

//定时器滚动scrollview停止的时候，显示下一张图片
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

//手指拖动scroll停止的时候，显示下一张图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint currentLocation = scrollView.contentOffset;
    if (currentLocation.x/SCREEN_WIDTH == (_mScrollSubjecData.count +1)) {//判断是否已经翻到最后
        //将当前位置设置为原来的第一张图片
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
        _mPageControl.currentPage = 0;
    }
    else if (currentLocation.x/SCREEN_WIDTH == 0) {//判断是否已经翻到最后
        //将当前位置设置为原来的最后一张图片
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*_mScrollSubjecData.count, 0) animated:NO];
        _mPageControl.currentPage = (_mScrollSubjecData.count -1);
    }
    else
    {
        _mPageControl.currentPage  = currentLocation.x/SCREEN_WIDTH -1;
    }
    
}

#pragma mark - timer
- (void)startTimer{
    //只有一张图片
    if (_mScrollSubjecData.count == 1) {
        return;
    }
    if (_timer) {
        [self stopTimer];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeNextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)changeNextPage{

    CGPoint currentLocation = _mScrollView.contentOffset;
    CGPoint offset = CGPointMake(currentLocation.x + SCREEN_WIDTH, 0);
    [_mScrollView setContentOffset:offset animated:YES];
    
    if (offset.x/SCREEN_WIDTH == _mScrollSubjecData.count +1) {//判断是否已经翻到最后
        // 将当前位置设置为原来的第一张图片
        _mPageControl.currentPage = 0;
        // NSLog(@"%lu", self.subjectModelMArr.count +1);
    }
    else if (currentLocation.x/SCREEN_WIDTH == 0) {//判断是否已经翻到最前
        // 将当前位置设置为原来的最后一张图片
        _mPageControl.currentPage = _mScrollSubjecData.count -1;
    }
    else
    {
        _mPageControl.currentPage  = currentLocation.x/SCREEN_WIDTH;
        // NSLog(@"%ld", (long)_pageControl.currentPage);
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
