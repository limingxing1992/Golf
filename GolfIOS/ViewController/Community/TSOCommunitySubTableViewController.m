//
//  TSOCommunitySubTableViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/7.
//  Copyright © 2016年 TSou. All rights reserved.
//我的关注

#import "TSOCommunitySubTableViewController.h"
#import "TSOHomeCommunityTableViewCell.h"
#import "CommunityArticleModel.h"
#import "TSOCommunityTopicViewController.h"

@interface TSOCommunitySubTableViewController ()
<TSOHomeCommunityTableViewCellDelegate>

/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

@end

static NSString *const kTSOHomeCommunityTableViewCell = @"kTSOHomeCommunityTableViewCell";

@implementation TSOCommunitySubTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    weak(self);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (IsLogin) {
            [weakSelf requestData];
        }else{
            [STL_CommonIdea alertWithTarget:weakSelf Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
                
            } block_1:^{
                
            }];
            
        }
        [self setPlaceHolderView];
        
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        if (IsLogin) {
            [weakSelf requestData];
        }else{
            [STL_CommonIdea alertWithTarget:weakSelf Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
                
            } block_1:^{
                
            }];
            
        }
        [self setPlaceHolderView];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    [self.tableView registerClass:[TSOHomeCommunityTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
    
    [self.tableView.mj_header beginRefreshing];
}



- (void)requestData{
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],@"pageSize":PAGESIZE.stringValue};
    
    [ShareBusinessManager.communityManager getMyAttentionWithParameters:parameter success:^(id responObject) {
         CommunityArticleModel *model = (CommunityArticleModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                
            }
            if (self.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            
            NSInteger cellCount = self.view.frame.size.height /100;//test
            if (model.data.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer setState:MJRefreshStateIdle];
            }
            
            [self.tableView reloadData];

        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self setPlaceHolderView];

    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
        [self setPlaceHolderView];
    }];
}

//MARK: - function
- (void)setPlaceHolderView{
    if (self.dataList.count == 0) {
        UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        placeHoderImageView.image = EmptyImage;
        self.tableView.tableFooterView = placeHoderImageView;
    }else{
        self.tableView.tableFooterView = [UIView new];
    }
}

//MARK: - TSOHomeCommunityTableViewCellDelegate


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityArticle *model;
    if (_dataList.count >0) {
        model = _dataList[indexPath.row];
    }
    TSOCommunityTopicViewController *topicVC = [[TSOCommunityTopicViewController alloc] initWithCommunityArticleID:model.ID.stringValue];
    
    [topicVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:topicVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommunityArticle *model;
    if (_dataList.count >0) {
        model = _dataList[indexPath.row];
    }
    
    TSOHomeCommunityTableViewCell *communityCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeCommunityTableViewCell];
    communityCell.delegate = self;
    communityCell.model = model;
    [communityCell hideFocusBtn];
    return communityCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

@end
