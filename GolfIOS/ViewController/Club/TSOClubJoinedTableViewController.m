//
//  TSOClubJoinedTableViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOClubJoinedTableViewController.h"
#import "ClubArticleModel.h"
#import "ClubArticle.h"
#import "TSOClubNoticeDetailViewController.h"

@interface TSOClubJoinedTableViewController ()


/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

@end
static NSString *const kTSOClubTableViewCell = @"kTSOClubTableViewCell";
@implementation TSOClubJoinedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
    weak(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (IsLogin) {
            [weakSelf requestjoinClubArticleList];
        }else{
            [STL_CommonIdea alertWithTarget:weakSelf Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
                
            } block_1:^{
                
            }];
            

        }
        [self setPlaceHolederView];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;

        if (IsLogin) {
            [weakSelf requestjoinClubArticleList];
            
        }else{
            [STL_CommonIdea alertWithTarget:weakSelf Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
                
            } block_1:^{
                
            }];
            
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [self setPlaceHolederView];
    }];
    
    [self.tableView registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:kTSOClubTableViewCell];
    
   [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//请求"已加入"数据 包含帖子和公告
- (void)requestjoinClubArticleList{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.clubManager getJoinedClubArticleListWithParameters:parameter success:^(id responObject) {
        ClubArticleModel *model = (ClubArticleModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                
            }
            if (model.data.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            NSInteger cellCount = self.view.frame.size.height /100;
            if (self.dataList.count < cellCount + 1) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            [self.tableView reloadData];

        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self setPlaceHolederView];
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [self setPlaceHolederView];
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
    }];

}

//MARK: - function
- (void)setPlaceHolederView{
    if (self.dataList.count == 0) {
        UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        placeHoderImageView.image = EmptyImage;
        self.tableView.tableFooterView = placeHoderImageView;
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ClubArticle *model = self.dataList[indexPath.row];
    TSOClubTableViewCell *clubCell = [tableView dequeueReusableCellWithIdentifier:kTSOClubTableViewCell];
    
    clubCell.model = model;
    return clubCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticle *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    
    TSOClubNoticeDetailViewController *noticeVC = [[TSOClubNoticeDetailViewController alloc] initWithArticleID:model.ID.stringValue];
    noticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
