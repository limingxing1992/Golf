//
//  MyMessageBaseViewController.h
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageBaseViewController : UIViewController
/** 页面标题*/
@property (nonatomic, copy) NSString *name;
/** 顶部分页背景*/
@property (nonatomic, strong) UIView *topView;
/** 分页栏*/
@property (nonatomic, strong) UISegmentedControl *Segmentedcontrol;
/** 第一组数据源*/
@property (nonatomic, strong) NSMutableArray *firstData;
/** 第二组数据源*/
@property (nonatomic, strong) NSMutableArray *secondData;
/** 是否显示头部分栏*/
@property (nonatomic, assign) BOOL isShowSegmentedControl;
/** 设置分栏的items数组*/
@property (nonatomic, strong) NSArray * SegmentedcontrolItems;
/** 点击分栏的block事件的回调*/
@property (nonatomic, copy) void (^clickBlock)();
/**设置基类的UI判断是否带分栏显示*/
-(void)setBaseUI;
/**分栏的点击事件，切换数据源*/
- (void)controlBtnClick:(UISegmentedControl *)control;
@end
