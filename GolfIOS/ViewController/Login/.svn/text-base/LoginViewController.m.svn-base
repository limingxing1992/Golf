//
//  LoginViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
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
/** 顶部菜单栏*/
@property (nonatomic, strong) STL_SegementControl *control;
/** 电话输入框*/
@property (nonatomic, strong) UITextField *phoneTf;
/** 切割线*/
@property (nonatomic, strong) UIView *lineView;
/** 密码输入框*/
@property (nonatomic, strong) UITextField *passwordTf;
/** 忘记密码按钮*/
@property (nonatomic, strong) UIButton *forgetBtn;
/** 发送验证码按钮*/
@property (nonatomic, strong) JKCountDownButton *sendTestBtn;
/** 分割线2*/
@property (nonatomic, strong) UIView *secondLineView;
/**设置 密码输入框*/
@property (nonatomic, strong) UITextField *setPasswordTf;
/** 登录按钮*/
@property (nonatomic, strong) UIButton *loginBtn;
/**  底部第三方登录模块*/
@property (nonatomic, strong) UIView *elseLoginView;
/** 注释线条*/
@property (nonatomic, strong) UIView *simpleView;
/** 线条1*/
@property (nonatomic, strong) UIView *simpleLine_0;
/** 线条2*/
@property (nonatomic, strong) UIView *simpleLine_1;
/** 文字*/
@property (nonatomic, strong) UILabel *elseLb;
/** QQ*/
@property (nonatomic, strong) UIButton *qqBtn;
/** 微信*/
@property (nonatomic, strong) UIButton *wxBtn;
///** 新浪*/
//@property (nonatomic, strong) UIButton *sinaBtn;




/** 当前输入模式 0 ==登录 1==注册*/
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSString *type;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.leftBackBtn];
    [self.contentView addSubview:self.loginView];
    [self.contentView addSubview:self.logoIv];
    [self.contentView addSubview:self.loginBtn];
    [self.contentView addSubview:self.elseLoginView];
    


    [GOLFNotificationCenter addObserver:self selector:@selector(wxLoginUserFication:) name:@"wxLoginName" object:nil];
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

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self name:@"wxLoginName" object:nil];
}

/** 自动布局登录模块*/
- (void)autoLayoutLoginSubViews{
    _control.sd_layout
    .topSpaceToView(_loginView, 22.5)
    .leftSpaceToView(_loginView, 0)
    .rightSpaceToView(_loginView, 0)
    .heightIs(25);
    
    _phoneTf.sd_layout
    .centerYIs(77.5)
    .leftSpaceToView(_loginView, 15)
    .rightSpaceToView(_loginView, 15)
    .heightIs(20);
    
    _lineView.sd_layout
    .topSpaceToView(_control, 55)
    .leftSpaceToView(_loginView, 0)
    .rightSpaceToView(_loginView, 0)
    .heightIs(0.5);
    
    _forgetBtn.sd_layout
    .centerYIs(132.5)
    .rightSpaceToView(_loginView, 5)
    .widthIs(65)
    .heightIs(12);
    
    _passwordTf.sd_layout
    .centerYEqualToView(_forgetBtn)
    .leftSpaceToView(_loginView, 15)
    .widthRatioToView(_phoneTf, 0.8)
    .heightIs(20);
    
    _sendTestBtn.sd_layout
    .centerYEqualToView(_forgetBtn)
    .rightSpaceToView(_loginView, 5)
    .widthIs(0)
    .heightIs(0);
    
    [self.loginView setupAutoHeightWithBottomView:_passwordTf bottomMargin:17.5];
    
    [_control setIndex:0];
    
    _elseLoginView.sd_layout
    .centerXEqualToView(self.contentView)
    .bottomSpaceToView(self.contentView, 33)
    .leftSpaceToView(self.contentView, 35)
    .rightSpaceToView(self.contentView, 35)
    .heightIs(100);
    [self autoLayoutElseLoginSubViews];

}
/** 自动布局第三方登录模块*/
- (void)autoLayoutElseLoginSubViews{
    _simpleView.sd_layout
    .topSpaceToView(_elseLoginView, 0)
    .leftSpaceToView(_elseLoginView, 0)
    .rightSpaceToView(_elseLoginView, 0)
    .heightIs(16);
    
    _elseLb.sd_layout
    .centerYEqualToView(_simpleView)
    .centerXEqualToView(_simpleView)
    .autoHeightRatio(0);
    [_elseLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _simpleLine_0.sd_layout
    .centerYEqualToView(_elseLb)
    .rightSpaceToView(_elseLb, 5)
    .leftSpaceToView(_simpleView, 0)
    .heightIs(0.5);
    
    _simpleLine_1.sd_layout
    .centerYEqualToView(_elseLb)
    .leftSpaceToView(_elseLb, 5)
    .rightSpaceToView(_simpleView, 0)
    .heightIs(0.5);
    
    [_simpleView setupAutoWidthWithRightView:_simpleLine_1 rightMargin:0];
    
    _qqBtn.sd_layout
    .bottomSpaceToView(_elseLoginView, 0)
    .leftSpaceToView(_elseLoginView, 50)
    .heightIs(53)
    .widthEqualToHeight();
    [_qqBtn setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _wxBtn.sd_layout
    .rightSpaceToView(_elseLoginView, 50)
    .bottomSpaceToView(_elseLoginView, 0)
    .heightRatioToView(_qqBtn, 1)
    .widthEqualToHeight();
    [_wxBtn setSd_cornerRadiusFromWidthRatio:@0.5];
    
//    _sinaBtn.sd_layout
//    .bottomSpaceToView(_elseLoginView, 0)
//    .rightSpaceToView(_elseLoginView, 5)
//    .heightRatioToView(_qqBtn, 1)
//    .widthEqualToHeight();
//    [_sinaBtn setSd_cornerRadiusFromWidthRatio:@0.5];
    

}


#pragma mark ----------------界面逻辑

/** 返回上级界面*/
- (void)leftBackAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/** 切换*/
- (void)selectByIndex:(NSInteger)index{
    _phoneTf.text = nil;
    _passwordTf.text = nil;
    _setPasswordTf.text = nil;
    [self.view endEditing:YES];

    if (index) {
        [_loginView addSubview:self.secondLineView];
        [_loginView addSubview:self.setPasswordTf];
        _secondLineView.sd_layout
        .topSpaceToView(_lineView, 55)
        .leftSpaceToView(_loginView, 0)
        .rightSpaceToView(_loginView, 0)
        .heightIs(0.5);
        
        _setPasswordTf.sd_layout
        .centerYIs(187.5)
        .leftSpaceToView(_loginView, 15)
        .rightSpaceToView(_loginView, 15)
        .heightIs(20);
        
        _sendTestBtn.sd_layout
        .widthIs(65)
        .heightIs(12);
        _forgetBtn.sd_layout
        .widthIs(0)
        .heightIs(0);
        
        [self.loginView setupAutoHeightWithBottomView:_setPasswordTf bottomMargin:17.5];
        
        _passwordTf.placeholder = @"验证码";
        
        [self.elseLoginView removeFromSuperview];
    }else{
        _sendTestBtn.sd_layout
        .widthIs(0)
        .heightIs(0);
        _forgetBtn.sd_layout
        .widthIs(65)
        .heightIs(12);
        
        [_secondLineView removeFromSuperview];
        [_setPasswordTf removeFromSuperview];
        [self.loginView setupAutoHeightWithBottomView:_passwordTf bottomMargin:17.5];
        _passwordTf.placeholder = @"输入密码";
        
        [self.contentView addSubview:self.elseLoginView];
    }
    _currentIndex = index;
    


}
/** 进入忘记按钮*/
- (void)forgetAction{
    ReplacePassWordViewController *replace = [[ReplacePassWordViewController alloc] init];
    [self.navigationController pushViewController:replace animated:YES];
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
                                                                   @"verifyFlag":@10}
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
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码或输入密码"];
        return ;
    }
    
    GOLFWeakObj(self);
    if (_currentIndex == 0) {
        [self loginPostWith:_passwordTf.text userName:_phoneTf.text];
    }else if (_currentIndex == 1){
        //注册操作
        if (!_setPasswordTf.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在注册中"];
        [ShareBusinessManager.loginManager postRegisterWithParameters:@{@"password":[_setPasswordTf.text MD5Hash],
                                                                        @"regCode":_passwordTf.text,
                                                                        @"userName":_phoneTf.text}
                                                              success:^(id responObject) {
                                                                  //注册成功;
                                                                  [SVProgressHUD showSuccessWithStatus:@"注册成功,正在登录中"];
                                                                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                      [weakself loginPostWith:_setPasswordTf.text userName:_phoneTf.text];
                                                                  });
                                                              }
                                                              failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];
    }

}
/** 登录动作*/
- (void)loginPostWith:(NSString *)password userName:(NSString *)username{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"正在登录中"];
    [ShareBusinessManager.loginManager postLoginWithParameters:@{@"deviceType":@1, @"password":[password MD5Hash], @"userName":username} success:^(id responObject) {
        //登录成功
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
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
    
    return YES;
}
/** 使用第三方登录*/
- (void)elseLoginAction:(UIButton *)btn{
    NSInteger tag = btn.tag;
    switch (tag) {
        case 101:
        {
            //qq登录
            _type = @"20";
            [self getAuthWithUserInfoFromQQ];
        }
            break;
        case 102:
        {
            //微信登录
            _type = @"10";
            [self getAuthWithUserInfoFromWechat];
        }
            break;
        case 103:
        {
            //新浪登录
//            [self getAuthWithUserInfoFromSina];
        }
            break;
        default:
            break;
    }
}
/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
#pragma mark ----------------第三方登录
/** QQ*/
- (void)getAuthWithUserInfoFromQQ
{
    GOLFWeakObj(self);
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_QQ completion:nil];
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"授权失败"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            [weakself tieTestWith:resp];
        }
    }];
}
/** 微信*/
- (void)getAuthWithUserInfoFromWechat
{
//    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:nil];
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    int a = arc4random_uniform(100);
    req.state = [NSString stringWithFormat:@"%d", a] ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];

}

/** 微信登录接受通知信息*/
- (void)wxLoginUserFication:(NSNotification *)cation{
    
    SendAuthResp *resp = cation.userInfo[@"wxLogin"];
    
    
    switch (resp.errCode) {
        case 0:
        {
            GOLFWeakObj(self);
            [ShareBusinessManager.loginManager postWxAccessTokenWithParameters:@{@"appid":WXAppID,
                                                                                 @"secret":WXSercret,
                                                                                 @"code":resp.code,
                                                                                 @"grant_type":@"authorization_code"}
                                                                       success:^(id responObject) {
                                                                           NSString *accessToken = responObject[@"access_token"];
                                                                           NSString *openId = responObject[@"openid"];
                                                                           
                                                                           if (!accessToken || !openId) {
                                                                               [SVProgressHUD showErrorWithStatus:@"信息错误,请重试"];
                                                                               return ;
                                                                           }
                                                                           [ShareBusinessManager.loginManager postWxUserInfoWithParameters:@{@"access_token":accessToken,
                                                                                                                                             @"openid":openId} success:^(id responObject) {
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 UMSocialUserInfoResponse *resp = [[UMSocialUserInfoResponse alloc] init];
                                                                                                                                                 resp.uid = responObject[@"unionid"];
                                                                                                                                                 resp.name =responObject[@"nickname"];
                                                                                                                                                 resp.iconurl = responObject[@"headimgurl"];
                                                                                                                                                 [weakself tieTestWith:resp];
                                                                                                                                                 
                                                                                                                                                 
                                                                               
                                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                           }];
                                                                           
                                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                           
                                                                           [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                       }];
        }
            break;
        case -4:
        {
            [SVProgressHUD showErrorWithStatus:@"拒绝授权，请使用其他方式登录"];
        }
            break;
        case -2:
        {
            [SVProgressHUD showErrorWithStatus:@"取消授权，请使用其他方式登录"];
        }
            break;
        default:
            break;
    }
}

/** 验证绑定状态*/
- (void)tieTestWith:(UMSocialUserInfoResponse *)resp{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"登录中"];
    
    
    if (!resp.uid) {
        [SVProgressHUD showErrorWithStatus:@"系统信息出错，请重试"];
        return;
    }
    
    
    [ShareBusinessManager.loginManager postLoginElseWithParameters:@{@"certificate":resp.uid,
                                                                     @"type":_type}
                                                           success:^(id responObject) {
                                                               //获取到登录信息
                                                               //登录成功
                                                               [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                               [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               if (errCode == 40033) {
                                                                   [SVProgressHUD dismiss];
                                                                   //该账号未绑定手机号跳转快速绑定页面
                                                                   LoginTieViewController *tieVc = [[LoginTieViewController alloc] init];
                                                                   
                                                                   tieVc.response = resp;
                                                                   tieVc.type = _type;
                                                                   [weakself.navigationController pushViewController:tieVc animated:YES];
                                                               }else{
                                                                   [SVProgressHUD showErrorWithStatus:errorMsg];
                                                               }
                                                           }];
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

- (void)createSegement{
    
    ScrollItem *item_0 = [[ScrollItem alloc] initWithItem_Name:@"  登录     " title_norml_Color:GLOBALCOLOR tile_selected_Color:WHITECOLOR];
    ScrollItem *item_1 = [[ScrollItem alloc] initWithItem_Name:@"  注册     " title_norml_Color:GLOBALCOLOR tile_selected_Color:WHITECOLOR];
    
    _control = [[STL_SegementControl alloc] init];
    _control.delegat = self;
    _control.items = @[item_0, item_1];
    _control.cornerRadius = 15;
    _control.selectionColor = GLOBALCOLOR;
    [_loginView addSubview:_control];
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
        [self createSegement];
        [_loginView addSubview:self.phoneTf];
        [_loginView addSubview:self.lineView];
        [_loginView addSubview:self.passwordTf];
        [_loginView addSubview:self.forgetBtn];
        [_loginView addSubview:self.sendTestBtn];
    }
    return _loginView;
    
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
        _passwordTf.placeholder = @"输入密码";
        _passwordTf.textColor = SHENTEXTCOLOR;
        _passwordTf.font = FONT(16);
        _passwordTf.secureTextEntry = YES;
        _passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTf.returnKeyType = UIReturnKeyDone;
        _passwordTf.delegate = self;
    }
    return _passwordTf;

}

- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = FONT(12);
        [_forgetBtn addTarget:self action:@selector(forgetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
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
        _setPasswordTf.placeholder  = @"设置密码";
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

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundImage:IMAGE(@"classify155") forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIView *)elseLoginView{
    if (!_elseLoginView) {
        _elseLoginView  = [[UIView alloc] init];
        [_elseLoginView addSubview:self.simpleView];
        [_elseLoginView addSubview:self.qqBtn];
        [_elseLoginView addSubview:self.wxBtn];
//        [_elseLoginView addSubview:self.sinaBtn];
    }
    return _elseLoginView;
}

- (UIView *)simpleView{
    if (!_simpleView) {
        _simpleView = [[UIView alloc] init];
        [_simpleView addSubview:self.elseLb];
        [_simpleView addSubview:self.simpleLine_0];
        [_simpleView addSubview:self.simpleLine_1];
    }
    return _simpleView;
}

- (UILabel *)elseLb{
    if (!_elseLb) {
        _elseLb = [[UILabel alloc] init];
        _elseLb.font = FONT(16);
        _elseLb.textColor = WHITECOLOR;
        _elseLb.text = @"第三方账户登录";
    }
    return _elseLb;
}

- (UIView *)simpleLine_0{
    if (!_simpleLine_0) {
        _simpleLine_0   = [[UIView alloc] init];
        _simpleLine_0.backgroundColor = WHITECOLOR;
    }
    return _simpleLine_0;
}

- (UIView *)simpleLine_1{
    if (!_simpleLine_1) {
        _simpleLine_1 = [[UIView alloc] init];
        _simpleLine_1.backgroundColor = WHITECOLOR;
    }
    return _simpleLine_1;
}

- (UIButton *)qqBtn{
    if (!_qqBtn) {
        _qqBtn = [[UIButton alloc] init];
        _qqBtn.tag = 101;
        [_qqBtn setBackgroundColor:WHITECOLOR];
        [_qqBtn setBackgroundImage:IMAGE(@"classify156") forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(elseLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
    
    
}

- (UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [[UIButton alloc] init];
        _wxBtn.tag = 102;
        [_wxBtn setBackgroundColor:WHITECOLOR];
        [_wxBtn setBackgroundImage:IMAGE(@"classify158") forState:UIControlStateNormal];
        [_wxBtn addTarget:self action:@selector(elseLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
    
}

//- (UIButton *)sinaBtn{
//    if (!_sinaBtn) {
//        _sinaBtn = [[UIButton alloc] init];
//        _sinaBtn.tag  = 103;
//        [_sinaBtn setBackgroundColor:WHITECOLOR];
//        [_sinaBtn setBackgroundImage:IMAGE(@"classify157") forState:UIControlStateNormal];
//        [_sinaBtn addTarget:self action:@selector(elseLoginAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _sinaBtn;
//    
//    
//}
@end
