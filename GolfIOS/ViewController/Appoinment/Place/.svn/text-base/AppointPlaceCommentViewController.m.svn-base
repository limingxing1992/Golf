//
//  AppointPlaceCommentViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/22.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointPlaceCommentViewController.h"

@interface AppointPlaceCommentViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
>
/** 评价列表*/
@property (nonatomic, strong) UITableView *tableView;

/** 数据源*/
@property (nonatomic, strong) NSMutableArray *data;

/** 当前页*/
@property (nonatomic, assign) NSInteger page;

/** 评价总数*/
@property (nonatomic, copy) NSString *commentNum;


@end

@implementation AppointPlaceCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"评价";
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self loadDataWithRet:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
}

- (void)loadDataWithRet:(BOOL)ret{
    if (!_placeID) {
        [SVProgressHUD showErrorWithStatus:@"没有球场ID"];
        return;
    }
    
    
    GOLFWeakObj(self);
    if (ret) {
        _page = 1;
    }else{
        _page += 1;
    }

    NSDictionary *dict = @{@"ballPlaceId":_placeID,
                           @"currentPage":[NSNumber numberWithInteger:_page],                                                                                                            @"pageSize":PAGESIZE};
    
    [ShareBusinessManager.appointmentPlaceManager postAppointmentPlaceCommentListWithParameter:dict
                                                                                       success:^(id responObject) {
                                                                                           PlaceCommentModel *model = responObject;
                                                                                           _commentNum = model.commentNum;
                                                                                           
                                                                                           NSArray *data = model.commentList;
                                                                                           
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
                                                                                           [weakself.data addObjectsFromArray:data];
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

#pragma mark ----------------tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView cellHeightForIndexPath:indexPath model:_data[indexPath.row] keyPath:@"model" cellClass:[AppointmentPlaceCommentTableViewCell class] contentViewWidth:SCREEN_WIDTH];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *lb = [[UILabel alloc] init];
    lb.font = FONT(14);
    lb.textColor = LIGHTTEXTCOLOR;
    lb.text = [NSString stringWithFormat:@"评价(%@条)",_commentNum];
    [view addSubview:lb];
    lb.sd_layout
    .centerYEqualToView(view)
    .leftSpaceToView(view, 15)
    .rightSpaceToView(view, 15)
    .autoHeightRatio(0);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentPlaceCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jugeCell"];
    cell.model = _data[indexPath.row];
    return cell;
}

#pragma mark ----------------缺省页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}


#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10 + NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 10) style:UITableViewStyleGrouped];
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.backgroundColor = WHITECOLOR;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
        [_tableView registerClass:[AppointmentPlaceCommentTableViewCell class] forCellReuseIdentifier:@"jugeCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
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


@end
