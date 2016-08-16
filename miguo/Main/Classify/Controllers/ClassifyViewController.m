//
//  ClassificationViewController.m
//  miguo
//
//  Created by MCL on 16/8/15.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "ClassifyViewController.h"

@interface ClassifyViewController ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTitleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTitleView{
    
    //search
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton sizeToFit];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    [self.navigationItem setRightBarButtonItem:searchItem];
    
    //Title
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"分类",@"场景",@"品牌",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(0.0,20.0,198.0,30.0);
    segmentedControl.tintColor = [UIColor clearColor];
    
    NSDictionary* unselectedTextAttributes = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:17],
                         NSForegroundColorAttributeName: [UIColor blackColor]};
    [segmentedControl setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    NSDictionary* selectedTextAttributes = @{
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:17],
                         NSForegroundColorAttributeName:[UIColor redColor]};
    [segmentedControl setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    
    [segmentedControl addTarget:self action:@selector(showSegmentPageView:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex=0;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 66, 1)];
    _lineView.backgroundColor = [UIColor blackColor];
    [segmentedControl addSubview:_lineView];
    [self.navigationItem setTitleView:segmentedControl];
    
}

- (void)showSearchView:(UIButton *)sender{

}

- (void)showSegmentPageView:(UISegmentedControl *)sender{
    
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [UIView animateWithDuration:0.25 animations:^{
                _lineView.frame = CGRectMake(0, 30, 66, 1);
            }];
            NSLog(@"分类");
        }
            break;
        case 1:
        {
            [UIView animateWithDuration:0.25 animations:^{
                _lineView.frame = CGRectMake(66, 30, 66, 1);
            }];
            NSLog(@"场景");
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.25 animations:^{
                _lineView.frame = CGRectMake(132, 30, 66, 1);
            }];
            NSLog(@"品牌");
        }
            break;
        default:
            break;
    }
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
