//
//  LoginTieViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "LoginTieViewController.h"

@interface LoginTieViewController ()<UITextFieldDelegate>
/** 提示语*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 手机号输入框*/
@property (nonatomic, strong) UITextField *phoneTf;
/** 下划线1*/
@property (nonatomic, strong) UIView *lineView_0;
/** 验证码输入框*/
@property (nonatomic, strong) UITextField *testWordTf;
/** 下划线2*/
@property (nonatomic, strong) UIView *lineView_1;
/** 密码输入框*/
@property (nonatomic, strong) UITextField *passwordTf;
/** 下划线*/
@property (nonatomic, strong) UIView *lineView_2;
/** 发送验证码按钮*/
@property (nonatomic, strong) JKCountDownButton *sendTestBtn;

/** 绑定按钮*/
@property (nonatomic, strong) UIButton *tieBtn;







@end

@implementation LoginTieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"快速绑定";
    [self.contentView sd_addSubviews:@[self.noticeLb, self.phoneTf, self.lineView_0, self.testWordTf, self.lineView_1,
                                       self.passwordTf, self.passwordTf,self.lineView_2,
                                       self.sendTestBtn, self.tieBtn]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubviews];
}


#pragma mark ----------------布局

- (void)autoLayoutSubviews{
    _noticeLb.sd_layout
    .topSpaceToView(self.contentView, 42.5)
    .leftSpaceToView(self.contentView, 50)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(14);
    
    _phoneTf.sd_layout
    .topSpaceToView(_noticeLb, 33.5)
    .leftEqualToView(_noticeLb)
    .rightSpaceToView(self.contentView, 50)
    .heightIs(14);
    
    _lineView_0.sd_layout
    .topSpaceToView(_phoneTf, 15)
    .leftEqualToView(_phoneTf)
    .rightEqualToView(_phoneTf)
    .heightIs(0.5);
    
    _sendTestBtn.sd_layout
    .topSpaceToView(_lineView_0, 14)
    .rightEqualToView(_lineView_0)
    .heightIs(30);
    [_sendTestBtn setupAutoSizeWithHorizontalPadding:3 buttonHeight:30];
    
    _testWordTf.sd_layout
    .centerYEqualToView(_sendTestBtn)
    .leftEqualToView(_lineView_0)
    .rightSpaceToView(_sendTestBtn,0)
    .heightIs(14);
    
    _lineView_1.sd_layout
    .topSpaceToView(_testWordTf, 15)
    .leftEqualToView(_testWordTf)
    .rightEqualToView(_lineView_0)
    .heightIs(0.5);
    
    _passwordTf.sd_layout
    .topSpaceToView(_lineView_1, 15)
    .leftEqualToView(_lineView_1)
    .rightEqualToView(_lineView_1)
    .heightIs(14);
    
    _lineView_2.sd_layout
    .topSpaceToView(_passwordTf, 15)
    .leftEqualToView(_passwordTf)
    .rightEqualToView(_passwordTf)
    .heightIs(0.5);
    
    _tieBtn.sd_layout
    .topSpaceToView(_lineView_2, 50)
    .leftSpaceToView(self.contentView, 65)
    .rightSpaceToView(self.contentView, 65)
    .heightIs(50 *KHeight_Scale);
    [_tieBtn setSd_cornerRadiusFromHeightRatio:@0.5];
    
    [self.contentView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 80)];
    
}

#pragma mark ----------------界面逻辑

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
/** 放弃输入*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
/** 绑定*/
- (void)tieAction{
    [self.view endEditing:YES];
    if (![self isFitLoginAccess]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号码或输入密码"];
        return ;
    }
    /** 
     certificate	第三方凭证	string
     headUrl	头像	string
     nickName	昵称
     password	密码	string
     regCode	验证码	string
     type	登录方式	number	10-微信，20-QQ，30-微博
     userName	手机号	string
     */
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"绑定中"];
    
    [ShareBusinessManager.loginManager postTieUserInfoWithParameters:@{@"certificate":_response.uid,
                                                                     @"type":_type,
                                                                     @"headUrl":_response.iconurl,
                                                                     @"nickName":_response.name,
                                                                     @"regCode":_testWordTf.text,
                                                                     @"password":[_passwordTf.text MD5Hash],
                                                                     @"userName":_phoneTf.text}
                                                           success:^(id responObject) {
                                                               
                                                               //绑定成功
                                                               [ShareBusinessManager.loginManager postLoginElseWithParameters:@{@"certificate":_response.uid,
                                                                                                                                @"type":_type} success:^(id responObject) {
                                                                                                                                    //获取到登录信息
                                                                                                                                    //登录成功
                                                                                                                                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                                                                                                    [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                               } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                   
                                                                   [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                   
                                                               }];
                                                               
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               
                                                               if (errCode == 206) {
                                                                   //确认提示语
                                                                   [STL_CommonIdea alertWithTarget:self Title:errorMsg message:nil action_0:@"取消" action_1:@"确认" block_0:^{
                                                                       [weakself dismissViewControllerAnimated:YES completion:nil];
                                                                   } block_1:^{
                                                                       [SVProgressHUD show];
                                                                       [ShareBusinessManager.loginManager postTieUserInfoWithParameters:@{@"certificate":_response.uid,
                                                                                                                                          @"type":_type,
                                                                                                                                          @"headUrl":_response.iconurl,
                                                                                                                                          @"nickName":_response.name,
                                                                                                                                          @"regCode":_testWordTf.text,
                                                                                                                                          @"password":[_passwordTf.text MD5Hash],
                                                                                                                                          @"userName":_phoneTf.text,
                                                                                                                                          @"handleFlag":@1}
                                                                                                                                success:^(id responObject) {
                                                                                                                                    //绑定成功
                                                                                                                                    [ShareBusinessManager.loginManager postLoginElseWithParameters:@{@"certificate":_response.uid,
                                                                                                                                                                                                     @"type":_type} success:^(id responObject) {
                                                                                                                                                                                                         //获取到登录信息
                                                                                                                                                                                                         //登录成功
                                                                                                                                                                                                         [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                                                                                                                                                                                                         [weakself.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                                                                                                                                                                     } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                                                                                                                                         [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                                                                                                                                     }];
                                                                                                                                    

                                                                                                                                }
                                                                                                                                failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                                                                    [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                                                                }];
                                                                   }];
                                                               }else{
                                                                   [SVProgressHUD showErrorWithStatus:errorMsg];
                                                               }
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
    
    if (!_testWordTf.text.length) {
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

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(14);
        _noticeLb.textColor = GLOBALCOLOR;
        _noticeLb.text = @"首次授权请绑定手机号";
    }
    return _noticeLb;
}

- (UITextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] init];
        _phoneTf.font = FONT(14);
        _phoneTf.textColor = BLACKTEXTCOLOR;
        _phoneTf.placeholder = @"手机号";
        _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTf.delegate = self;
        _phoneTf.returnKeyType = UIReturnKeyDone;
    }
    return _phoneTf;
}

- (UIView *)lineView_0{
    if (!_lineView_0) {
        _lineView_0 = [[UIView alloc] init];
        _lineView_0.backgroundColor = GRAYCOLOR;
    }
    return _lineView_0;
}

- (UITextField *)testWordTf{
    if (!_testWordTf) {
        _testWordTf = [[UITextField alloc] init];
        _testWordTf.font = FONT(14);
        _testWordTf.textColor = BLACKTEXTCOLOR;
        _testWordTf.placeholder = @"验证码";
        _testWordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _testWordTf.delegate = self;
        _testWordTf.returnKeyType = UIReturnKeyDone;

    }
    return _testWordTf;
}

- (UIView *)lineView_1{
    if (!_lineView_1) {
        _lineView_1 = [[UIView alloc] init];
        _lineView_1.backgroundColor = GRAYCOLOR;
    }
    return _lineView_1;
}

- (UITextField *)passwordTf{
    if (!_passwordTf) {
        _passwordTf = [[UITextField alloc] init];
        _passwordTf.font = FONT(14);
        _passwordTf.textColor = BLACKTEXTCOLOR;
        _passwordTf.placeholder = @"密码";
        _passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTf.delegate = self;
        _passwordTf.returnKeyType = UIReturnKeyDone;

    }
    return _passwordTf;
}

- (UIView *)lineView_2{
    if (!_lineView_2) {
        _lineView_2 = [[UIView alloc] init];
        _lineView_2.backgroundColor = GRAYCOLOR;
    }
    return _lineView_2;
}

- (UIButton *)tieBtn{
    if (!_tieBtn) {
        _tieBtn = [[UIButton alloc] init];
        [_tieBtn setBackgroundColor:GLOBALCOLOR];
        _tieBtn.titleLabel.font = FONT(14);
        [_tieBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_tieBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_tieBtn addTarget:self action:@selector(tieAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tieBtn;
}
@end
