//
//  MyFriendInviteListViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/6.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendInviteListViewController.h"

@interface MyFriendInviteListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>

@property (nonatomic, strong) UITableView *listTable;

@property (nonatomic, strong) NSMutableArray *data;



@end

@implementation MyFriendInviteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"好友申请";
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.listTable];
    [self loadData];//刷新数据
    [GOLFNotificationCenter addObserver:self selector:@selector(loadData) name:@"updateFriendList" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark ----------------数据

- (void)initData{
    _data = [NSMutableArray array];
}

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [ShareBusinessManager.userManager postMyFriendInviteListWithParameters:nil success:^(id responObject) {
        [SVProgressHUD dismiss];
        [weakself.data removeAllObjects];
        [weakself.data addObjectsFromArray:responObject];
        [weakself.listTable reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark ----------------界面逻辑

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendUserModel*model = _data[indexPath.row];
    
    MyFriendDetailViewController *detailVc = [[MyFriendDetailViewController alloc] initWithModel:model isFriend:model.validateStatus];
    [self.navigationController pushViewController:detailVc animated:YES];
}


#pragma mark ----------------代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFriendInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteCell"];
    cell.model = _data[indexPath.row];
    return cell;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark ----------------实例

- (UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT- NaviBar_HEIGHT )];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.separatorColor = GRAYCOLOR;
        _listTable.backgroundColor = BACKGROUNDCOLOR;
        _listTable.emptyDataSetSource = self;
        _listTable.emptyDataSetDelegate = self;
        _listTable.tableFooterView = [UIView new];
        _listTable.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        [_listTable registerClass:[MyFriendInviteTableViewCell class] forCellReuseIdentifier:@"inviteCell"];
    }
    return _listTable;
}


@end
