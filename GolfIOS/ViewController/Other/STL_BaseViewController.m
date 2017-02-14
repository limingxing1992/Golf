//
//  STL_BaseViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_BaseViewController.h"

@interface STL_BaseViewController ()<UIGestureRecognizerDelegate>


@end


@implementation STL_BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self initData];//初始化数据
    [self.view addSubview:self.contentView];
    
    //设置默认左侧返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 9, 18)];
    [leftBtn setBackgroundImage:IMAGE(@"classify36") forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;//取消布局 影响
    self.navigationController.navigationBar.hidden = NO;//显示导航栏
    self.tabBarController.tabBar.hidden = YES;//隐藏标签栏
    //添加侧滑
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}
// 什么时候调用，每次触发手势之前都会询问下代理方法，是否触发
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}

/** 初始化数据*/
- (void)initData{
}

/** 触摸屏幕*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/** 隐藏左侧返回按钮*/
- (void)setShowBack:(BOOL)showBack{
    if (!showBack) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 关闭背景画布*/
- (void)setIsAutoBack:(BOOL)isAutoBack{
    if (!isAutoBack) {
        [_contentView removeFromSuperview];
    }
}
/** 右边按钮第一个方法*/
- (void)right_0_action{
    [SVProgressHUD showSuccessWithStatus:@"我是第一个按钮"];
}
/** 右边按钮第二个方法*/
- (void)right_1_action{
    [SVProgressHUD showSuccessWithStatus:@"我是第二个按钮"];
}

#pragma mark ----------------实例-界面

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NaviBar_HEIGHT)];
        _contentView.backgroundColor = BACKGROUNDCOLOR;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

/** 重写设置右边第一个按钮*/
- (void)setRightIm_0:(UIImage *)rightIm_0{
    if (_rightIm_0 != rightIm_0) {
        _rightIm_0 = rightIm_0;
    }
    [self settingRightItem_0];
}

- (void)setRightStr_0:(NSString *)rightStr_0{
    if (![_rightStr_0 isEqualToString:rightStr_0]) {
        _rightStr_0 = rightStr_0;
    }
    [self settingRightItem_0];
}

/** 右边第一个按钮*/
- (void)settingRightItem_0{
    //添加右边第一个按钮
    UIBarButtonItem *rightItem;
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    if (_rightStr_0) {
        rightItem = [[UIBarButtonItem alloc] initWithTitle:_rightStr_0 style:UIBarButtonItemStylePlain target:self action:@selector(right_0_action)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName:FONT(14), NSForegroundColorAttributeName:GLOBALCOLOR} forState:UIControlStateNormal];
        
    }else if (_rightIm_0){
        rightItem = [[UIBarButtonItem alloc] initWithImage:[_rightIm_0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(right_0_action)];
    }
    [ary addObject:rightItem];
    self.navigationItem.rightBarButtonItems = ary;
}
/** 重写设置右边第二个按钮*/
- (void)setRightIm_1:(UIImage *)rightIm_1{
    if (_rightIm_1 != rightIm_1) {
        _rightIm_1 = rightIm_1;
    }
    [self settingRightItem_1];
}

- (void)setRightStr_1:(NSString *)rightStr_1{
    if (![_rightStr_1 isEqualToString:rightStr_1]) {
        _rightStr_1 = rightStr_1;
    }
    [self settingRightItem_1];
}

/** 右边第二个按钮*/
- (void)settingRightItem_1{
    //添加右边第二个按钮
    UIBarButtonItem *rightItem;
    if (_rightStr_1) {
        rightItem = [[UIBarButtonItem alloc] initWithTitle:_rightStr_1 style:UIBarButtonItemStylePlain target:self action:@selector(right_1_action)];
        [rightItem setTitleTextAttributes:@{NSFontAttributeName:FONT(14), NSForegroundColorAttributeName:GLOBALCOLOR} forState:UIControlStateNormal];
    }else if (_rightIm_1){
        rightItem = [[UIBarButtonItem alloc] initWithImage:[_rightIm_1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(right_1_action)];
    }
    NSMutableArray *ary = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [ary addObject:rightItem];
    self.navigationItem.rightBarButtonItems = ary;
}

/** 重写设置标题*/
- (void)setName:(NSString *)name{
    if (![_name isEqualToString:name]) {
        _name = name;
    }
    [self settingTitleView];
}
/** 标题view*/
- (void)settingTitleView{
    UIView *title_ve = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];    
    //设置titleview，不过这个view并不是我们需要的居中的view；
    self.navigationItem.titleView = title_ve;
    __weak typeof(self) weakSelf = self;
    //主线程列队一个block， 这样做 可以获取到autolayout布局后的frame，也就是titleview的frame。在viewDidLayoutSubviews中同样可以获取到布局后的坐标
    dispatch_async(dispatch_get_main_queue(), ^{
        //要居中view的宽度
        CGFloat width = 120;
        //实际居中的view
        UILabel *center_ve = [[UILabel alloc]init];
        center_ve.font = FONT(17);
        center_ve.textColor = BLACKTEXTCOLOR;
        center_ve.text = weakSelf.name;
        center_ve.textAlignment = NSTextAlignmentCenter;
        //设置一个基于window居中的坐标
        center_ve.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-width)/2, 20, width, 44);
        //坐标系转换到titleview
        center_ve.frame = [weakSelf.view.window convertRect:center_ve.frame toView:weakSelf.navigationItem.titleView];
        //centerview添加到titleview
        [weakSelf.navigationItem.titleView addSubview:center_ve];
    });
}

//获取标题宽度
- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 17.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}


@end
