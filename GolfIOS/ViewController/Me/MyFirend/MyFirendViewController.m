//
//  MyFirendViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyFirendViewController.h"
#import "MyFriendSearchViewController.h"


@interface MyFirendViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** search*/
@property (nonatomic, strong) UISearchController *searchController;
/** 列表页*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableArray *titleData;
/** 所有列表*/
@property (nonatomic, strong) NSMutableArray *listData;



@end

@implementation MyFirendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的好友";
    self.rightStr_0 = @"添加好友";
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self loadData];//数据请求
    [GOLFNotificationCenter addObserver:self selector:@selector(loadData) name:@"updateFriendList" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}


#pragma mark ----------------数据

/** 初始化数据*/
- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _titleData = [[NSMutableArray alloc] init];
    _listData = [[NSMutableArray alloc] init];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"努力加载中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyFriendListWithParameters:nil
                                                             success:^(id responObject) {
                                                                 [SVProgressHUD dismiss];
                                                                 [weakself.listData removeAllObjects];
                                                                 [weakself.listData addObjectsFromArray:responObject];
                                                                 [weakself sortNameWithAry:responObject];
                                                             }
                                                             failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                 [SVProgressHUD showErrorWithStatus:errorMsg];
                                                             }];

}
/** 数据处理好友排序*/
- (void)sortNameWithAry:(NSArray *)responObject{
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
    [_data removeAllObjects];
    [_titleData removeAllObjects];
    [_data addObjectsFromArray:data];
    [_titleData addObjectsFromArray:titleData];
    //刷新界面
    [self.tableView reloadData];
}

#pragma mark ----------------界面逻辑
/** 添加好友*/
- (void)right_0_action{
    MyAddFirendViewController *addVc =  [[MyAddFirendViewController alloc] init];
    //传入我的所有好友数据与通讯录匹配
    addVc.myFriendListData = [[NSMutableArray alloc] initWithArray:_listData];
    [self.navigationController pushViewController:addVc animated:YES];
}
/** 进入好友分组和好友申请*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        FriendUserModel *itemModel = _data[indexPath.section - 1][indexPath.row];
        MyFriendDetailViewController *detailVc = [[MyFriendDetailViewController alloc] initWithModel:itemModel isFriend:YES];
        [self.navigationController pushViewController:detailVc animated:YES];
    }else{
        if (indexPath.row == 0) {
            //进入好友申请
            MyFriendInviteListViewController *listVc = [[MyFriendInviteListViewController alloc] init];
            [self.navigationController pushViewController:listVc animated:YES];
        }else{
            //好友分组
            MyFriendGruopViewController *groupVc = [[MyFriendGruopViewController alloc] init];
            [self.navigationController pushViewController:groupVc animated:YES];
        }
    }

}

#pragma mark ----------------tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count +1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return [_data[section - 1] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 57.5;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.001;
    }
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section ==0 ) {
        return nil;
    }
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = BACKGROUNDCOLOR;
    UILabel *lv = [[UILabel alloc] init];
    lv.font = FONT(10);
    lv.textColor = BLACKTEXTCOLOR;
    lv.text = _titleData[section -1];
    [view addSubview:lv];
    lv.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .autoHeightRatio(0);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"group"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = WHITECOLOR;
        cell.textLabel.font = FONT(14);
        cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];
        cell.textLabel.textColor = BLACKTEXTCOLOR;
        if (indexPath.row == 0) {
            cell.imageView.image = IMAGE(@"classify194");
            cell.textLabel.text = @"好友申请";

        }else if (indexPath.row ==1){
            cell.imageView.image = IMAGE(@"classify174");
            cell.textLabel.text = @"好友分组";
        }
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = GRAYCOLOR;
        [cell addSubview:lineView];
        lineView.sd_layout
        .bottomSpaceToView(cell, 0)
        .leftSpaceToView(cell, 0)
        .rightSpaceToView(cell, 0)
        .heightIs(0.5);
        
        return cell;
    }
    
    MyFriendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    FriendUserModel *itemModel = _data[indexPath.section - 1][indexPath.row];
    cell.model = itemModel;
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return _titleData;
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
    FriendUserModel *itemModel = _data[indexPath.section - 1][indexPath.row];

    NSMutableArray *ary = self.data[indexPath.section - 1];
    [ary removeObjectAtIndex:indexPath.row];
    if (!ary.count) {
        [_data removeObjectAtIndex:indexPath.section - 1];
        [_titleData removeObjectAtIndex:indexPath.section - 1];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        [_data replaceObjectAtIndex:indexPath.section - 1 withObject:ary];
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    //静默处理删除请求
    [ShareBusinessManager.userManager postDeleteMyFriendWithParameters:@{@"friendIds":itemModel.userId}
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

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark ----------------搜索代理

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    MyFriendSearchViewController *resultVc = (MyFriendSearchViewController *)searchController.searchResultsController;
    [resultVc.dataArray removeAllObjects];
    NSString *text = searchController.searchBar.text;
    if ([text validateNumber]) {
        for (FriendUserModel *itemModel in _listData) {
            if ([itemModel.userName containsString:text]) {
                [resultVc.dataArray addObject:itemModel];
            }
        }
    }else{
        for (FriendUserModel *itemModel in _listData) {
            if ([itemModel.nickName containsString:text]) {
                [resultVc.dataArray addObject:itemModel];
            }
        }
    }
    
    
    [resultVc.tableView reloadData];
}


#pragma mark ----------------实例

- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:[MyFriendSearchViewController new]];
        _searchController.view.backgroundColor = BACKGROUNDCOLOR;
        _searchController.searchResultsUpdater = self;
        _searchController.hidesNavigationBarDuringPresentation = YES;//
        self.definesPresentationContext = YES;//
        UISearchBar *bar = _searchController.searchBar;
        bar.barStyle = UIBarStyleDefault;
        bar.placeholder = @"输入关键字";
        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        view.layer.borderWidth = 1;
        bar.translucent = YES;
        bar.barTintColor = BACKGROUNDCOLOR;
        bar.tintColor = GLOBALCOLOR;
        CGRect rect = bar.frame;
        rect.size.height = 45;
        bar.frame = rect;
        self.tableView.tableHeaderView = bar;
    }
    return _searchController;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.sectionIndexColor = LIGHTTEXTCOLOR;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[MyFriendUserTableViewCell class] forCellReuseIdentifier:@"friendCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"group"];
    }
    return _tableView;
}



@end
