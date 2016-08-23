//
//  CommodityHeadView.m
//  miguo
//
//  Created by MACHUNLEI on 16/8/16.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "CommodityHeadView.h"
#import "CommodityCarouselModel.h"
#import "CommodityCarouselViewModel.h"
#import "CommodityCollectionModel.h"
#import "UIButton+WebCache.h"

@interface CommodityHeadView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *mScrollView;
@property (nonatomic, strong) UIPageControl *mPageControl;
@property (nonatomic, strong) NSArray *mScrollSubjecData;   // 轮播数据源
@property (nonatomic, strong) NSTimer *timer;               // 轮播定时器

@property (nonatomic, assign) NSInteger mScrollViewH;       // 轮播图高度
@property (nonatomic, assign) NSInteger mPageControlW;      // 分页指示宽度

@property (nonatomic, strong) NSArray *mButtonModelArray;   //四个按钮View

@property (nonatomic, strong) UIButton *mButton1;

@property (nonatomic, strong) UIButton *mButton2;

@property (nonatomic, strong) UIButton *mButton3;

@property (nonatomic, strong) UIButton *mButton4;

@end

@implementation CommodityHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _mScrollViewH = 120;
        _mPageControlW = 100;
        self.backgroundColor = RGB_White;
        [self commitInitViews];
    }
    return self;
}
#pragma mark - UI
- (void)commitInitViews{
    
    //1 ScrollView
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
    _mPageControl.frame = CGRectMake(SCREEN_WIDTH - _mPageControlW - 10, _mScrollViewH - 25, _mPageControlW, 15);
    _mPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _mPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _mPageControl.userInteractionEnabled = NO;
    //    _mPageControl.center = CGPointMake(_mScrollView.center.x, _mScrollViewH - 30);
    
    [self addSubview:_mScrollView];
    [self addSubview:_mPageControl];
    
    // 2 ButtonView
    // 296 * 116
    CGFloat spaceX = 8;
    CGFloat _mButtonW = (SCREEN_WIDTH - spaceX * 3)/2;
    CGFloat _mButtonH = _mButtonW * 116/296;
    CGFloat spaceY = (self.height - _mButtonH * 2 - _mScrollViewH)/4;
    
    _mButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton1.frame = CGRectMake(spaceX, _mScrollViewH + spaceY, _mButtonW, _mButtonH);
    _mButton1.tag = 200;
    [_mButton1 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _mButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton2.frame = CGRectMake(CGRectGetMaxX(_mButton1.frame) + spaceX, _mScrollViewH + spaceY, _mButtonW, _mButtonH);
    _mButton2.tag = 201;
    [_mButton2 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _mButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton3.frame = CGRectMake(spaceX, CGRectGetMaxY(_mButton1.frame) + 2 *spaceY, _mButtonW, _mButtonH);
    _mButton3.tag = 202;
    [_mButton3 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
    _mButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton4.frame = CGRectMake(CGRectGetMaxX(_mButton1.frame) + spaceX, CGRectGetMaxY(_mButton1.frame) + 2 *spaceY, _mButtonW, _mButtonH);
    _mButton4.tag = 203;
    [_mButton4 addTarget:self action: @selector(mButtonViewPush:) forControlEvents:UIControlEventTouchUpInside];
    
//    _mButton1.backgroundColor = RGB_Random;
//    _mButton2.backgroundColor = RGB_Random;
//    _mButton3.backgroundColor = RGB_Random;
//    _mButton4.backgroundColor = RGB_Random;
    
    [self addSubview:_mButton1];
    [self addSubview:_mButton2];
    [self addSubview:_mButton3];
    [self addSubview:_mButton4];
    
}

#pragma mark - ScrollViewWithImage
- (void)fillCarouselViewWithArray:(NSArray *)imageModelArray{
    
    _mScrollSubjecData = imageModelArray;
    NSLog(@"--- _mCarouselModelArray --- %@", _mScrollSubjecData);

    [self handleScrollView];
    
}

#pragma mark - ScrollView数据处理
/*
 实现循环滚动
 在前后各添加一个冗余的view
 1.在最前面添加一个view,用来显示和最后一页相同的内容
 2.在最后一页的后面添加一个view,用来显示和第一页相同的内容
 */
- (void)handleScrollView{
    
    _mPageControl.numberOfPages = _mScrollSubjecData.count;
    _mScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *(_mScrollSubjecData.count +2), _mScrollViewH);
    
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _mScrollViewH)];
    UIImageView *lastImage = [[UIImageView alloc] initWithFrame:CGRectMake((_mScrollSubjecData.count+1)*SCREEN_WIDTH, 0, SCREEN_WIDTH, _mScrollViewH)];
    [_mScrollView addSubview:firstImage];
    [_mScrollView addSubview:lastImage];
    
    for (int i = 0; i < _mScrollSubjecData.count; i++) {
        data * model = [data mj_objectWithKeyValues:_mScrollSubjecData[i]];
        
        NSString *imageUrl = model.iphoneimg;
        if (i == 0) {
            [lastImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_bg_320x121_"]];
        }
        if (i == _mScrollSubjecData.count -1) {
            [firstImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_bg_320x121_"]];
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake((i+1) *SCREEN_WIDTH, 0, SCREEN_WIDTH, _mScrollViewH);
        imageView.tag = 100 + i;

        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"img_bg_320x121_"]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mCarouselViewPush:)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        
        [_mScrollView addSubview:imageView];
        [self startTimer];
    }
}

- (void)mCarouselViewPush:(UITapGestureRecognizer *)tap{
    
    NSInteger dd = tap.view.tag - 100;
    data * model = [data mj_objectWithKeyValues:_mScrollSubjecData[dd]];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"mCarouselADPush" object:nil userInfo:@{@"data":model}];
    
}

#pragma mark - ButtonViewWithImage
- (void)fillButtonViewWithArray:(NSArray *)imageModelArray{
    
    category_s *btnModel1 = [[category_s alloc] init];
    btnModel1 = [category_s mj_objectWithKeyValues:imageModelArray[0]];
    NSString *imageUrl1 = btnModel1.pic;
    NSLog(@" sd_setBackgroundImageWithURL1 : %@", imageUrl1);
    [_mButton1 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl1] forState:UIControlStateNormal];
    
    category_s *btnModel2 = [[category_s alloc] init];
    btnModel2 = [category_s mj_objectWithKeyValues:imageModelArray[1]];
    NSString *imageUrl2 = btnModel2.pic;
    NSLog(@" sd_setBackgroundImageWithURL2 : %@", imageUrl2);
    [_mButton2 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl2] forState:UIControlStateNormal];
    
    category_s *btnModel3 = [[category_s alloc] init];
    btnModel3 = [category_s mj_objectWithKeyValues:imageModelArray[2]];
    NSString *imageUrl3 = btnModel3.pic;
    NSLog(@" sd_setBackgroundImageWithURL3 : %@", imageUrl3);
    [_mButton3 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl3] forState:UIControlStateNormal];
    
    category_s *btnModel4 = [[category_s alloc] init];
    btnModel4 = [category_s mj_objectWithKeyValues:imageModelArray[3]];
    NSString *imageUrl4 = btnModel4.pic;
    NSLog(@" sd_setBackgroundImageWithURL4 : %@", imageUrl4);
    [_mButton4 sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl4] forState:UIControlStateNormal];

}


- (void)mButtonViewPush:(UIButton *)sender{
    if (sender.tag == 200) {
        NSLog(@"button1");
        
    }else if (sender.tag == 201) {
        NSLog(@"button2");
        
    }else if (sender.tag == 202) {
        NSLog(@"button3");
        
    }else if (sender.tag == 203) {
        NSLog(@"button4");
        
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
