//
//  TSOPersonalScoreRecordViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOPersonalScoreRecordViewController.h"
#import "TSOPersonalScoreHeadCell.h"
#import "TSOPersonalScoreCell.h"
#import "ScoreRecordModel.h"
#import "TSOScoringViewController.h"
#import "StandardHoleListModel.h"
#import "ScoreInfo.h"
#import "TSORecordViewController.h"

@interface TSOPersonalScoreRecordViewController ()
<UITableViewDataSource,UITableViewDelegate>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataArr*/
@property (nonatomic, strong) NSMutableArray *dataList;

/**计分记录列表模型*/
@property (nonatomic, strong) ScoreRecordModel *model;
/**标准杆模型*/
@property (nonatomic, strong) StandardHoleListModel *standardHolesModel;

@end

static NSString *const kTSOPersonalScoreHeadCell = @"kTSOPersonalScoreHeadCell";
static NSString *const kTSOPersonalScoreCell = @"kTSOPersonalScoreCell";

@implementation TSOPersonalScoreRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.page = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self requestStandardHoleList];
}

- (void)requestData{
    
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",self.page],
                                @"pageSize":@"15"};
    
    [ShareBusinessManager.scoreManager getScoreRecordListWithParameters:parameter success:^(id responObject) {
        ScoreRecordModel *model = (ScoreRecordModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.model = model;
            [self.dataList addObjectsFromArray:model.data.scoreRecordList];
            self.page ++;
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            //FIXME: - 设置空页面
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }

    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 20.0)];
        customView.backgroundColor = BACKGROUNDCOLOR;
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        headerLabel.textColor = SHENTEXTCOLOR;
        headerLabel.font = [UIFont boldSystemFontOfSize:12];
        headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 20.0);
        
        if (section == 1){
            headerLabel.text = @"计分统计";
        }
        [customView addSubview:headerLabel];
        
        return customView;
    }else{
        return nil;
    }
    
}

//请求当前球场的标准杆数
- (void)requestStandardHoleList{
    [ShareBusinessManager.scoreManager getStandatdHoleListWithParameters:nil success:^(id responObject) {
        StandardHoleListModel *model = (StandardHoleListModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            self.standardHolesModel = model;
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//请求当前场次的计分详情
- (void)requestScoreDetailWithGroupId:(ScoreRecord *)groupMode{
    
    NSDictionary *parameter = @{@"groupId":groupMode.groupId};
    [ShareBusinessManager.scoreManager getGroupScoreDetailWithParameters:parameter success:^(id responObject) {
        ScoreInfo *info = (ScoreInfo *)responObject;
        if (info.errorCode.integerValue == 1) {
            //如果是比赛创建者跳转计分页面
            if (groupMode.createor && groupMode.status.integerValue != 20) {
                
                info.data.groupId = groupMode.groupId;
                TSOScoringViewController *scoreVC = [[TSOScoringViewController alloc] initWithScoreInfo:info];
                scoreVC.standHolesModel = self.standardHolesModel;
                scoreVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:scoreVC animated:YES];
            }else{//如果是比赛参与者 跳转到分数统计页面
         
                TSORecordViewController *recordVC = [[TSORecordViewController alloc] initReadOnlyView:YES];
                recordVC.model = info;
                
                [self presentViewController:recordVC animated:YES completion:nil];
            }
            [SVProgressHUD dismiss];
            
        }else{
            [SVProgressHUD showErrorWithStatus:info.errorMsg];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

//进入界面直接旋转的方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

//MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [SVProgressHUD showWithStatus:@"读取比赛信息"];
        if (self.standardHolesModel) {
            if (self.dataList.count >0) {
                ScoreRecord *model = self.dataList[indexPath.row];
                [self requestScoreDetailWithGroupId:model];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"请检查网络,刷新页面"];
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 20.0;
    }else{
        return 0;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.dataList.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TSOPersonalScoreHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:kTSOPersonalScoreHeadCell];
        cell.averageStr = self.model.data.userMaxBar;
        return cell;
    }else{
        
        ScoreRecord *model;
        if (self.dataList.count > 0) {
            model = self.dataList[indexPath.row];
        }
        TSOPersonalScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kTSOPersonalScoreCell];
        cell.model = model;
        
        return cell;
    }
    
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return YES;
    }else{
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   
    [self.dataList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    ScoreRecord *model = self.dataList[indexPath.row];
    NSDictionary *dict = @{@"recordId":model.ID};
    //先删除再调用删除接口
    [ShareBusinessManager.scoreManager deleteScoreRecordWithParameters:dict success:^(id responObject) {
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
    return height;
}



#pragma mark - Setter&Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOPersonalScoreHeadCell class] forCellReuseIdentifier:kTSOPersonalScoreHeadCell];
        [_tableView registerClass:[TSOPersonalScoreCell class] forCellReuseIdentifier:kTSOPersonalScoreCell];
        
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

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
