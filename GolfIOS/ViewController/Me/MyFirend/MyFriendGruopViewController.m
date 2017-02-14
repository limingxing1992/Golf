//
//  MyFriendGruopViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/21.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendGruopViewController.h"
#import "StitchingImage.h"


@interface MyFriendGruopViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
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


@end

@implementation MyFriendGruopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"好友分组";
    self.isAutoBack = NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self loadData];//刷新数据
    [GOLFNotificationCenter addObserver:self selector:@selector(loadData) name:@"updateFriendGroupList" object:nil];
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
    
    _tableView.sd_layout
    .topSpaceToView(_topView, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
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
        [weakself.tableView reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark ----------------界面逻辑
/** 创建分组*/
- (void)addGroupAction{
    MyFriendCreateGroupViewController *addVc = [[MyFriendCreateGroupViewController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
}
/** 编辑分组*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFriednGroupEditViewController *editVc = [[MyFriednGroupEditViewController alloc] initWithModel:_data[indexPath.section]];
    [self.navigationController pushViewController:editVc animated:YES];
}

#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFriendGroupTableViewCell *cell = [[MyFriendGroupTableViewCell alloc] init];
    FriendGroupItemModel *model = _data[indexPath.section];
    cell.model = model;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
    FriendGroupItemModel *model = _data[indexPath.section];
    [_data removeObjectAtIndex:indexPath.section];
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    //静默处理删除请求
    [ShareBusinessManager.userManager postMyFriendDeleteGroupWithParameters:@{@"groupId":model.ID}
                                                                    success:^(id responObject) {
                                                                    }
                                                                    failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                        [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                    }];
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark ----------------缺省页

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle  =  UITableViewCellSeparatorStyleNone;
//        [_tableView registerClass:[MyFriendGroupTableViewCell class] forCellReuseIdentifier:@"groupCell"];
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
@end
