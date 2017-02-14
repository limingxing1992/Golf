//
//  TSOCommunityMySpaceViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/12/8.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOCommunityMySpaceViewController.h"
#import "TSOUserCommentCell.h"
#import "TSOUserPublishedTopicCell.h"

#import "CommunityUserDeailModel.h"
#import "CommunityArticleModel.h"

#import "CommunityPersonalUserDeailModel.h"
#import "YB_SliderBtnView.h"

@interface TSOCommunityMySpaceViewController ()

<
UITableViewDelegate,
UITableViewDataSource

>

/**顶部用户信息View*/
@property (nonatomic, strong) TSOCommunityUserInfoView *topUserInfoView;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**我的动态标题容器视图*/
@property (nonatomic, strong) UIView *myStatusTopView;
/**我的动态标题*/
@property (nonatomic, strong) YB_SliderBtnView *myStatusTitle;
/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end

static  NSString *const kTSOUserPublishedTopicCell = @"kTSOUserPublishedTopicCell";

@implementation TSOCommunityMySpaceViewController

- (void)viewDidLoad {
    self.page = 1;
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navTitle = @"我的社区";
    [self.view addSubview:self.topUserInfoView];
    [self.view addSubview:self.myStatusTopView];
    [self.myStatusTopView addSubview:self.myStatusTitle];
    [self.view addSubview:self.tableView];
    
    
    [self.topUserInfoView focusNumLabelAddTarget:self action:@selector(toMyFocusPage)];
    [self.topUserInfoView fansNumLabelAddTarget:self action:@selector(toMyFansPage)];
    [self.topUserInfoView collectLabelAddTarget:self action:@selector(toCollectPage)];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self requestcommunityUserDeail];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 网络请求

- (void)requestcommunityUserDeail{
    

    [ShareBusinessManager.communityManager getCommunityPersonalUserDeailWithParameters:nil success:^(id responObject) {
        CommunityPersonalUserDeailModel *model = (CommunityPersonalUserDeailModel *)responObject;
        if (model.errorCode.integerValue == 1) {

            self.topUserInfoView.myModel = model.data;
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    
    
}

- (void)requestUserCommunityArticleList{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue,
                                @"userId":[UserModel sharedUserModel].ID};
    
    [ShareBusinessManager.communityManager getUserCommunityArticleListWithParameters:parameter success:^(id responObject) {
        CommunityArticleModel *model = (CommunityArticleModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                [self.tableView reloadData];
            }
            if (self.dataList.count < PAGESIZE.integerValue) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            
            if (self.dataList.count == 0) {
                self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:EmptyImage];
            }else{
                self.tableView.tableFooterView = [UIView new];
            }
            
            NSInteger cellCount = self.view.frame.size.height /100;//test
            if (model.data.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
                [self.tableView.mj_footer setState:MJRefreshStateIdle];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}




#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityArticle *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    TSOUserPublishedTopicCell *publishCell = [tableView dequeueReusableCellWithIdentifier:kTSOUserPublishedTopicCell];
    publishCell.model = model;
    return publishCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
    return height;
}

#pragma mark - Action

- (void)toMyFocusPage{
    MyAttentionViewController *attentionVc = [[MyAttentionViewController alloc] init];
    [self.navigationController pushViewController:attentionVc animated:YES];
}

- (void)toMyFansPage{
    MyFansViewController *fansVc = [[MyFansViewController alloc] init];
    [self.navigationController pushViewController:fansVc animated:YES];
}

- (void)toCollectPage{
    MyFavoriteViewController *favoriteVC = [[MyFavoriteViewController alloc] init];
    [self.navigationController pushViewController:favoriteVC animated:YES];
}


#pragma mark - Setter&Getter

- (TSOCommunityUserInfoView *)topUserInfoView{
    if (_topUserInfoView == nil) {
        _topUserInfoView = [[TSOCommunityUserInfoView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 68)];
        
    }
    return _topUserInfoView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 182, SCREEN_WIDTH, SCREEN_HEIGHT - 182) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = GRAYCOLOR;
        [_tableView registerClass:[TSOUserPublishedTopicCell class] forCellReuseIdentifier:kTSOUserPublishedTopicCell];
        
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestUserCommunityArticleList];
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestUserCommunityArticleList];
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

- (UIView *)myStatusTopView{
    if (_myStatusTopView == nil) {
        _myStatusTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 137, SCREEN_WIDTH, 45)];
        _myStatusTopView.backgroundColor = WHITECOLOR;
    }
    return _myStatusTopView;
}

- (YB_SliderBtnView *)myStatusTitle{
    if (_myStatusTitle == nil) {
        _myStatusTitle = [[YB_SliderBtnView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.5, 45)];
        [_myStatusTitle setButtonTitleArray:@[@"我的动态"]];
    }
    return _myStatusTitle;
}

@end
