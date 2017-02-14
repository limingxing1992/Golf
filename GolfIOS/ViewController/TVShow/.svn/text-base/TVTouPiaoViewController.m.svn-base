//
//  TVTouPiaoViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TVTouPiaoViewController.h"

@interface TVTouPiaoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetDelegate,
    DZNEmptyDataSetSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;
/** 投票结果视图*/
@property (nonatomic, strong) UIView *resultView;
/** 投票尾*/
@property (nonatomic, strong) UIButton *lookAllBtn;
/** 投票头*/
@property (nonatomic, strong) UIImageView *headIv;
/** 投票结果列表（固定显示5个）*/
@property (nonatomic, strong) UITableView *resultTablView;
/** 投票结果数据*/
@property (nonatomic, strong) NSMutableArray *resultData;
/** 弹窗视图*/
@property (nonatomic, strong) STL_AlertCustomView *alertView;


@end

@implementation TVTouPiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"小鸟投票";
    self.isAutoBack = NO;
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----------------数据

- (void)initData{
    _data = [[NSMutableArray alloc] init];
    _resultData = [[NSMutableArray alloc] init];
}

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [ShareBusinessManager.tvManager postTvActionListWithParameters:nil success:^(id responObject) {
        [SVProgressHUD dismiss];
        [weakself.data removeAllObjects];
        [weakself.data addObjectsFromArray:responObject];
        [weakself.tableView reloadData];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark ----------------界面逻辑

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GOLFWeakObj(self);

    TvVoteActionModel *model = _data[indexPath.row];
    switch (model.status) {
        case 0:
        {//未开始
            [SVProgressHUD showErrorWithStatus:@"活动暂未开始，敬请期待"];
        }
            break;
        case 1:
        {//已开始
            if ([UserModel sharedUserModel].sort < model.sort) {
                NSString *text = [NSString stringWithFormat:@"当前活动等级需要%@",model.gradeName];
                [STL_CommonIdea alertWithTarget:self Title:@"快去升级啊" message:text action_0:@"取消" action_1:@"确定" block_0:nil block_1:^{
                    //跳转荣誉页面升级
                    MyLevelViewController *levelVc = [[MyLevelViewController alloc] init];
                    [weakself.navigationController pushViewController:levelVc animated:YES];
                }];
            }else{
                TVToupiaoDetailViewController *detailVc = [[TVToupiaoDetailViewController alloc] init];
                detailVc.Id = [NSNumber numberWithInt:model.ID.intValue];
                [self.navigationController pushViewController:detailVc animated:YES];
            }
        }
            break;
        case 2:
        {//已结束
            [self alertReresultListByID:model.ID];
        }
            break;
        default:
            break;
    }
    
}
/** 查看全部结果*/
- (void)lookForAllResultAction:(UIButton *)btn{
    [SVProgressHUD showSuccessWithStatus:@"进入详细页面"];
    
    [self.alertView dismiss];
    
    ToupiaoResultDetailViewController *resultVc = [[ToupiaoResultDetailViewController alloc] init];
    resultVc.activeId = [NSString stringWithFormat:@"%ld",btn.tag];
    [self.navigationController pushViewController:resultVc animated:YES];
}

#pragma mark ----------------代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.resultTablView) {
        return _resultData.count;
    }
    return _data.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.resultTablView) {
        return 69;
    }
    return (SCREEN_HEIGHT- NaviBar_HEIGHT) /2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.resultTablView) {
        ChartsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tvResultCell"];
        
        TvVoteModel *model = _resultData[indexPath.row];
        cell.tvModel = model;
        
        return cell;
    }
    
    TVToupiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toupiaoActionCell"];
    cell.model = _data[indexPath.row];
    return cell;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark ----------------弹窗投票结果

- (void)alertReresultListByID:(NSString *)Id{
    
    
    
    GOLFWeakObj(self);
    [ShareBusinessManager.tvManager postTvVoteResultWithParameters:@{@"activityId":Id,
                                                                     @"currentPage":@1,
                                                                     @"pageSize":@5}
                                                           success:^(id responObject) {
                                                               [_resultData removeAllObjects];
                                                               [_resultData addObjectsFromArray:responObject];
                                                               [weakself.resultTablView reloadData];
                                                               weakself.alertView = [[STL_AlertCustomView alloc] initWithFrame:[UIScreen mainScreen].bounds customView:weakself.resultView];
                                                               weakself.lookAllBtn.tag = Id.integerValue;
                                                               [weakself.alertView setBackContentColor:[UIColor clearColor]];
                                                               [weakself.alertView show];
                                                               
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           }];
    
}

#pragma mark ----------------实例

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TVToupiaoTableViewCell class] forCellReuseIdentifier:@"toupiaoActionCell"];
    }
    return _tableView;
}

- (UIView *)resultView{
    if (!_resultView) {
        _resultView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 550 *KHeight_Scale)];
        [_resultView addSubview:self.resultTablView];
        [_resultView addSubview:self.headIv];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH - 60, 50)];
        view.backgroundColor = WHITECOLOR;
        [view addSubview:self.lookAllBtn];
        [_resultView addSubview:view];
        
        self.lookAllBtn.sd_layout
        .centerYEqualToView(view)
        .centerXEqualToView(view)
        .heightIs(30)
        .widthIs(SCREEN_WIDTH - 115);
    }
    return _resultView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 150 *KHeight_Scale)];
        [_headIv setImage:IMAGE(@"classify225")];
        [_headIv setBackgroundColor:[UIColor clearColor]];
        
    }
    return _headIv;
}

- (UITableView *)resultTablView{
    if (!_resultTablView) {
        _resultTablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150 *KHeight_Scale, SCREEN_WIDTH - 60, 350 *KHeight_Scale)];
        _resultTablView.delegate = self;
        _resultTablView.dataSource= self;
        _resultTablView.separatorInset = UIEdgeInsetsZero;
        _resultTablView.separatorColor = GRAYCOLOR;
    
        [_resultTablView registerClass:[ChartsTableViewCell class] forCellReuseIdentifier:@"tvResultCell"];
        _resultTablView.emptyDataSetSource = self;
        _resultTablView.emptyDataSetDelegate = self;
        _resultTablView.tableFooterView = [UIView new];
    }
    return _resultTablView;
}

- (UIButton *)lookAllBtn{
    if (!_lookAllBtn) {
        _lookAllBtn = [[UIButton alloc] init];
        [_lookAllBtn setBackgroundColor:RGBColor(253, 147, 41)];
        _lookAllBtn.titleLabel.font = FONT(14);
        [_lookAllBtn setTitle:@"全部投票结果" forState:UIControlStateNormal];
        [_lookAllBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        
        _lookAllBtn.layer.shadowColor = RGBColor(253, 125, 38).CGColor;
        _lookAllBtn.layer.shadowOffset = CGSizeMake(0, 4);
        _lookAllBtn.layer.shadowRadius = 3;
        
        _lookAllBtn.layer.cornerRadius = 3;
        [_lookAllBtn addTarget:self action:@selector(lookForAllResultAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookAllBtn;

}

@end
