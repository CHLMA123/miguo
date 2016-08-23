//
//  CommodityViewController.h
//  miguo
//
//  Created by MCL on 16/8/17.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "MCollectionViewController.h"

@interface CommodityViewController : MCollectionViewController

@end

/*
 CommodityViewController --(push)---> TestViewController 调用方法先后顺序
 
 2016-08-23 10:03:42.844 miguo[16658:10756848] CommodityViewController/viewWillDisappear:
 2016-08-23 10:03:42.845 miguo[16658:10756848] TestViewController/viewWillAppear:
 2016-08-23 10:03:43.375 miguo[16658:10756848] CommodityViewController/viewDidDisappear:
 2016-08-23 10:03:43.375 miguo[16658:10756848] TestViewController/viewDidAppear:
 --------------------------------------------------------------------------------------------------
 
 ViewController的生命周期中各方法执行流程如下：init—>loadView—>viewDidLoad—>viewWillApper—>viewDidApper—>viewWillDisapper—>viewDidDisapper—>viewWillUnload->viewDidUnload—>dealloc
 --------------------------------------------------------------------------------------------------
 
 -[ViewController initWithCoder:]或-[ViewController initWithNibName:Bundle]:首先从归档文件中加载UIViewController对象。即使是纯代码，也会把nil作为参数传给后者。
 -[UIView awakeFromNib]:作为第一个方法的助手，方便处理一些额外的设置。
 -[ViewController loadView]:创建或加载一个view并把它赋值给UIViewController的view属性
 -[ViewController viewDidLoad]:此时整个视图层次(view hierarchy)已经被放到内存中，可以移除一些视图，修改约束，加载数据等
 -[ViewController viewWillAppear:]:视图加载完成，并即将显示在屏幕上,还没有设置动画，可以改变当前屏幕方向或状态栏的风格等。
 -[ViewController viewWillLayoutSubviews]：即将开始子视图位置布局
 -[ViewController viewDidLayoutSubviews]：用于通知视图的位置布局已经完成
 -[ViewController viewDidAppear:]：视图已经展示在屏幕上，可以对视图做一些关于展示效果方面的修改。
 -[ViewController viewWillDisappear:]：视图即将消失
 -[ViewController viewDidDisappear:]：视图已经消失
 
 如果考虑UIViewController可能在某个时刻释放整个view。那么再次加载视图时显然会从步骤3开始。因为此时的UIViewController对象依然存在。
 --------------------------------------------------------------------------------------------------
 */