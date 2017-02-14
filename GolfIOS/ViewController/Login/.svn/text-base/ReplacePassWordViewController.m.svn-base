//
//  ReplacePassWordViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/15.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ReplacePassWordViewController.h"

@interface ReplacePassWordViewController ()
<
    STL_SegementControlDelegate,
    UITextFieldDelegate
>
/** 背景滚动*/
@property (nonatomic, strong) UIScrollView *contentView;

/** 左上返回*/
@property (nonatomic, strong) UIButton *leftBackBtn;
/** logo*/
@property (nonatomic, strong) UIImageView *logoIv;
/** 登录模块*/
@property (nonatomic, strong) UIView *loginView;
/** 标题*/
@property (nonatomic, strong) UILabel *replaceTitleLb;
/** 电话输入框*/
@property (nonatomic, strong) UITextField *phoneTf;
/** 切割线*/
@property (nonatomic, strong) UIView *lineView;
/** 验证码输入框*/
@property (nonatomic, strong) UITextField *passwordTf;
/** 发送验证码按钮*/
@property (nonatomic, strong) JKCountDownButton *sendTestBtn;
/** 分割线2*/
@property (nonatomic, strong) UIView *secondLineView;
/**设置 密码输入框*/
@property (nonatomic, strong) UITextField *setPasswordTf;
/** 分割线3*/
@property (nonatomic, strong) UIView *thirdLineView;
/** 确认密码框*/
@property (nonatomic, strong) UITextField *surePasswordTf;

/** 登录按钮*/
@property (nonatomic, strong) UIButton *loginBtn;



/** 当前输入模式 0 ==登录 1==注册*/
@property (nonatomic, assign) NSInteger currentIndex;




@end

@implementation ReplacePassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.leftBackBtn];
    [self.contentView addSubview:self.loginView];
    [self.contentView addSubview:self.logoIv];
    [self.contentView addSubview:self.loginBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _contentView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);

    self.leftBackBtn.sd_layout
    .centerYIs(44)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(50)
    .widthIs(50);
    
    _loginView.sd_layout
    .topSpaceToView(self.contentView, 190)
    .leftSpaceToView(self.contentView, 45)
    .rightSpaceToView(self.contentView, 45);
    [_loginView setSd_cornerRadius:@10];
    [self autoLayoutLoginSubViews];
    
    
    _logoIv.sd_layout
    .bottomSpaceToView(_loginView, -10)
    .centerXEqualToView(self.contentView)
    .heightIs(83)
    .widthIs(182);
    
    _loginBtn.sd_layout
    .topSpaceToView(_loginView, 22)
    .centerXEqualToView(self.contentView)
    .heightIs(64)
    .widthEqualToHeight();
    [self.contentView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 80)];

}

/** 自动布局登录模块*/
- (void)autoLayoutLoginSubViews{
    

    _replaceTitleLb.sd_layout
    .centerXEqualToView(_loginView)
    .topSpaceToView(_loginView, 30)
    .autoHeightRatio(0);
    [_replaceTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _phoneTf.sd_layout
    .topSpaceToView(_replaceTitleLb, 17.5)
    .leftSpaceToView(_loginView, 15)
    .rightSpaceToView(_loginView, 15)
    .heightIs(20);
    
    _lineView.sd_layout
    .topSpaceToView(_replaceTitleLb, 55)
    .leftSpaceToView(_loginView, 0)
    .rightSpaceToView(_loginView, 0)
    .heightIs(0.5);
    
    _passwordTf.sd_layout
    .topSpaceToView(_lineView, 17.5)
    .leftSpaceToView(_loginView, 15)
    .widthRatioToView(_phoneTf, 0.8)
    .heightIs(20);

    
    _sendTestBtn.sd_layout
    .centerYEqualToView(_passwordTf)
    .rightSpaceToView(_loginView, 5)
    .widthIs(65)
    .heightIs(12);
    
    
    _secondLineView.sd_layout
    .topSpaceToView(_lineView, 55)
    .leftSpaceToView(_loginView, 0)
    .rightSpaceToView(_loginView, 0)
    .heightIs(0.5);
    
    _setPasswordTf.sd_layout
    .topSpaceToView(_secondLineView, 17.5)
    .leftSpaceToView(_loginView, 15)
    .rightSpaceToView(_loginView, 15)
    .heightIs(20);
    
    _thirdLineView.sd_layout
    .topSpaceToView(_secondLineView, 55)
    .leftSpaceToView(_loginView, 0)
    .rightSpaceToView(_loginView, 0)
    .heightIs(0.5);
    
    _surePasswordTf.sd_layout
    .topSpaceToView(_thirdLineView, 17.5)
    .leftSpaceToView(_loginView, 15)
    .rightSpaceToView(_loginView, 15)
    .heightIs(20);
    
    [self.loginView setupAutoHeightWithBottomView:_surePasswordTf bottomMargin:17.5];
    


    }


#pragma mark ----------------界面逻辑
/** 返回上级界面*/
- (void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 发送验证码*/
- (void)sendTestWordAction{
    if (!_phoneTf.text.length || ![_phoneTf.text validateMobile]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码"];
        return;
    }
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"发送验证码中"];
    [ShareBusinessManager.loginManager postRegCodeWithParameters:@{@"phoneNumber":_phoneTf.text,
                                                                   @"verifyFlag":@20}
                                                         success:^(id responObject) {
                                                             weakself.sendTestBtn.enabled = NO;
                                                             [weakself.sendTestBtn startWithSecond:60];
                                                             [SVProgressHUD showSuccessWithStatus:@"验证码已发送，请注意查收"];
                                                         }
                                                         failure:^(NSInteger errCode, NSString *errorMsg) {
                                                             [SVProgressHUD showErrorWithStatus:errorMsg];
                                                         }];
}
/** 点击登录按钮*/
- (void)loginAction{
    [self.view endEditing:YES];
    if (![self isFitLoginAccess]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确信息"];
        return ;
    }
    [SVProgressHUD showWithStatus:nil];
    GOLFWeakObj(self);
    [ShareBusinessManager.loginManager postReplacePasswordWithParameters:@{@"newPassword":[_surePasswordTf.text MD5Hash],
                                                                           @"regCode":_passwordTf.text,
                                                                           @"userName":_phoneTf.text}
                                                                 success:^(id responObject) {
                                                                     [SVProgressHUD showSuccessWithStatus:@"找回成功，请重新登录"];
                                                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                         [weakself.navigationController popViewControllerAnimated:YES];
                                                                     });
                                                                 } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];
    
}
/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

/** 判断是否满足登录要求*/
- (BOOL)isFitLoginAccess{
    if (!_phoneTf.text.length) {
        return NO;
    }
    if (![_phoneTf.text validateMobile]) {
        return NO;
    }
    if (!_passwordTf.text.length) {
        return NO;
    }
    
    if (!_setPasswordTf.text.length || ! _surePasswordTf.text.length) {
        return NO;
    }
    
    if (![_setPasswordTf.text isEqualToString:_surePasswordTf.text]) {
        return NO;
    }
    
    return YES;
}

#pragma mark ----------------输入框代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark ----------------实例

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        [_contentView setBackgroundColor:RGBColor(49, 170, 57)];
    }
    return _contentView;
}

- (UIButton *)leftBackBtn{
    if (!_leftBackBtn) {
        _leftBackBtn = [[UIButton alloc] init];
        [_leftBackBtn setImage:IMAGE(@"classify143") forState:UIControlStateNormal];
        _leftBackBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_leftBackBtn addTarget:self action:@selector(leftBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBackBtn;
}

- (UIView *)loginView{
    if (!_loginView) {
        _loginView = [[UIView alloc] init];
        _loginView.backgroundColor = WHITECOLOR;
        [_loginView addSubview:self.replaceTitleLb];
        [_loginView addSubview:self.phoneTf];
        [_loginView addSubview:self.lineView];
        [_loginView addSubview:self.passwordTf];
        [_loginView addSubview:self.sendTestBtn];
        [_loginView addSubview:self.secondLineView];
        [_loginView addSubview:self.setPasswordTf];
        [_loginView addSubview:self.thirdLineView];
        [_loginView addSubview:self.surePasswordTf];
    }
    return _loginView;
    
}

- (UILabel *)replaceTitleLb{
    if (!_replaceTitleLb) {
        _replaceTitleLb = [[UILabel alloc] init];
        _replaceTitleLb.font = FONT(16);
        _replaceTitleLb.textColor = GLOBALCOLOR;
        _replaceTitleLb.text = @"忘记密码";
    }
    return _replaceTitleLb;
}

- (UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [[UIImageView alloc] init];
        _logoIv.image = IMAGE(@"classify159");
    }
    return _logoIv;
}

- (UITextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.placeholder = @"手机号";
        _phoneTf.textColor = SHENTEXTCOLOR;
        _phoneTf.font = FONT(16);
        _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTf.returnKeyType = UIReturnKeyDone;
        _phoneTf.delegate = self;
    }
    return _phoneTf;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (UITextField *)passwordTf{
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.placeholder = @"验证码";
        _passwordTf.textColor = SHENTEXTCOLOR;
        _passwordTf.font = FONT(16);
        _passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTf.returnKeyType = UIReturnKeyDone;
        _passwordTf.delegate = self;
    }
    return _passwordTf;

}


- (UIView *)secondLineView{
    if (!_secondLineView) {
        _secondLineView = [[UIView alloc] init];
        _secondLineView.backgroundColor = GRAYCOLOR;
    }
    return _secondLineView;
}

- (UITextField *)setPasswordTf{
    if (!_setPasswordTf) {
        _setPasswordTf = [[UITextField alloc] init];
        _setPasswordTf.placeholder  = @"重置密码";
        _setPasswordTf.textColor = SHENTEXTCOLOR;
        _setPasswordTf.font = FONT(16);
        _setPasswordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _setPasswordTf.returnKeyType = UIReturnKeyDone;
        _setPasswordTf.delegate = self;
    }
    return _setPasswordTf;

}

- (JKCountDownButton *)sendTestBtn{
    if (!_sendTestBtn) {
        _sendTestBtn = [[JKCountDownButton alloc] init];
        [_sendTestBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendTestBtn setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        _sendTestBtn.titleLabel.font = FONT(12);
        [_sendTestBtn addTarget:self action:@selector(sendTestWordAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendTestBtn didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
            NSString *text = [NSString stringWithFormat:@"%d秒",second];
            return text;
        }];
        
        [_sendTestBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新发送";
        }];
    }
    return _sendTestBtn;
}

- (UIView *)thirdLineView{
    if (!_thirdLineView) {
        _thirdLineView = [[UIView alloc] init];
        _thirdLineView.backgroundColor = GRAYCOLOR;;
    }
    return _thirdLineView;
}

- (UITextField *)surePasswordTf{
    if (!_surePasswordTf) {
        _surePasswordTf = [[UITextField alloc] init];
        _surePasswordTf.font = FONT(16);
        _surePasswordTf.textColor = SHENTEXTCOLOR;
        _surePasswordTf.placeholder = @"确认密码";
        _surePasswordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _surePasswordTf.returnKeyType = UIReturnKeyDone;
        _surePasswordTf.delegate = self;
    }
    return _surePasswordTf;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundImage:IMAGE(@"classify155") forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


@end
