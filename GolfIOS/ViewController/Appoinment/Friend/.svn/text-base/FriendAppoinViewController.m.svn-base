//
//  FriendAppoinViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "FriendAppoinViewController.h"

@interface FriendAppoinViewController ()
<
    UITextViewDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    UITextFieldDelegate
>
/** 发帖内容*/
@property (nonatomic, strong) UITextView *textTf;
/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 发送按钮*/
@property (nonatomic, strong) UIButton *sendBtn;
/** 输入电话*/
@property (nonatomic, strong) UITextField *phoneTf;


/** 邀约球场信息*/
@property (nonatomic, strong) PlaceItemModel *placeModel;

/** 邀约人信息*/
@property (nonatomic, strong) NSMutableArray *friendGroupAry;//好友分组
@property (nonatomic, strong) NSMutableArray *friendAry;//好友集合






@end

@implementation FriendAppoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"发邀请帖";
    self.contentView.backgroundColor = GRAYCOLOR;
    [self.contentView addSubview:self.textTf];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.sendBtn];
    _sendBtn.enabled = NO;
    [GOLFNotificationCenter addObserver:self selector:@selector(receiveSelectPlaceInfo:) name:FriendSelectInfo object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutContenView];//布局
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self name:FriendSelectInfo object:nil];
}

/** 自动布局*/
- (void)autoLayoutContenView{
    _textTf.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(180);
    
    _tableView.sd_layout
    .topSpaceToView(_textTf, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(155);
    
    _sendBtn.sd_layout
    .bottomSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(40);
    [_sendBtn setSd_cornerRadius:@5];
}

#pragma mark ----------------数据逻辑

- (void)initData{
    _friendGroupAry = [[NSMutableArray alloc] init];
    _friendAry = [[NSMutableArray alloc] init];
}

- (void)updateUI{
    [self.tableView reloadData];
}


#pragma mark ----------------界面逻辑
/** 发送邀请*/
- (void)sendApointAction{
    [SVProgressHUD showSuccessWithStatus:@"发送邀请"];
    NSMutableString *friendsStr = [[NSMutableString alloc] init];
    if (_friendAry.count == 1) {
        FriendUserModel *model = _friendAry.firstObject;
        [friendsStr appendString:model.userId];
    }else{
        for (NSInteger i = 0; i < _friendAry.count; i++) {
            FriendUserModel *model = _friendAry[i];
            [friendsStr appendFormat:@"%@,",model.userId];
        }
    }
    
    
    NSMutableString *friendGroupStr = [[NSMutableString alloc] init];
    if (_friendGroupAry.count == 1) {
        FriendGroupItemModel *model = _friendGroupAry.firstObject;
        [friendGroupStr appendString:model.ID];
    }else{
        for (NSInteger i = 0; i < _friendGroupAry.count; i++) {
            FriendGroupItemModel *model = _friendGroupAry[i];
            [friendsStr appendFormat:@"%@,", model.ID];
        }
    }

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"ballplaceId":_placeModel.ID,
                                                                                  @"content":_textTf.text,
                                                                                  @"contactPhone":_phoneTf.text}];
    if (friendsStr.length) {
        [dict setValue:friendsStr forKey:@"friendId"];
    }
    if (friendGroupStr.length) {
        [dict setValue:friendGroupStr forKey:@"friendsGroupId"];
    }
    
    
    GOLFWeakObj(self);
    [ShareBusinessManager.appointmentFriendManager postAppointmentFriendSendMessageWithParameters:dict
                                                                                          success:^(id responObject) {
                                                                                              [SVProgressHUD dismiss];
                                                                                              FriendAppointmentSendSuccessViewController *sendSuccessVc = [[FriendAppointmentSendSuccessViewController alloc] init];
                                                                                              [weakself.navigationController pushViewController:sendSuccessVc animated:YES];
                                                                                              
                                                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                          }];
}
/** 点击*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
        return;
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //点击选择球场
                GOLFWeakObj(self);
                FriendSelectPlaceViewController *selectPlaceVc = [[FriendSelectPlaceViewController alloc] init];
                selectPlaceVc.block = ^(id responObject){
                    weakself.placeModel = responObject;
                    [weakself isHight];
                    [weakself updateUI];
                };
                [self.navigationController pushViewController:selectPlaceVc animated:YES];
            }
                break;
            case 1:
            {
                //点击选择好友
                GOLFWeakObj(self);
                FriendAppointViewController *friendVc  = [[FriendAppointViewController alloc] init];
                friendVc.friendGroupAry = [[NSMutableArray alloc] initWithArray:_friendGroupAry]
                ;
                friendVc.friendAry = [[NSMutableArray alloc] initWithArray:_friendAry];
                friendVc.selectFriendBlock = ^(NSMutableArray *friendAry, NSMutableArray *friendGroupAry){
                    [weakself.friendAry removeAllObjects];
                    [weakself.friendGroupAry removeAllObjects];
                    [weakself.friendAry addObjectsFromArray:friendAry];
                    [weakself.friendGroupAry addObjectsFromArray:friendGroupAry];
                    [weakself.tableView reloadData];
                    [weakself isHight];
                };
                [self.navigationController pushViewController:friendVc animated:YES];
            }
                break;
            default:
                break;
        }
    }else{
        //填写联系电话
    }

}

/** 搜索结果页通过通知传回来选择球场数据*/
- (void)receiveSelectPlaceInfo:(NSNotification *)fication{
    NSDictionary *dict = fication.userInfo;
    /** 
     @{@"placeItem":model
     */
    _placeModel = dict[@"placeItem"];
    [self isHight];
    [self updateUI];
}

#pragma mark ----------------textView代理textfield

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"快邀请朋友一起打球啦！"]) {
        textView.text = @"";
        textView.textColor = SHENTEXTCOLOR;
    }
    [self isHight];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (!textView.text.length) {
        textView.text = @"快邀请朋友一起打球啦！";
        textView.textColor = LIGHTTEXTCOLOR;
        _sendBtn.enabled = NO;
    }
    [self isHight];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self isHight];
    [self updateUI];
    if ([text isEqualToString:@"\n"]) {
        //收起键盘
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self isHight];
    [self updateUI];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [self isHight];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self isHight];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark ----------------判断满足按钮亮度

- (void)isHight{
    if ((_friendAry.count || _friendGroupAry.count) && ([self.phoneTf.text validateMobile]) && (![_textTf.text isEqualToString:@"快邀请朋友一起打球啦！"]) && _textTf.text.length && _placeModel.name.length) {
        _sendBtn.enabled = YES;
    }
}

#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!section) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"appointCell"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = FONT(14);
    cell.textLabel.textColor = SHENTEXTCOLOR;
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;
    cell.detailTextLabel.font = FONT(12);
    if (!indexPath.section) {
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"选定球场";
                if (_placeModel.name) {
                    cell.imageView.image = IMAGE(@"classify67");
                }else{
                    cell.imageView.image = IMAGE(@"classify63");
                }
                cell.detailTextLabel.text = _placeModel.name;
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"邀请好友";
                NSMutableString *str = [[NSMutableString alloc] init];
                for (FriendGroupItemModel *model in _friendGroupAry) {
                    [str appendFormat:@"%@,",model.groupName];
                }
                for (FriendUserModel *model in _friendAry) {
                    [str appendFormat:@"%@,",model.nickName];
                }
                cell.detailTextLabel.text = str;
                
                if (str.length) {
                    cell.imageView.image = IMAGE(@"classify68");
                }else{
                    cell.imageView.image = IMAGE(@"classify64");
                }
            }
                break;
            default:
                break;
        }
    }else{
        cell.textLabel.text = @"联系电话";
        cell.accessoryView = self.phoneTf;
        if ([self.phoneTf.text validateMobile]) {
            cell.imageView.image = IMAGE(@"classify69");
        }else{
            cell.imageView.image = IMAGE(@"classify65");
        }
    }
    return cell;

}

#pragma mark ----------------实例化

- (UITextView *)textTf{
    if (!_textTf) {
        _textTf = [[UITextView alloc] init];
        _textTf.textColor = LIGHTTEXTCOLOR;
        _textTf.returnKeyType = UIReturnKeyDone;
        _textTf.text = @"快邀请朋友一起打球啦！";
        _textTf.font = FONT(14);
        _textTf.delegate = self;
    }
    return _textTf;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"appointCell"];
    }
    return _tableView;
}

- (UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc] init];
        _sendBtn.backgroundColor = LIGHTTEXTCOLOR;
        [_sendBtn setTitle:@"发送邀请" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_sendBtn setBackgroundImage:IMAGE(@"classify-5") forState:UIControlStateNormal];
        [_sendBtn setBackgroundImage:IMAGE(@"classify-6") forState:UIControlStateDisabled];
        _sendBtn.titleLabel.font = FONT(14);
        [_sendBtn addTarget:self action:@selector(sendApointAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UITextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
        _phoneTf.font = FONT(12);
        _phoneTf.textAlignment = NSTextAlignmentRight;
        _phoneTf.clearButtonMode  = UITextFieldViewModeWhileEditing;
        _phoneTf.placeholder = @"选填";
        _phoneTf.delegate = self;
        _phoneTf.textColor = SHENTEXTCOLOR;
        _phoneTf.returnKeyType = UIReturnKeyDone;
    }
    return _phoneTf;

}

@end
