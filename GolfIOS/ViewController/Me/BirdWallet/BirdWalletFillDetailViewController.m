//
//  BirdWalletFillDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/12.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BirdWalletFillDetailViewController.h"

@interface BirdWalletFillDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
@property (nonatomic, strong) BalanceTitleView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data_0;

@property (nonatomic, strong) NSMutableArray *data_1;

@property (nonatomic, strong) NSMutableArray *data_2;

@property (nonatomic, assign) NSInteger recordStyle;

@property (nonatomic, assign) NSInteger currentPage;


@end

static NSString *const balanceCellID = @"BalanceDetailCell";

@implementation BirdWalletFillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"余额明细";
    self.isAutoBack = NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------数据

- (void)initData{
    _data_0 = [[NSMutableArray alloc] init];
    _data_1 = [[NSMutableArray alloc] init];
    _data_2 = [[NSMutableArray alloc] init];
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:@{@"currentPage":[NSNumber numberWithInteger:_currentPage],
                                                                                  @"pageSize":PAGESIZE}];
    
    switch (_recordStyle) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            [dict setValue:@1 forKey:@"payFlag"];
        }
            break;
        case 2:
        {
            [dict setValue:@0 forKey:@"payFlag"];
        }
            break;
        default:
            break;
    }
    [SVProgressHUD showWithStatus:@"努力加载中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyBirdWalletFillRecordWithParameters:dict
                                                                       success:^(id responObject) {
                                                                           [SVProgressHUD dismiss];
                                                                           
                                                                           NSArray *data = responObject;
                                                                           [SVProgressHUD dismiss];
                                                                           if (ret) {
                                                                               switch (weakself.recordStyle) {
                                                                                   case 0:
                                                                                       [weakself.data_0 removeAllObjects];
                                                                                       break;
                                                                                    case 1:
                                                                                       [weakself.data_1 removeAllObjects];
                                                                                       break;
                                                                                    case 2:
                                                                                       [weakself.data_2 removeAllObjects];
                                                                                       break;
                                                                                   default:
                                                                                       break;
                                                                               }
                                                                               [weakself.tableView.mj_header endRefreshing];
                                                                               [weakself.tableView.mj_footer setState:MJRefreshStateIdle];
                                                                           }else{
                                                                               if (data.count < PAGESIZE.integerValue ) {
                                                                                   [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                                                                               }else{
                                                                                   [weakself.tableView.mj_footer endRefreshing];
                                                                               }
                                                                           }
                                                                           switch (weakself.recordStyle) {
                                                                               case 0:
                                                                                   [weakself.data_0 addObjectsFromArray:data];
                                                                                   break;
                                                                               case 1:
                                                                                   [weakself.data_1 addObjectsFromArray:data];
                                                                                   break;
                                                                               case 2:
                                                                                   [weakself.data_2 addObjectsFromArray:data];
                                                                                   break;
                                                                               default:
                                                                                   break;
                                                                           }
                                                                           [weakself.tableView reloadData];

                                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                           [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                       }];
}

#pragma mark ----------------界面逻辑

- (void)changStyleWithIndex:(NSInteger)index{
    _recordStyle = index;
    [self loadDataWithRet:YES];
}


#pragma mark ----------------空白页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (_recordStyle) {
        case 0:
        {
            return _data_0.count;
        }
            break;
        case 1:
        {
            return _data_1.count;
        }
            break;
        case 2:
        {
            return _data_2.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BalanceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:balanceCellID];
    MyBirdWalletFillRecordModel *model;
    switch (_recordStyle) {
        case 0:
            model = _data_0[indexPath.row];
            break;
        case 1:
            model = _data_1[indexPath.row];
            break;
        case 2:
            model = _data_2[indexPath.row];
            break;
        default:
            break;
    }
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}



#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT + 50, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 50)];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[BalanceDetailTableViewCell class] forCellReuseIdentifier:balanceCellID];
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

- (BalanceTitleView *)topView{
    if (!_topView) {
        _topView = [[BalanceTitleView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 50)];
        GOLFWeakObj(self);
        _topView.block = ^(NSInteger index){
            [weakself changStyleWithIndex:index];
        };
    }
    return _topView;
}

@end
