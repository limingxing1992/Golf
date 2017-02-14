//
//  MyMessageBaseViewController.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageBaseViewController.h"

@interface MyMessageBaseViewController ()
@end

@implementation MyMessageBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.navigationController.navigationBar.hidden = NO;//显示导航栏
    self.tabBarController.tabBar.hidden = YES;//隐藏标签栏
    
    //设置默认左侧返回按钮
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 9, 18)];
    [leftBtn setBackgroundImage:IMAGE(@"classify36") forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarItem;

    
}

/** 重写设置标题*/
- (void)setName:(NSString *)name{
    if (![_name isEqualToString:name]) {
        _name = name;
        [self settingTitleView];
    }
}

/** 标题view*/
- (void)settingTitleView{
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    titleLb.font = FONT(17);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = BLACKTEXTCOLOR;
    titleLb.text = _name;
    [self.navigationItem setTitleView:titleLb];
}
/** 左侧按钮的监听事件*/
- (void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBaseUI{

    [self.view addSubview:self.topView];
    
    self.topView.frame = CGRectMake(0, NaviBar_HEIGHT,SCREEN_WIDTH, 65);
    
    [self.Segmentedcontrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.topView);
        make.width.offset(275);
        make.height.offset(30);
    }];
}


#pragma mark - 控件懒加载

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = WHITECOLOR;
        [_topView addSubview:self.Segmentedcontrol];
    }
    return _topView;
}

- (UISegmentedControl *)Segmentedcontrol{
    if (!_Segmentedcontrol) {
        _Segmentedcontrol = [[UISegmentedControl alloc] initWithItems:_SegmentedcontrolItems];
        _Segmentedcontrol.tintColor = GLOBALCOLOR;
        [_Segmentedcontrol addTarget:self action:@selector(controlBtnClick:) forControlEvents:UIControlEventValueChanged];
        [_Segmentedcontrol setSelectedSegmentIndex:0];
    }
    return _Segmentedcontrol;
}


#pragma mark - setter方法
-(void)setSegmentedcontrolItems:(NSArray *)SegmentedcontrolItems{
    _SegmentedcontrolItems = SegmentedcontrolItems;
}

#pragma mark - 按钮的监听事件

- (void)controlBtnClick:(UISegmentedControl *)control{
        //切换分栏控制器
    #pragma mark -使用block回传出去再子控制器里面切换数据源
    if (_clickBlock != nil) {
        _clickBlock();
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
