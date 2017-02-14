//
//  MyAttentionViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyAttentionViewController.h"
#import "MyAttentionSearchViewController.h"

@interface MyAttentionViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** 列表*/
@property (nonatomic, strong) UITableView *listTable;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;

/** search*/
@property (nonatomic, strong) UISearchController *searchController;

/** 页码*/
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger count;



@end

@implementation MyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.listTable];
    self.searchController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _currentPage = 1;
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    GOLFWeakObj(self);
    
    [SVProgressHUD setStatus:@"努力加载中"];
    
    [ShareBusinessManager.userManager postMyAttentionListWithParameters:@{@"currentPage":[NSNumber numberWithInteger:_currentPage], @"pageSize":PAGESIZE} success:^(id responObject) {
        
        NSDictionary *dict = responObject;
        NSArray *data = dict[@"data"];
        weakself.count = [dict[@"count"] integerValue];
        weakself.name = [NSString stringWithFormat:@"关注(%ld)",weakself.count];
        
        [SVProgressHUD dismiss];
        if (ret) {
            [weakself.data removeAllObjects];
            [weakself.listTable.mj_header endRefreshing];
            [weakself.listTable.mj_footer setState:MJRefreshStateIdle];
        }else{
            if (data.count < PAGESIZE.integerValue ) {
                [weakself.listTable.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakself.listTable.mj_footer endRefreshing];
            }
        }
        [weakself.data addObjectsFromArray:data];
        [weakself.listTable reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        if (ret) {
            [weakself.listTable.mj_header endRefreshing];
        }else{
            [weakself.listTable.mj_footer endRefreshing];
        }
        weakself.name = @"关注(0)";
    }];
}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"attentionCell"];
    cell.model = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //进入社区主页
    FriendUserModel *model = _data[indexPath.row];
    TSOCommunityUserInfoViewController *mySpaceVc = [[TSOCommunityUserInfoViewController alloc] initWithUserID:model.userId];
    [self.navigationController pushViewController:mySpaceVc animated:YES];
}

#pragma mark ----------------缺省页

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------搜索结果展示

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    MyAttentionSearchViewController *resultVc = (MyAttentionSearchViewController *)searchController.searchResultsController;
    [resultVc.dataArray removeAllObjects];
    NSString *text = searchController.searchBar.text;
    for (FriendUserModel *model in _data) {
        if ([model.nickName containsString:text]) {
            [resultVc.dataArray addObject:model];
        }
    }
    [resultVc.tableView reloadData];
}


#pragma mark ----------------实例

- (UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.separatorColor = GRAYCOLOR;
        _listTable.backgroundColor = BACKGROUNDCOLOR;
        _listTable.emptyDataSetSource = self;
        _listTable.emptyDataSetDelegate = self;
        _listTable.tableFooterView = [UIView new];
        [_listTable registerClass:[MyAttentionTableViewCell class] forCellReuseIdentifier:@"attentionCell"];
        GOLFWeakObj(self);
        //下拉刷新
        _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        
        _listTable.mj_footer.automaticallyHidden = YES;

    }
    return _listTable;
}

- (UISearchController *)searchController{
    if (!_searchController) {
        GOLFWeakObj(self);
        MyAttentionSearchViewController *searchVc = [[MyAttentionSearchViewController alloc] init];
        searchVc.block = ^(id responObject){
            FriendUserModel *model = responObject;
            TSOCommunityUserInfoViewController *mySpaceVc = [[TSOCommunityUserInfoViewController alloc] initWithUserID:model.userId];
            [weakself.navigationController pushViewController:mySpaceVc animated:YES];
        };
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:searchVc];
        _searchController.view.backgroundColor = BACKGROUNDCOLOR;
        _searchController.searchResultsUpdater = self;
        _searchController.hidesNavigationBarDuringPresentation = YES;//
        self.definesPresentationContext = YES;//
        UISearchBar *bar = _searchController.searchBar;
        bar.barStyle = UIBarStyleDefault;
        bar.placeholder = @"搜索";
        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        view.layer.borderWidth = 1;
        bar.translucent = YES;
        bar.barTintColor = BACKGROUNDCOLOR;
        bar.tintColor = GLOBALCOLOR;
        CGRect rect = bar.frame;
        rect.size.height = 45;
        bar.frame = rect;
        self.listTable.tableHeaderView = bar;
    }
    return _searchController;
}

@end
