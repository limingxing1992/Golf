//
//  OrderListViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "OrderListViewController.h"

@interface OrderListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** 菜单栏*/
@property (nonatomic, strong) OrderMenuView *menu;
/** 订单列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger currentPage;
/** 当前订单状态*/
@property (nonatomic, assign) NSInteger currentSelectIndex;//0 -4 全部、代付款- 可使用-退款中 -已完成

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的订单";
    self.isAutoBack = NO;
    [self.view addSubview:self.menu];
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
    [self loadReturnRule];//获取退款规则，存入缓存，每次进入订单中心就会刷新退款规则
    [GOLFNotificationCenter addObserver:self selector:@selector(loadDataByNotification) name:OrderListUpdate object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self name:OrderListUpdate object:nil];
}

#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _currentPage = 1;
}

- (void)loadReturnRule{
    [ShareBusinessManager.userManager postMyOrderReturnRuleWithParameters:nil
                                                                  success:^(id responObject) {
                                                                      [GOLFUserDefault setObject:responObject forKey:@"ReturnRule"];
                                                                  } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                      [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                  }];
}

- (void)loadDataWithRet:(BOOL)ret{
    if (ret) {
        _currentPage = 1;
    }else{
        _currentPage += 1;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:[NSNumber numberWithInteger:_currentPage] forKey:@"currentPage"];
    [dict setValue:PAGESIZE forKey:@"pageSize"];
    switch (_currentSelectIndex) {
        case 0:
        {//全部不传
        
        }
            break;
        case 1:
        {//代付款
            [dict setValue:@10 forKey:@"status"];
        }
            break;
        case 2:
        {//待使用
            [dict setValue:@30 forKey:@"status"];

        }
            break;
        case 3:
        {//待退款
            [dict setValue:@300 forKey:@"status"];

        }
            break;
        case 4:
        {//已完结
            [dict setValue:@50 forKey:@"status"];

        }
            break;
        default:
            break;
    }
    
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderListWithParameters:dict
                                                            success:^(id responObject) {
                                                                NSArray *data = responObject;
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
                                                                [weakself.data addObjectsFromArray:responObject];
                                                                [weakself.tableView reloadData];

                                                            } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                if (ret) {
                                                                    [weakself.tableView.mj_header endRefreshing];
                                                                }else{
                                                                    [weakself.tableView.mj_footer endRefreshing];
                                                                }
                                                            }];
}

- (void)loadDataByNotification{
    [self loadDataWithRet:YES];
}

#pragma mark ----------------界面逻辑
/** 切换菜单栏*/
- (void)changeStyleChartsWithIndex:(NSInteger)index{
    _currentSelectIndex = index;
    [self loadDataWithRet:YES];
}
/** 右1按钮动作*/
- (void)cellRightAction_0WithStyle:(MyOrderListItemModel *)model{
    GOLFWeakObj(self);
    switch (model.orderInfo.status) {
        case 10:
        {//待付款
            //去付款
            OrderPayViewController *payVc = [[OrderPayViewController alloc] init];
            payVc.model = model;
            [self.navigationController pushViewController:payVc animated:YES];
        }
            break;
        case 20:
        {//待确认
            //申请退款
            NSString *returnRule = [GOLFUserDefault objectForKey:@"ReturnRule"];
            [STL_CommonIdea alertWithTarget:self Title:@"确定退款？" message:returnRule action_0:@"确认退款" action_1:@"暂不退款" block_0:^{
                [weakself applyReturnOrderByOrderInfo:model.orderInfo];
            } block_1:nil];
        }
            break;
        case 30:
        {//待使用
            //确认使用
            [STL_CommonIdea alertWithTarget:self Title:@"确认使用？" message:@"请再次确认已使用订单" action_0:@"确认使用" action_1:@"放弃" block_0:^{
                [weakself useOrderByOrderInfo:model.orderInfo];
            } block_1:nil];
        }
            break;
        case 40:
        {//待评价
            //去评价
            OrderCommentViewController *commentVc = [[OrderCommentViewController alloc] init];
            commentVc.model = model;
            [self.navigationController pushViewController:commentVc animated:YES];
        }
            break;
        case 50:
        {//已完结
            //重新预订
            [self againAppointmentPlaceWith:model];
        }
            break;
        case 300:
        {//待退款
            //无动作
        }
            break;
        case 350:
        {//已退款
            //重新预订
            [self againAppointmentPlaceWith:model];
        }
            break;
        case 400:
        {//已取消
            //重新预订
            [self againAppointmentPlaceWith:model];
        }
            break;
            
        default:
            break;
    }


}
/** 右2按钮动作*/
- (void)cellRightAction_1WithStyle:(MyOrderListItemModel *)model{
    GOLFWeakObj(self);
    switch (model.orderInfo.status) {
        case 10:
        {//待付款
            //取消订单
            [STL_CommonIdea alertWithTarget:self Title:@"确认取消订单？" message:nil action_0:@"确认取消" action_1:@"暂不取消" block_0:^{
                [ShareBusinessManager.userManager postMyOrderCancelWithParameters:@{@"orderNo":model.orderInfo.orderNo}
                                                                          success:^(id responObject) {
                                                                              [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                                                                              [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
                                                                              STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
                                                                              successVc.type = 1;
                                                                              successVc.orderNo = model.orderInfo.orderNo;
                                                                              [weakself.navigationController pushViewController:successVc animated:YES];
                                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                          }];
            } block_1:nil];
        }
            break;
        case 20:
        {//待确认
            //无
        }
            break;
        case 30:
        {//待使用
            //申请退款
            NSString *returnRule = [GOLFUserDefault objectForKey:@"ReturnRule"];
            [STL_CommonIdea alertWithTarget:self Title:@"确定退款？" message:returnRule action_0:@"确认退款" action_1:@"暂不退款" block_0:^{
                [weakself applyReturnOrderByOrderInfo:model.orderInfo];
            } block_1:nil];
        }
            break;
        case 40:
        {//待评价
            //重新预订
            [self againAppointmentPlaceWith:model];
        }
            break;
        case 50:
        {//已完结
        }
            break;
        case 300:
        {//待退款
        }
            break;
        case 350:
        {//已退款
        }
            break;
        case 400:
        {//已取消
        }
            break;
            
        default:
            break;
    }
}
/** 进入订单详情页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderDetailVc = [[OrderDetailViewController alloc] init];
    orderDetailVc.model = _data[indexPath.row];
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}
/** 使用*/
- (void)useOrderByOrderInfo:(MyOrderInfoModel *)orderInfo{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderUseParameters:@{@"orderNo":orderInfo.orderNo,
                                                                 @"serviceTicket":orderInfo.serviceTicket}
                                                       success:^(id responObject) {
                                                           [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
                                                           STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
                                                           successVc.type = 2;
                                                           successVc.orderNo = orderInfo.orderNo;
                                                           [weakself.navigationController pushViewController:successVc animated:YES];
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:errorMsg];
                                                       }];
}

/** 重新预订*/
- (void)againAppointmentPlaceWith:(MyOrderListItemModel *)model{
    
    PlaceSubmitApointViewController *placeVc = [[PlaceSubmitApointViewController alloc] init];
    placeVc.model = model.serviceInfo;
    placeVc.openTime = model.ballPlaceInfo.openTime;
    placeVc.endTime = model.ballPlaceInfo.closeTime;
    placeVc.placeName = model.ballPlaceInfo.name;
    [self.navigationController pushViewController:placeVc animated:YES];
}
/** 申请退款*/
- (void)applyReturnOrderByOrderInfo:(MyOrderInfoModel *)orderInfo{
    [ShareBusinessManager.userManager postMyOrderApplyReturnWithParameters:@{@"orderNo":orderInfo.orderNo} success:^(id responObject) {
        [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
        [SVProgressHUD showSuccessWithStatus:@"已申请退款，请耐心等待客服联系"];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 195;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GOLFWeakObj(self);
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell"];
    MyOrderListItemModel *itemModel = _data[indexPath.row];
    cell.model = itemModel;
    cell.block_0 = ^(id responObject){
        [weakself cellRightAction_0WithStyle:responObject];
    };
    cell.block_1 = ^(id responObject){
        [weakself cellRightAction_1WithStyle:responObject];
    };
    return cell;
}

#pragma mark ----------------空白页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例

- (OrderMenuView *)menu{
    if (!_menu) {
        _menu = [[OrderMenuView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, 45)];
        GOLFWeakObj(self);
        _menu.block = ^(NSInteger index){
            [weakself changeStyleChartsWithIndex:index];
        };

    }
    return _menu;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT + 45, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 45)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"orderCell"];
        
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

@end
