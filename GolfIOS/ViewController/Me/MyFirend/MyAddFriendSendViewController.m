//
//  MyAddFriendSendViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/6.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyAddFriendSendViewController.h"

@interface MyAddFriendSendViewController ()

@property (nonatomic, strong) UILabel *titleLb;

@property (nonatomic, strong) UIView *messageView;

@property (nonatomic, strong) UITextField *messageTf;

@property (nonatomic, strong) UIButton *sendBtn;


@end

@implementation MyAddFriendSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"验证消息";
//    [self.contentView sd_addSubviews:@[self.titleLb, self.messageTf, self.sendBtn]];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.messageView];
    [self.contentView addSubview:self.sendBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.titleLb.sd_layout
    .topSpaceToView(self.contentView, 12)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    
    self.messageView.sd_layout
    .topSpaceToView(self.titleLb, 12)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);

    
    self.messageTf.sd_layout
    .topSpaceToView(self.messageView, 0)
    .leftSpaceToView(self.messageView, 15)
    .rightSpaceToView(self.messageView, 15)
    .heightIs(45);
    
    self.sendBtn.sd_layout
    .topSpaceToView(self.messageView, 40)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(45);
    [self.sendBtn setSd_cornerRadius:@5];
    
}


#pragma mark ----------------发送好友申请

- (void)sendAddFriendMessageAction{
    
    [_messageTf resignFirstResponder];
    
    NSString *text = _messageTf.text;
    
    if (!text.length ||text.length >50 ) {
        [SVProgressHUD showErrorWithStatus:@"输入有误"];
        return;
    }
    
    if (_userPhone == nil) {
        [SVProgressHUD showErrorWithStatus:@"未找到手机号"];
        return;
    }

    [SVProgressHUD showWithStatus:@"发送邀请中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendAddWithParameters:@{@"remark":text,
                                                                      @"userName":_userPhone}
                                                            success:^(id responObject) {
                                                                [SVProgressHUD showSuccessWithStatus:responObject];
                                                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                    [weakself.navigationController popViewControllerAnimated:YES];
                                                                });
                                                            }
                                                            failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                if (errCode == 4009) {
                                                                    [SVProgressHUD showErrorWithStatus:@"该用户暂未注册，快去邀请他吧！"];
                                                                }else{
                                                                    [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                }
                                                            }];

}


#pragma mark ----------------实例化

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(12);
        _titleLb.text = @"发送验证消息";
        _titleLb.textColor = LIGHTTEXTCOLOR;
    }
    return _titleLb;
}

- (UIView *)messageView{
    if (!_messageView) {
        _messageView = [[UIView alloc] init];
        _messageView.backgroundColor = WHITECOLOR;
        [_messageView addSubview:self.messageTf];
    }
    return _messageView;
}

- (UITextField *)messageTf{
    if (!_messageTf) {
        _messageTf = [[UITextField alloc] init];
        _messageTf.font = FONT(14);
        _messageTf.textColor = BLACKTEXTCOLOR;
        _messageTf.placeholder = @"限制50字以内";
        _messageTf.backgroundColor = WHITECOLOR;
        _messageTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _messageTf;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        _sendBtn.backgroundColor = GLOBALCOLOR;
        _sendBtn.titleLabel.font = FONT(14);
        [_sendBtn setTitle:@"加为好友" forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendAddFriendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}


@end
