//
//  SmallScroll.m
//  新闻资讯Demo
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "HeadTitleScrollView.h"

#define slideViewHight 2

@interface HeadTitleScrollView ()

@property (nonatomic, strong) NSMutableArray *titleButtonArr;

@property (nonatomic, strong) NSMutableArray *titleWidthArr;

@property (nonatomic, strong) UIView *slideLineView;//滑动的视图

@end

@implementation HeadTitleScrollView
- (instancetype)initWithSmallScroll:(NSArray *)titleArray{

    if (self = [super init]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor greenColor];
        self.frame = CGRectMake(0, 64, SCREEN_WIDTH, ScrollHight);
        NSMutableArray *tempButton = [NSMutableArray array];
        NSMutableArray *tempButtonW = [NSMutableArray array];
        for (int i = 0; i < titleArray.count; i++) {
            
            NSString *titleStr = titleArray[i];
            CGFloat titleW = [self getStringWidthSize:titleStr andFontOfSize:15.f];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.tag = i +100;
            UIButton *view = [self viewWithTag:btn.tag - 1];
            if (i != 0) {
                btn.frame = CGRectMake(CGRectGetMaxX(view.frame), 0, titleW, 30);
            }else{
                btn.frame = CGRectMake(0, 0, titleW, 30);
            }
            btn.backgroundColor = RGB_Random;
            
            [self addSubview:btn];
            [btn setTitle:titleStr forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [tempButton addObject:btn];
            [tempButtonW addObject:[@(titleW) stringValue]];
        }
        _titleButtonArr = tempButton;
        _titleWidthArr  = tempButtonW;
        self.index = 0;
        CGFloat sum = [[_titleWidthArr valueForKeyPath:@"@sum.floatValue"] floatValue];
        self.contentSize = CGSizeMake(sum, ScrollHight);
        [self createSlideLineView];
    }
    
    return self;
}

// 创建滑动的视图
-(void)createSlideLineView{
    
    _slideLineView = [[UIView alloc]init];
    _slideLineView.frame = CGRectMake(0, ScrollHight - slideViewHight, [_titleWidthArr[0] floatValue], slideViewHight); // default
    _slideLineView.backgroundColor = [UIColor redColor];
    [self addSubview:_slideLineView];
    
}

-(void)buttonClicked:(UIButton *)button{
    self.index = button.tag - 100;
    // block的回调，当button的index发生变化时，将index的值传给视图控制器
    if (_changeIndexValue) {
        _changeIndexValue(_index);
    }
}

-(void)setIndex:(NSInteger)index{
    
    UIButton *notSelectedButton = _titleButtonArr[_index];//将上一个button设置成未选中状态
    notSelectedButton.selected = NO;
    UIButton *selectedButton = _titleButtonArr[index];
    selectedButton.selected = YES;

    // 设置选中的Button居中
    CGFloat offSetX = selectedButton.frame.origin.x - SCREEN_WIDTH/2;
    if (offSetX < 0) {
        //当offSetX的值小于0时（即点击的是中心点左边的button时），让offSetX为0；
        offSetX = 0;
        
    }else{
        //反之，让offSetX的值为selectedButton.frame.origin.x-SCREEN_WIDTH/2+kButtonWidth/2
        offSetX = offSetX + [_titleWidthArr[index] floatValue]/2.0;
        //2、在大于0的情况下，又大于self.contentSize.width - kScreenWidth时，offSetX 的值为self.contentSize.width - kScreenWidth，反之为：selectedButton.frame.origin.x-kScreenWidth/2+kButtonWidth/2
        if (offSetX > (self.contentSize.width - SCREEN_WIDTH)) {
            
            offSetX = self.contentSize.width - SCREEN_WIDTH;
        }
        
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(offSetX, 0);
    }];
    
    _index = index;
    CGRect frame = _slideLineView.frame;
    if (index == 0) {
        frame.origin.x = 0;
    }else{
        frame.origin.x = CGRectGetMaxX([self viewWithTag:100 +index - 1].frame);
    }
    frame.size.width = [_titleWidthArr[index] floatValue];
    [UIView animateWithDuration:0.01 animations:^{
        _slideLineView.frame = frame;
    }];
    
}

//字符宽度
- (CGFloat)getStringWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont{

    CGSize sizeText = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(sizeText.width), ceilf(sizeText.height));
    
    return statuseStrSize.width + 15;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
