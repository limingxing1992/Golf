//
//  AppointmentHomeViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/10/31.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "AppointmentHomeViewController.h"

@interface AppointmentHomeViewController ()
/** 进入预定场地按钮*/
@property (nonatomic, strong) STL_MixBtn *placeBtn;
/** 进入一键约球按钮*/
@property (nonatomic, strong) STL_MixBtn *friendBtn;
/** 预约按钮==消失*/
@property (nonatomic, strong) UIButton *backBtn;


@end

@implementation AppointmentHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    [self.view addSubview:self.placeBtn];
    [self.view addSubview:self.friendBtn];
    [self.view addSubview:self.backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self autoLayoutSubViews];//布局
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _backBtn.sd_layout
    .bottomSpaceToView(self.view, 5)
    .centerXEqualToView(self.view)
    .heightIs(50)
    .widthEqualToHeight();
    
    _placeBtn.sd_layout
    .bottomSpaceToView(self.view, 60)
    .centerXIs(SCREEN_WIDTH / 10 *3);
    
    _friendBtn.sd_layout
    .bottomEqualToView(_placeBtn)
    .centerXIs(SCREEN_WIDTH / 10 * 7 );
}

#pragma mark ----------------界面逻辑
/** 退出界面*/
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 进入预定场地*/
- (void)entoAppoinmentPlaceAction{
    PlaceAppointViewController *placeVc  = [[PlaceAppointViewController alloc] init];
    [self.navigationController pushViewController:placeVc animated:YES];
}
/** 进入一键约球*/
- (void)entoAppoinmentFriendAction{
    FriendAppoinViewController *friendVc = [[FriendAppoinViewController alloc] init];
    [self.navigationController pushViewController:friendVc animated:YES];
}
/** 触屏消失*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ----------------实例

- (UIButton *)placeBtn{
    if (!_placeBtn) {
        _placeBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify29") title:@"预定场地"];
        _placeBtn.lb.textColor = WHITECOLOR;
        [_placeBtn addTarget:self action:@selector(entoAppoinmentPlaceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeBtn;
}

- (UIButton *)friendBtn{
    if (!_friendBtn) {
        _friendBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify30") title:@"一键约球"];
        _friendBtn.lb.textColor = WHITECOLOR;
        [_friendBtn addTarget:self action:@selector(entoAppoinmentFriendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendBtn;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setBackgroundImage:IMAGE(@"classify28") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

@end
