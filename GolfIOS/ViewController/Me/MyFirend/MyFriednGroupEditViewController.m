//
//  MyFriednGroupEditViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriednGroupEditViewController.h"

@interface MyFriednGroupEditViewController ()
<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
/** 取消按钮*/
@property (nonatomic, strong) UIButton *cancelBtn;
/** 确定按钮*/
@property (nonatomic, strong) UIButton *sureBtn;
/** 组名*/
@property (nonatomic, strong) UILabel *groupNameLb;
/** 组名输入*/
@property (nonatomic, strong) UIView *groupView;
@property (nonatomic, strong) UITextField *groupTf;

/** 组员*/
@property (nonatomic, strong) UILabel *itemsLb;
/** 头部视图*/
@property (nonatomic, strong) UIView *topView;
/** 图标*/
@property (nonatomic, strong) UIImageView *addIv;
/** 标题*/
@property (nonatomic, strong) UILabel *addLb;


/** 列表页*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *titleData;
//所有数据(当前分组数据)
@property (nonatomic, strong) NSMutableArray *listData;

@end

@implementation MyFriednGroupEditViewController

- (instancetype)initWithModel:(FriendGroupItemModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"分组";
    [self customNavi];
    [self.contentView sd_addSubviews:@[self.groupNameLb,
                                       self.groupView,
                                       self.itemsLb,
                                       self.topView,
                                       self.tableView]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _groupNameLb.sd_layout
    .topSpaceToView(self.contentView, 12)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    
    _groupView.sd_layout
    .topSpaceToView(_groupNameLb, 12)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _groupTf.sd_layout
    .centerYEqualToView(_groupView)
    .leftSpaceToView(_groupView, 15)
    .rightSpaceToView(_groupView, 0)
    .heightIs(45);
    
    _itemsLb.sd_layout
    .topSpaceToView(_groupView, 12)
    .leftEqualToView(_groupNameLb)
    .rightEqualToView(_groupNameLb)
    .heightIs(12);
    
    _topView.sd_layout
    .topSpaceToView(_itemsLb, 12)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    
    _addIv.sd_layout
    .centerYEqualToView(_topView)
    .leftSpaceToView(_topView, 15)
    .heightIs(20)
    .widthEqualToHeight();
    
    _addLb.sd_layout
    .centerYEqualToView(_topView)
    .leftSpaceToView(_addIv, 10)
    .rightSpaceToView(_topView, 15)
    .autoHeightRatio(0);
    
    _tableView.sd_layout
    .topSpaceToView(_topView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(_listData.count *60 + _titleData.count *27);
    [self.contentView setupAutoContentSizeWithBottomView:_tableView bottomMargin:10];
    
}


- (void)customNavi{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.cancelBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.sureBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [_sureBtn setEnabled:NO];
}

#pragma mark ----------------数据处理
- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _titleData = [[NSMutableArray alloc] init];
    _listData = [[NSMutableArray alloc] init];
    
    //根据传入进来的分组数据更新当前页面
    if (self.model) {
        NSArray * responObject = _model.groupMemberList;
        [_listData addObjectsFromArray:responObject];
        //第一步摘出没有昵称的用户放到#数组里
        NSMutableArray *ary = [[NSMutableArray alloc] init];
        NSMutableArray *ary_no = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < responObject.count; i++) {
            FriendUserModel *itemModel = responObject[i];
            if ([itemModel.nickName length]) {
                [ary addObject:itemModel];
            }else{
                [ary_no addObject:itemModel];
            }
        }
        //第二步对剩下用户进行排序
        NSMutableArray *data = [BMChineseSort sortObjectArray:ary Key:@"nickName"];
        NSMutableArray *titleData = [BMChineseSort IndexWithArray:ary Key:@"nickName"];
        if (ary_no.count) {
            [data addObject:ary_no];
            [titleData addObject:@"#"];
        }
        //第三步刷新列表
        [_data addObjectsFromArray:data];
        [_titleData addObjectsFromArray:titleData];
        self.groupTf.text = self.model.groupName;
    }
}


#pragma mark ----------------界面逻辑
/** 取消按钮*/
- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/** 确定按钮*/
- (void)sureAction{
    NSMutableString *friendsId = [[NSMutableString alloc] init];
    [SVProgressHUD showWithStatus:@"修改中"];
    
    if (_listData.count == 1) {
        FriendUserModel *model = _listData.firstObject;
        [friendsId appendString:model.userId];
    }else{
        for (NSInteger i = 0; i < _listData.count; i++) {
            FriendUserModel *model = _listData[i];
            if (i != _listData.count - 1) {
                [friendsId appendFormat:@"%@,", model.userId];
            }else{
                [friendsId appendFormat:@"%@",model.userId];
            }
        }
    }
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:_model.ID forKey:@"groupId"];
    [dict setValue:_groupTf.text forKey:@"groupName"];
    if (friendsId.length) {
        [dict setValue:friendsId forKey:@"friendIds"];
    }
    
    
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"提交修改中"];
    
    [ShareBusinessManager.userManager postMyFriendEditGroupInfoWithParameters:dict
                                                                      success:^(id responObject) {
                                                                          [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
                                                                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                              [GOLFNotificationCenter postNotificationName:@"updateFriendGroupList" object:nil];//发送通知刷新分组好友界面
                                                                              [weakself.navigationController popViewControllerAnimated:YES];
                                                                          });
                                                                      } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                          [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                      }];

    
}
/** 添加组员*/
- (void)addGroupAction{
    [_groupTf resignFirstResponder];
    GOLFWeakObj(self);
    MyFriendAddGroupViewController *addVc = [[MyFriendAddGroupViewController alloc] init];
    addVc.selectedData = [NSMutableArray arrayWithArray:_listData];
    addVc.block = ^(id responObject){
        NSArray *ary = responObject;
        if (ary.count) {
            _sureBtn.enabled = YES;
        }
        [weakself sortNameWithAry:responObject];
    };
    [self.navigationController pushViewController:addVc animated:YES];
}
/** 数据处理好友排序*/
- (void)sortNameWithAry:(NSArray *)responObject{
    [_listData addObjectsFromArray:responObject];
    //第一步摘出没有昵称的用户放到#数组里
    NSMutableArray *ary = [[NSMutableArray alloc] init];
    NSMutableArray *ary_no = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < responObject.count; i++) {
        FriendUserModel *itemModel = responObject[i];
        if ([itemModel.nickName length]) {
            [ary addObject:itemModel];
        }else{
            [ary_no addObject:itemModel];
        }
    }
    //第二步对剩下用户进行排序
    NSMutableArray *data = [BMChineseSort sortObjectArray:ary Key:@"nickName"];
    NSMutableArray *titleData = [BMChineseSort IndexWithArray:ary Key:@"nickName"];
    if (ary_no.count) {
        [data addObject:ary_no];
        [titleData addObject:@"#"];
    }
    //第三步刷新列表
    [_data addObjectsFromArray:data];
    [_titleData addObjectsFromArray:titleData];
    
    _tableView.sd_layout
    .heightIs(_listData.count *60 + _titleData.count *27);
    
    [self.tableView reloadData];
}


#pragma mark ----------------文本输入代理

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= 19) {
        [SVProgressHUD showErrorWithStatus:@"超过限制长度"];
        return NO;
    }else{
        _sureBtn.enabled = YES;
        return YES;
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    _sureBtn.enabled = NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        _sureBtn.enabled = NO;
    }else if ([textField.text isEqualToString:_model.groupName]){
        _sureBtn.enabled = NO;
    }
}

#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_data[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    UILabel *lv = [[UILabel alloc] init];
    lv.font = FONT(10);
    lv.textColor = BLACKTEXTCOLOR;
    lv.text = _titleData[section];
    [view addSubview:lv];
    lv.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .autoHeightRatio(0);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MyFriendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    FriendUserModel *itemModel = _data[indexPath.section][indexPath.row];
    cell.model = itemModel;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _titleData;
}



#pragma mark ----------------左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
    FriendUserModel *itemModel = _data[indexPath.section][indexPath.row];
    [_listData removeObject:itemModel];
    _sureBtn.enabled = YES;
    
    GOLFWeakObj(self);
    NSMutableArray *ary = weakself.data[indexPath.section];
    [ary removeObjectAtIndex:indexPath.row];
    
    if (!ary.count) {
        [weakself.data removeObjectAtIndex:indexPath.section ];
        [weakself.titleData removeObjectAtIndex:indexPath.section ];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        [weakself.data replaceObjectAtIndex:indexPath.section withObject:ary];
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


#pragma mark ----------------实例

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _cancelBtn.titleLabel.font = FONT(14);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _sureBtn.titleLabel.font = FONT(14);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:RGBColor(194, 223, 199) forState:UIControlStateDisabled];
        [_sureBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = WHITECOLOR;
        [_topView addSubview:self.addIv];
        [_topView addSubview:self.addLb];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGroupAction)];
        [_topView addGestureRecognizer:tap];
    }
    return _topView;
}

- (UIImageView *)addIv{
    if (!_addIv) {
        _addIv = [[UIImageView alloc] init];
        _addIv.image = IMAGE(@"classify70");
    }
    return _addIv;
}

- (UILabel *)addLb{
    if (!_addLb) {
        _addLb = [[UILabel alloc] init];
        _addLb.font = FONT(14);
        _addLb.textColor = GLOBALCOLOR;
        _addLb.text = @"添加成员";
    }
    return _addLb;
}

- (UILabel *)groupNameLb{
    if (!_groupNameLb) {
        _groupNameLb = [[UILabel alloc] init];
        _groupNameLb.font = FONT(12);
        _groupNameLb.text = @"组名";
        _groupNameLb.textColor = LIGHTTEXTCOLOR;
    }
    return _groupNameLb;
}

- (UIView *)groupView{
    if (!_groupView) {
        _groupView = [[UIView alloc] init];
        _groupView.backgroundColor = WHITECOLOR;
        [_groupView addSubview:self.groupTf];
    }
    return _groupView;
}

- (UITextField *)groupTf{
    if (!_groupTf) {
        _groupTf = [[UITextField alloc] init];
        _groupTf.font = FONT(14);
        _groupTf.textColor = SHENTEXTCOLOR;
        _groupTf.placeholder = @"未设置分组名称（限制20字以内）";
        _groupTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _groupTf.delegate = self;
    }
    return _groupTf;
}

- (UILabel *)itemsLb{
    if (!_itemsLb) {
        _itemsLb = [[UILabel alloc] init];
        _itemsLb.font = FONT(12);
        _itemsLb.textColor = LIGHTTEXTCOLOR;
        _itemsLb.text = @"组员（0）";
    }
    return _itemsLb;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.sectionIndexColor = LIGHTTEXTCOLOR;
        [_tableView registerClass:[MyFriendUserTableViewCell class] forCellReuseIdentifier:@"friendCell"];
    }
    return _tableView;
}

@end
