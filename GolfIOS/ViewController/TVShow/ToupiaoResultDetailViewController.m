//
//  ToupiaoResultDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/23.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ToupiaoResultDetailViewController.h"

@interface ToupiaoResultDetailViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetDelegate,
DZNEmptyDataSetSource
>

@property (nonatomic, strong) UITableView *resultTablView;
/** 投票结果数据*/
@property (nonatomic, strong) NSMutableArray *resultData;
/** 当前页*/
@property (nonatomic, assign) NSInteger currentPage;


@end

@implementation ToupiaoResultDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"投票结果";
    self.isAutoBack = NO;
    [self.view addSubview:self.resultTablView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------数据

- (void)initData{
    _resultData = [[NSMutableArray alloc] init];
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVoteResultWithParameters:@{@"activityId":_activeId,
                                                                     @"currentPage":[NSNumber numberWithInteger:_currentPage],
                                                                     @"pageSize":PAGESIZE}
                                                           success:^(id responObject) {
                                                               NSArray *data = responObject;
                                                               [SVProgressHUD dismiss];
                                                               if (ret) {
                                                                   [weakself.resultData removeAllObjects];
                                                                   [weakself.resultTablView.mj_header endRefreshing];
                                                                   [weakself.resultTablView.mj_footer setState:MJRefreshStateIdle];
                                                               }else{
                                                                   if (data.count < PAGESIZE.integerValue ) {
                                                                       [weakself.resultTablView.mj_footer endRefreshingWithNoMoreData];
                                                                   }else{
                                                                       [weakself.resultTablView.mj_footer endRefreshing];
                                                                   }
                                                               }
                                                               [weakself.resultData addObjectsFromArray:responObject];
                                                               [weakself.resultTablView reloadData];
                                                               

                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                               if (ret) {
                                                                   [weakself.resultTablView.mj_header endRefreshing];
                                                               }else{
                                                                   [weakself.resultTablView.mj_footer endRefreshing];
                                                               }
                                                           }];

}

#pragma mark ----------------代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultData.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tvResultDetailCell"];
        
    TvVoteModel *model = _resultData[indexPath.row];
    cell.tvModel = model;
        
    return cell;
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例
- (UITableView *)resultTablView{
    if (!_resultTablView) {
        _resultTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _resultTablView.delegate = self;
        _resultTablView.dataSource= self;
        _resultTablView.separatorInset = UIEdgeInsetsZero;
        _resultTablView.separatorColor = GRAYCOLOR;
        
        [_resultTablView registerClass:[ChartsTableViewCell class] forCellReuseIdentifier:@"tvResultDetailCell"];
        _resultTablView.emptyDataSetSource = self;
        _resultTablView.emptyDataSetDelegate = self;
        _resultTablView.tableFooterView = [UIView new];
        
        GOLFWeakObj(self);
        //下拉刷新
        _resultTablView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadDataWithRet:YES];
        }];
        
        _resultTablView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakself loadDataWithRet:NO];
        }];
        
        _resultTablView.mj_footer.automaticallyHidden = YES;
    }
    return _resultTablView;
}

@end
