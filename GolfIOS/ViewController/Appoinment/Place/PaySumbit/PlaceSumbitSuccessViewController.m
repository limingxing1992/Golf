//
//  PlaceSumbitSuccessViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "PlaceSumbitSuccessViewController.h"

@interface PlaceSumbitSuccessViewController ()
/** 成功图标*/
@property (nonatomic, strong) UIImageView *successIv;
/** 预约提示*/
@property (nonatomic, strong) UILabel *sumbitNoticeLb;
/** 标语*/
@property (nonatomic, strong) UILabel *waitLb;
/** 返回首页*/
@property (nonatomic, strong) UIButton *popToHomeBtn;
/** 底部横线*/
@property (nonatomic, strong) UIView *bottomLineView;
/** 底部按钮*/
@property (nonatomic, strong) UIButton *connectServeBtn;



@end

@implementation PlaceSumbitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"预约成功";
    [self.contentView addSubview:self.successIv];
    [self.contentView addSubview:self.sumbitNoticeLb];
    [self.contentView addSubview:self.waitLb];
    [self.contentView addSubview:self.popToHomeBtn];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.connectServeBtn];
    
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
    
    _bottomLineView.sd_layout
    .bottomSpaceToView(self.contentView, 60)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
    
    _connectServeBtn.sd_layout
    .bottomSpaceToView(self.contentView, 10)
    .topSpaceToView(self.bottomLineView, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15);
    [_connectServeBtn setSd_cornerRadius:@5];
    
}

#pragma mark ----------------界面逻辑

- (void)popToHomeAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)connectServeAction{
    [SVProgressHUD showSuccessWithStatus:@"联系客服"];
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
        _sumbitNoticeLb.font = FONT(18);
        _sumbitNoticeLb.textColor = GLOBALCOLOR;
        _sumbitNoticeLb.text = @"预约信息已发送客服";
    }
    return _sumbitNoticeLb;
}

- (UILabel *)waitLb{
    if (!_waitLb) {
        _waitLb = [[UILabel alloc] init];
        _waitLb.font = FONT(12);
        _waitLb.textColor = BLACKTEXTCOLOR;
        _waitLb.text = @"请耐心等待客服电话联系您";
    }
    return _waitLb;
}

- (UIButton *)popToHomeBtn{
    if (!_popToHomeBtn) {
        _popToHomeBtn = [[UIButton alloc] init];
        _popToHomeBtn.layer.borderWidth = 1;
        _popToHomeBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        _popToHomeBtn.titleLabel.font = FONT(15);
        [_popToHomeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        [_popToHomeBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_popToHomeBtn addTarget:self action:@selector(popToHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popToHomeBtn;
}

- (UIView *)bottomLineView{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = GRAYCOLOR;
    }
    return _bottomLineView;
}

- (UIButton *)connectServeBtn{
    if (!_connectServeBtn) {
        _connectServeBtn = [[UIButton alloc] init];
        _connectServeBtn.backgroundColor = GLOBALCOLOR;
        _connectServeBtn.titleLabel.font = FONT(15);
        [_connectServeBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_connectServeBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_connectServeBtn addTarget:self action:@selector(connectServeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectServeBtn;
}


@end
