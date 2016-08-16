//
//  SmallScroll.m
//  新闻资讯Demo
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HeadTitleScrollView.h"
#import "TitleDataModel.h"
#import "CommonMode.h"

#define slideViewHight 2

@interface HeadTitleScrollView ()

@property (nonatomic, strong) NSMutableArray *titleBtnArr;
@property (nonatomic, strong) NSMutableArray *titleWidthArr;
@property (nonatomic, strong) UIView *slideView;//滑动的视图

@end

@implementation HeadTitleScrollView
- (instancetype)initWithSmallScroll:(NSArray *)titleArray{

    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.frame = CGRectMake(0, 64, SCREEN_WIDTH, ScrollHight);
        NSMutableArray *tempWithArr = [NSMutableArray array];
        for (int i = 0; i < titleArray.count; i++) {
            
            NSString *titleStr = titleArray[i];
            CGFloat titleW = [CommonMode getStringWidthSize:titleStr andFontOfSize:15.f];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = i +100;
            UIButton *view = [self viewWithTag:btn.tag - 1];
            if (i != 0) {
                btn.frame = CGRectMake(CGRectGetMaxX(view.frame) + 10, 0, titleW, 30);
            }else{
                btn.frame = CGRectMake(10, 0, titleW, 30);
            }
            [self addSubview:btn];
            [btn setTitle:titleStr forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [tempWithArr addObject:[@(titleW) stringValue]];
        }
        
        _titleWidthArr = tempWithArr;
        self.index = 0;
        CGFloat sum = [[_titleWidthArr valueForKeyPath:@"@sum.floatValue"] floatValue] + (_titleWidthArr.count+1)*10;
        self.contentSize = CGSizeMake(sum, ScrollHight);
        [self createSlideView];
    }
    
    return self;
}

// 创建滑动的视图
-(void)createSlideView{
    
    _slideView = [[UIView alloc]init];
    _slideView.frame = CGRectMake(10, ScrollHight - slideViewHight, [_titleWidthArr[0] floatValue], slideViewHight); // default
    _slideView.backgroundColor = [UIColor redColor];
    [self addSubview:_slideView];
    
}

-(void)buttonClicked:(UIButton *)button{
    self.index = button.tag - 100;
    // block的回调，当button的index发生变化时，将index的值传给视图控制器
    if (_changeIndexValue) {
        _changeIndexValue(_index);
    }
}

-(void)setIndex:(NSInteger)index{
    
    UIButton *notSelectedButton = _titleBtnArr[_index];//将上一个button设置成未选中状态
    notSelectedButton.selected = NO;
    UIButton *selectedButton = _titleBtnArr[index];
    selectedButton.selected = YES;
    
    // 设置选中的Button居中
    CGFloat offSetX = selectedButton.frame.origin.x - SCREEN_WIDTH/2;
    //1、当offSetX的值小于0时（即点击的是中心点左边的button时），让offSetX为0；反之，让offSetX的值为selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
    offSetX = offSetX > 0 ?(offSetX + [_titleWidthArr[index] floatValue]/2):0;
    //2、在大于0的情况下，又大于self.contentSize.width - kScreenWidth时，offSetX 的值为self.contentSize.width - kScreenWidth，反之为：selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
    offSetX = offSetX > self.contentSize.width - SCREEN_WIDTH ? self.contentSize.width - SCREEN_WIDTH :offSetX;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offSetX, 0);
    }];
    
    _index = index;
    CGRect frame = _slideView.frame;
    if (index == 0) {
        frame.origin.x = 10;
    }else{
        frame.origin.x = CGRectGetMaxX([self viewWithTag:100 +index - 1].frame) + 10;//x
    }
    frame.size.width = [_titleWidthArr[index] floatValue];//W
    [UIView animateWithDuration:0.01 animations:^{
        _slideView.frame = frame;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
