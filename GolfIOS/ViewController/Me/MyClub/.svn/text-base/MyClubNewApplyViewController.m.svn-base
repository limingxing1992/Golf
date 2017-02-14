//
//  NewApplyViewController.m
//  GolfIOS
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubNewApplyViewController.h"
#import "NewApplyViewCell.h"
#import "MyClubVerifyViewController.h"

static NSString* NewApplyCellId = @"NewApply";

@interface MyClubNewApplyViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 详细视图*/
@property(nonatomic,strong) UITableView *tableView;
/****网络数据***/
/** 数据页数*/
@property (nonatomic, assign) NSInteger page;
/** 数据列表*/
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation MyClubNewApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.isAutoBack = NO;
    self.name = @"新申请";//需要赋值数据
    [self.view addSubview:self.tableView];
    [self requestData];
    //注册通知
    [GOLFNotificationCenter addObserver:self selector:@selector(UploadData) name:@"updateApplyList" object:nil];
}

/** 接收通知刷新数据*/
-(void)UploadData{
    [self.tableView.mj_header beginRefreshing];
    [self.tableView reloadData];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark - 请求网络数据
-(void)requestData{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    [SVProgressHUD showWithStatus:@"努力加载中"];
    //新申请成员列表
    NSDictionary *Parameter = @{@"clubId":self.clubId,
                                @"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.userManager postMyClubNewApplyUserListWithParameters:Parameter success:^(id responObject) {
        
        [SVProgressHUD dismiss];
        //遍历数据模型数组
        for (MyClubNewJoinListModel *model in responObject) {
            [self.dataList addObject:model];
        }

        if (self.dataList.count > 0) {
            self.page ++;
            [self.tableView reloadData];
        }
        
        if (self.dataList.count < PAGESIZE.integerValue) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }


    } failure:^(NSInteger errCode, NSString *errorMsg) {
          [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewApplyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewApplyCellId];
    cell.cellModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - 自动获取高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取高度
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}



#pragma mark - cell的点击事件
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyClubVerifyViewController *vc = [[MyClubVerifyViewController alloc] init];
    //获取对应的数据
    vc.applyUserModel = self.dataList[indexPath.row];
    vc.clubId = self.clubId;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载控件
- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        [_tableView registerClass:[NewApplyViewCell class] forCellReuseIdentifier:NewApplyCellId];
        _tableView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.page = 1;
        
        //添加上拉刷新和下拉加载
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];

    }
    return _tableView;
}

@end
