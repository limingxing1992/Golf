//
//  UserEditInfoViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UserEditInfoViewController.h"

@interface UserEditInfoViewController ()
<
    UITextFieldDelegate
>
/** 修改昵称的输入框*/
@property (nonatomic, strong) STL_TextField *nameTf;
/** 保存按钮*/
@property (nonatomic, strong) UIButton *sumbitBtn;

/** 修改密码界面*/
/** 当前密码*/
@property (nonatomic, strong) STL_TextField *oldPasswordTf;
/** 新密码*/
@property (nonatomic, strong) STL_TextField *newPasswordnameTf;
/** 确认新密码*/
@property (nonatomic, strong) STL_TextField *newSurePasswordnameTf;


@end

@implementation UserEditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_infoStyle == 0) {
        self.name = @"修改昵称";
        [self autoLayouNameInfoViews];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:self.sumbitBtn];
        self.navigationItem.rightBarButtonItem = btn;

    }else if (_infoStyle == 1){
        self.name = @"修改密码";
        [self autoLayouPassWordInfoViews];
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:self.sumbitBtn];
        self.navigationItem.rightBarButtonItem = btn;
    }

    self.sumbitBtn.enabled = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------输入代理

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.nameTf) {
        if (![textField.text isEqualToString:[UserModel sharedUserModel].nickName] && textField.text.length) {
            self.sumbitBtn.enabled = YES;
        }
    }else{
        NSString *str = [NSString stringWithFormat:@"%@%@",_newSurePasswordnameTf.text, string];
        if (_oldPasswordTf.text.length && _newPasswordnameTf.text.length && _newSurePasswordnameTf.text.length && [_newPasswordnameTf.text isEqualToString:str]) {
            self.sumbitBtn.enabled = YES;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark ----------------界面布局
/** 布局昵称修改界面*/
- (void)autoLayouNameInfoViews{
    [self.contentView addSubview:self.nameTf];
    self.nameTf.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(50);
    
}
/** 布局密码修改界面*/
- (void)autoLayouPassWordInfoViews{
    [self.contentView addSubview:self.oldPasswordTf];
    [self.contentView addSubview:self.newPasswordnameTf];
    [self.contentView addSubview:self.newSurePasswordnameTf];
    
    self.oldPasswordTf.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(50);
    
    
    self.newPasswordnameTf.sd_layout
    .topSpaceToView(self.oldPasswordTf, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(50);
    
    self.newSurePasswordnameTf.sd_layout
    .topSpaceToView(self.newPasswordnameTf, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(50);
    
}



#pragma mark ----------------界面逻辑
/** 保存修改*/
- (void)right_0_action{
    
    GOLFWeakObj(self);
    [self.view endEditing:YES];
    
    if (_infoStyle == 0) {
        //修改昵称
        [ShareBusinessManager.loginManager postEditUserInfoWithParameters:@{@"nickName":_nameTf.text}
                                                                  success:^(id responObject) {
                                                                      [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                                                                      [GOLFNotificationCenter postNotificationName:UserInfoUpdate object:nil];
                                                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                          [weakself.navigationController popViewControllerAnimated:YES];
                                                                      });
                                                                      
                                                                  } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                      [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                  }];
    }else if (_infoStyle == 1){
        //修改密码
        [ShareBusinessManager.loginManager postEditUserInfoWithParameters:@{@"oldPassword":_oldPasswordTf.text,
                                                                            @"newPassword":_newPasswordnameTf.text}
                                                                  success:^(id responObject) {
                                                                      
                                                                      [[UserModel sharedUserModel] setIsLogin:NO];
                                                                      [UserModel attempDealloc];//清除
                                                                      [GOLFUserDefault removeObjectForKey:@"userInfo"];//清除用户资料缓存
                                                                      [SVProgressHUD showSuccessWithStatus:@"修改成功，请重新登录"];
                                                                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                          [weakself.navigationController popToRootViewControllerAnimated:NO];
//                                                                          [weakself presentViewController:LoginNavi animated:YES completion:nil];;
                                                                      });
                                                                      
                                                                  } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                      [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                  }];
    }
}

#pragma mark ----------------实例

- (UIButton *)sumbitBtn{
    if (!_sumbitBtn) {
        _sumbitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _sumbitBtn.titleLabel.font = FONT(14);
        [_sumbitBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_sumbitBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_sumbitBtn setTitleColor:GRAYCOLOR forState:UIControlStateDisabled];
        [_sumbitBtn addTarget:self action:@selector(right_0_action) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumbitBtn;
}

- (STL_TextField *)nameTf{
    if (!_nameTf) {
        _nameTf = [[STL_TextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _nameTf.text = [UserModel sharedUserModel].nickName;
        _nameTf.delegate = self;
    }
    return _nameTf;
}

- (STL_TextField *)oldPasswordTf{
    if (!_oldPasswordTf) {
        _oldPasswordTf = [[STL_TextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _oldPasswordTf.placeholder = @"当前密码";
        _oldPasswordTf.delegate = self;
    }
    return _oldPasswordTf;
}

- (STL_TextField *)newPasswordnameTf{
    if (!_newPasswordnameTf) {
        _newPasswordnameTf = [[STL_TextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _newPasswordnameTf.placeholder = @"新密码";
        _newPasswordnameTf.delegate = self;
    }
    return _newPasswordnameTf;
}

- (STL_TextField *)newSurePasswordnameTf{
    if (!_newSurePasswordnameTf) {
        _newSurePasswordnameTf = [[STL_TextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _newSurePasswordnameTf.placeholder = @"确认密码";
        _newSurePasswordnameTf.delegate = self;
    }
    return _newSurePasswordnameTf;
}

@end
