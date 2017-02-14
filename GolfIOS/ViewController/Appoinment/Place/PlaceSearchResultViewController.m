//
//  PlaceSearchResultViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "PlaceSearchResultViewController.h"

@interface PlaceSearchResultViewController ()
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

@end

@implementation PlaceSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"搜索结果";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self loadData];//进行搜索请求
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark ----------------数据处理

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadData{
    
    [SVProgressHUD showWithStatus:@"努力加载中"];
    GOLFWeakObj(self);
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (_keyWord) {
        [dict setValue:_keyWord forKey:@"searchName"];
    }
    NSString *lat = LatTi;
    if (lat) {
        [dict setValue:lat forKey:@"latitude"];
    }
    
    NSString *longti = LongTi;
    if (longti) {
        [dict setValue:longti forKey:@"longitude"];
    }

    if (dict.allKeys.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"参数错误"];
        return;
    }
    
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceListWithParameters:dict
                                                                                 success:^(id responObject) {
                                                                                     [SVProgressHUD dismiss];
                                                                                     [weakself.data removeAllObjects];
                                                                                     [weakself.data addObjectsFromArray:responObject];
                                                                                     [weakself.tableView reloadData];
                                                                                 }
                                                                                 failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                                 }];
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

/** 点进入球场详情页*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceItemModel *model = _data[indexPath.row];
    
    if (_isSelect) {
        [GOLFNotificationCenter postNotificationName:FriendSelectInfo object:nil userInfo:@{@"placeItem":model}];
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        return;
    }
    
    PlaceDetailViewController *detailVc = [[PlaceDetailViewController alloc] init];
    detailVc.name = model.name;
    detailVc.ballPlaceId = model.ID;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorInset = UIEdgeInsetsZero;
        [_tableView registerClass:[AppointPlaceTableViewCell class] forCellReuseIdentifier:@"placeCell"];
    }
    return _tableView;
}
@end
