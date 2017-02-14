//
//  FriendAppointViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/23.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FriendAppointViewController.h"
#import "AppointmentFriendResultTableViewCell.h"


@interface FriendAppointViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
/** 头部视图*/
@property (nonatomic, strong) UIView *topView;
/** 图标*/
@property (nonatomic, strong) UIImageView *addIv;
/** 标题*/
@property (nonatomic, strong) UILabel *addLb;




/** 分组列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;

/** 底部全选视图*/
@property (nonatomic, strong) UIView *allSelectView;
/** 按钮*/
@property (nonatomic, strong) UIButton *allSelectBtn;
/** 全选标题*/
@property (nonatomic, strong) UILabel *allSelectLb;
/** 确定*/
@property (nonatomic, strong) UIButton *doneBtn;




@end

@implementation FriendAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"邀请好友";
    self.isAutoBack = NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allSelectView];
    [self loadData];//刷新分组
    [GOLFNotificationCenter addObserver:self selector:@selector(loadData) name:@"updateFriendGroupList" object:nil];
    [GOLFNotificationCenter addObserver:self selector:@selector(changeSelectInfo) name:@"changeSelectInfo" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topView.sd_layout
    .topSpaceToView(self.view, NaviBar_HEIGHT)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(45);
    
    
    _allSelectView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(45);
    
    _tableView.sd_layout
    .topSpaceToView(_topView, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.allSelectView, 0);

    
    _allSelectBtn.sd_layout
    .centerYEqualToView(_allSelectView)
    .leftSpaceToView(_allSelectView, 15)
    .heightIs(20)
    .widthIs(20);
    
    _allSelectLb.sd_layout
    .centerYEqualToView(_allSelectBtn)
    .leftSpaceToView(_allSelectBtn, 5)
    .autoHeightRatio(0);
    [_allSelectLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _doneBtn.sd_layout
    .centerYEqualToView(_allSelectBtn)
    .rightSpaceToView(_allSelectView, 0)
    .heightRatioToView(_allSelectView, 1)
    .widthIs(145);

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
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"努力加载中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendGroupWithParameters:nil success:^(id responObject) {
        [SVProgressHUD dismiss];
        [weakself.data removeAllObjects];
        [weakself.data addObjectsFromArray:responObject];
        for (NSInteger i = 0; i <weakself.data.count; i++) {
            FriendGroupItemModel *model = weakself.data[i];
            for (FriendGroupItemModel *selectItemModel in weakself.friendGroupAry) {
                if ([selectItemModel.ID isEqualToString:model.ID]) {
                    model.isSelect = YES;
                }
            }
        }
        [weakself.tableView reloadData];
        [weakself changeSelectInfo];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
}

- (void)changeSelectInfo{
    
    
    _allSelectBtn.selected = YES;
    
    if (!_data.count) {
        _allSelectBtn.selected = NO;
    }
    for (FriendGroupItemModel *model in _data) {
        if (!model.isSelect) {
            _allSelectBtn.selected = NO;
        }
    }
}

#pragma mark ----------------界面逻辑
/** 创建分组*/
- (void)addGroupAction{
    MyFriendCreateGroupViewController *addVc = [[MyFriendCreateGroupViewController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
}
/** 编辑分组*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _data.count) {
//        GOLFWeakObj(self);
//        MyFriendAddGroupViewController *addVc = [[MyFriendAddGroupViewController alloc] init];
//        addVc.selectedData = [[NSMutableArray alloc] initWithArray:_friendAry];
//        addVc.block = ^(id responObject){
//            [weakself.friendAry removeAllObjects];
//            [weakself.friendAry addObjectsFromArray:responObject];
//            [weakself.tableView reloadData];
//        };
//        [self.navigationController pushViewController:addVc animated:YES];
        return;
    }
    
    MyFriednGroupEditViewController *editVc = [[MyFriednGroupEditViewController alloc] initWithModel:_data[indexPath.section]];
    [self.navigationController pushViewController:editVc animated:YES];

}
/** 全选动作*/
- (void)allSelectAction:(UIButton *)btn{
    btn.selected = ! btn.isSelected;
    [GOLFNotificationCenter postNotificationName:@"allSelect" object:nil userInfo:@{@"allSelect":[NSNumber numberWithBool:btn.selected]}];
    if (btn.isSelected) {
        //把所有分组数据改变
        for (FriendGroupItemModel *itemModel in _data) {
            itemModel.isSelect = YES;
        }
    }else{
        //移除所有
        for (FriendGroupItemModel *itemModel in _data) {
            itemModel.isSelect = NO;
        }
    }
}
/** 确定动作*/
- (void)doneSelectAction{
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (FriendGroupItemModel *itemModel in _data) {
        if (itemModel.isSelect) {
            [data addObject:itemModel];
        }
    }
    
    if (_selectFriendBlock) {
        _selectFriendBlock(_friendAry, data);
    }
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"提交修改中"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [weakself.navigationController popViewControllerAnimated:YES];
    });
}
/** 进入选择好友界面*/
- (void)intoSelectFriend{
    GOLFWeakObj(self);
    MyFriendAddGroupViewController *addVc = [[MyFriendAddGroupViewController alloc] init];
    addVc.selectedData = [[NSMutableArray alloc] initWithArray:_friendAry];
    addVc.block = ^(id responObject){
        [weakself.friendAry removeAllObjects];
        [weakself.friendAry addObjectsFromArray:responObject];
        [weakself.tableView reloadData];
    };
    [self.navigationController pushViewController:addVc animated:YES];
}

#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == _data.count) {
        return _friendAry.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == _data.count) {
        return 55;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _data.count) {
        return 70;
    }
    return 68;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == _data.count) {
        UIView *backView = [[UIView alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
        view.backgroundColor = WHITECOLOR;
        [backView addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(intoSelectFriend)];
        [view addGestureRecognizer:tap];
        
        UIImageView *img = [[UIImageView alloc] init];
        img.image = IMAGE(@"classify73");
        [view addSubview:img];
        
        
        img.sd_layout
        .leftSpaceToView(view, 15)
        .centerYEqualToView(view)
        .heightIs(21)
        .widthEqualToHeight();
        
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.font = FONT(14);
        titleLb.textColor = BLACKTEXTCOLOR;
        titleLb.text = @"选择好友";
        [view addSubview:titleLb];
        titleLb.sd_layout
        .centerYEqualToView(view)
        .leftSpaceToView(img, 20)
        .autoHeightRatio(0);
        [titleLb setSingleLineAutoResizeWithMaxWidth:300];
        
        UIImageView *rightImg = [[UIImageView alloc] init];
        rightImg.image = IMAGE(@"classify8");
        [view addSubview:rightImg];
        
        rightImg.sd_layout
        .rightSpaceToView(view, 15)
        .centerYEqualToView(view)
        .heightIs(12.5)
        .widthIs(7);
        
        return backView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == _data.count) {
        //选择好友
        AppointmentFriendResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
        
        cell.model = _friendAry[indexPath.row];
        return cell;
    }
    
    FirendInviteGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupInviteCell"];
    FriendGroupItemModel *model = _data[indexPath.section];
    cell.model = model;
    return cell;
}


#pragma mark ----------------左滑删除好友

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
//    FriendUserModel *itemModel = _data[indexPath.section - 1][indexPath.row];
    FriendUserModel *itemModel = _friendAry[indexPath.row];
    [_friendAry removeObject:itemModel];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  =  UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FirendInviteGroupTableViewCell class] forCellReuseIdentifier:@"groupInviteCell"];
        [_tableView registerClass:[AppointmentFriendResultTableViewCell class] forCellReuseIdentifier:@"friendCell"];
    }
    return _tableView;
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
        _addLb.text = @"创建分组";
    }
    return _addLb;
}

- (UIView *)allSelectView{
    if (!_allSelectView) {
        _allSelectView  = [[UIView alloc] init];
        _allSelectView.backgroundColor = WHITECOLOR;
        [_allSelectView sd_addSubviews:@[self.allSelectBtn, self.doneBtn, self.allSelectLb]];
    }
    return _allSelectView;
}

- (UIButton *)allSelectBtn{
    if (!_allSelectBtn) {
        _allSelectBtn = [[UIButton alloc] init];
        [_allSelectBtn setBackgroundImage:IMAGE(@"classify71") forState:UIControlStateNormal];
        [_allSelectBtn setBackgroundImage:IMAGE(@"classify72") forState:UIControlStateSelected];
        [_allSelectBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}

- (UILabel *)allSelectLb{
    if (!_allSelectLb) {
        _allSelectLb = [[UILabel alloc] init];
        _allSelectLb.font = FONT(16);
        _allSelectLb.textColor = BLACKTEXTCOLOR;
        _allSelectLb.text = @"全选";
    }
    return _allSelectLb;
}

- (UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc] init];
        _doneBtn.backgroundColor = GLOBALCOLOR;
        _doneBtn.titleLabel.font = FONT(16);
        [_doneBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(doneSelectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@end
