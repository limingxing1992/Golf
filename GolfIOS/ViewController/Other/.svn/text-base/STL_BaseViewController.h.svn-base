//
//  STL_BaseViewController.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

/*
 1.默认开启导航栏。关闭标签栏
 2、添加导航栏右边按钮。按顺序添加,指定按钮图片或者名字，子类里重写对应方法
 3.默认开启左侧返回按钮
 4.默认背景画布为ScrollView.
 */

#import <UIKit/UIKit.h>

@interface STL_BaseViewController : UIViewController

/** 背景画布*/
@property (nonatomic, strong) UIScrollView *contentView;
/** 页面标题*/
@property (nonatomic, copy) NSString *name;
/** 导航栏右边第一个按钮图片或者名字*/
@property (nonatomic, strong) UIImage *rightIm_0;
@property (nonatomic, copy) NSString *rightStr_0;
/** 导航栏右边第二个按钮图片或者名字*/
@property (nonatomic, strong) UIImage *rightIm_1;
@property (nonatomic, copy) NSString *rightStr_1;

/** 是否展示返回按钮,默认显示*/
@property (nonatomic, assign) BOOL showBack;
/** 是否开启默认画布Scrollview, 默认开启*/
@property (nonatomic, assign) BOOL isAutoBack;


/** 初始化数据*/
- (void)initData;
/** 左侧返回动作*/
- (void)leftBackAction;
/** 右边按钮第一个动作*/
- (void)right_0_action;
/** 右边按钮第二个动作*/
- (void)right_1_action;

@end
