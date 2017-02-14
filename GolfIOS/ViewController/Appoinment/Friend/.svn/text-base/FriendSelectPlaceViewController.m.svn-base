//
//  FriendSelectPlaceViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/19.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FriendSelectPlaceViewController.h"

@interface FriendSelectPlaceViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate
>
/** 场地列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 数据*/
@property (nonatomic, strong) NSMutableArray *data;
/** 当前页*/
@property (nonatomic, assign) NSInteger page;
/** 排序方式*/
@property (nonatomic, strong) NSNumber *sortStyle;

/** 定位*/
@property (nonatomic, copy) NSString *longti;//精度
@property (nonatomic, copy) NSString *lanti;//维度

@end

@implementation FriendSelectPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"找球场";
    self.rightIm_0 = IMAGE(@"classify33");
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

#pragma mark ----------------数据处理

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _page = 1;//默认第一页
    _sortStyle = @10;//默认
    _longti = LongTi;
    _lanti = LatTi;


}

- (void)loadDataWithRet:(BOOL)ret{
    
    [SVProgressHUD showWithStatus:@"努力加载中"];
    
    GOLFWeakObj(self);
    if (ret) {
        _page = 1;
    }else{
        _page += 1;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //判断是否有城市id(由首页定位)
    NSString *areaId = AreaID;
    if (areaId) {
        [dict setValue:areaId forKey:@"areaId"];
    }
    if (_longti) {
        [dict setValue:_longti forKey:@"longitude"];
    }
    
    if (_lanti) {
        [dict setValue:_lanti forKey:@"latitude"];
    }
    [dict setValue:PAGESIZE forKey:@"pageSize"];
    [dict setValue:[NSNumber numberWithInteger:_page] forKey:@"currentPage"];
    [dict setValue:_sortStyle forKey:@"sort"];
    
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceListWithParameters:dict
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


#pragma mark ----------------界面逻辑
/** 搜索动作*/
- (void)right_0_action{
    PlaceSearchListViewController *searchVc = [[PlaceSearchListViewController alloc] init];
    searchVc.isSelect = YES;
    [self.navigationController pushViewController:searchVc animated:YES];

}
/** 点击选择球场返回上级页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceItemModel *model = _data[indexPath.row];
    if (self.block) {
        self.block(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placeCell"];
    cell.model = _data[indexPath.row];
    return cell;
}


#pragma mark ----------------实例


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT )];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[AppointPlaceTableViewCell class] forCellReuseIdentifier:@"placeCell"];
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
