//
//  BattleScoreViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BattleScoreViewController.h"

@interface BattleScoreViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource
>
/** 个人排行信息*/
@property (nonatomic, strong) ChartsSelfView *selfView;
/** 排行榜*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger currentPage;

/** 当前排行model*/
@property (nonatomic, strong) ChartsModel *model;

@end

@implementation BattleScoreViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.selfView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _selfView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(75);
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    GOLFWeakObj(self);
    NSDictionary *dict = @{@"currentPage":[NSNumber numberWithInteger:_currentPage],
                           @"pageSize":PAGESIZE};
    [ShareBusinessManager.chartsManager postChartsFightRankListParameters:dict
                                                                success:^(id responObject) {
                                                                    _model = responObject;
                                                                    NSArray *data = _model.dataList;
                                                                    
                                                                    [SVProgressHUD dismiss];
                                                                    if (ret) {
                                                                        [weakself.data removeAllObjects];
                                                                        [weakself.tableView.mj_header endRefreshing];
                                                                        [weakself.tableView.mj_footer setState:MJRefreshStateIdle];
                                                                    }else{
                                                                        if (data.count < PAGESIZE.integerValue ) {
                                                                            [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                        }else{
                                                                            [weakself.tableView.mj_footer endRefreshing];
                                                                        }
                                                                    }
                                                                    [weakself.data addObjectsFromArray:_model.dataList];
                                                                    [weakself.tableView reloadData];
                                                                    [weakself updateSelfInfo];
                                                                }
                                                                failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                    [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                    if (ret) {
                                                                        [weakself.tableView.mj_header endRefreshing];
                                                                    }else{
                                                                        [weakself.tableView.mj_footer endRefreshing];
                                                                    }
                                                                    
                                                                }];
}

- (void)updateSelfInfo{
    _selfView.model = _model.userData;
}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"starCell"];
    ChartsItemModel *model = _data[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark ----------------空白页

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例化


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 92.5 - 75)];
        _tableView.delegate = self;
        _tableView.dataSource= self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = GRAYCOLOR;
        [_tableView registerClass:[ChartsTableViewCell class] forCellReuseIdentifier:@"starCell"];
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        GOLFWeakObj(self);
        //下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        
        _tableView.mj_footer.automaticallyHidden = YES;
        
    }
    return _tableView;
}

- (ChartsSelfView *)selfView{
    if (!_selfView) {
        _selfView = [[ChartsSelfView alloc] init];
    }
    return _selfView;
}

@end
