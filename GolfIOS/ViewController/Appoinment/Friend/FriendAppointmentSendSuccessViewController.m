//
//  FriendAppointmentSendSuccessViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/19.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FriendAppointmentSendSuccessViewController.h"

@interface FriendAppointmentSendSuccessViewController ()
/** 成功图标*/
@property (nonatomic, strong) UIImageView *successIv;
/** 预约提示*/
@property (nonatomic, strong) UILabel *sumbitNoticeLb;
/** 标语*/
@property (nonatomic, strong) UILabel *waitLb;
/** 返回首页*/
@property (nonatomic, strong) UIButton *popToHomeBtn;

@end

@implementation FriendAppointmentSendSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"预约成功";
    [self.contentView addSubview:self.successIv];
    [self.contentView addSubview:self.sumbitNoticeLb];
    [self.contentView addSubview:self.waitLb];
    [self.contentView addSubview:self.popToHomeBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];
}

- (void)autoLayoutSubViews{
    _successIv.sd_layout
    .topSpaceToView(self.contentView, 35)
    .centerXEqualToView(self.contentView)
    .heightIs(35)
    .widthEqualToHeight();
    
    _sumbitNoticeLb.sd_layout
    .topSpaceToView(_successIv, 18)
    .centerXEqualToView(self.contentView)
    .heightIs(18);
    [_sumbitNoticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _waitLb.sd_layout
    .topSpaceToView(_sumbitNoticeLb, 15)
    .centerXEqualToView(self.contentView)
    .heightIs(12);
    [_waitLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _popToHomeBtn.sd_layout
    .topSpaceToView(_waitLb, 38)
    .leftSpaceToView(self.contentView, 78)
    .rightSpaceToView(self.contentView, 78)
    .heightIs(45);
    [_popToHomeBtn setSd_cornerRadius:@5];
    
}

#pragma mark ----------------界面逻辑

- (void)popToHomeAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark ----------------实例

- (UIImageView *)successIv{
    if (!_successIv) {
        _successIv = [[UIImageView alloc] init];
        _successIv.image = IMAGE(@"classify56");
    }
    return _successIv;
}

- (UILabel *)sumbitNoticeLb{
    if (!_sumbitNoticeLb) {
        _sumbitNoticeLb = [[UILabel alloc] init];
        _sumbitNoticeLb.font = FONT(14);
        _sumbitNoticeLb.textColor = GLOBALCOLOR;
        _sumbitNoticeLb.text = @"您的邀请帖已发送";
    }
    return _sumbitNoticeLb;
}

- (UILabel *)waitLb{
    if (!_waitLb) {
        _waitLb = [[UILabel alloc] init];
        _waitLb.font = FONT(14);
        _waitLb.textColor = BLACKTEXTCOLOR;
        _waitLb.text = @"耐心等待您的好友回复哦";
    }
    return _waitLb;
}

- (UIButton *)popToHomeBtn{
    if (!_popToHomeBtn) {
        _popToHomeBtn = [[UIButton alloc] init];
        _popToHomeBtn.layer.borderWidth = 1;
        _popToHomeBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _popToHomeBtn.titleLabel.font = FONT(14);
        [_popToHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_popToHomeBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_popToHomeBtn addTarget:self action:@selector(popToHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popToHomeBtn;
}


@end
