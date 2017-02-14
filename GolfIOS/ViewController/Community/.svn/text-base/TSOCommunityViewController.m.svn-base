//
//  TSOCommunityViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/10/25.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOCommunityViewController.h"
#import "TSOCommunityTopicViewController.h"
#import "TSOPublishTopicViewController.h"
#import "TSOCommunitySubTableViewController.h"
#import "CommunityArticleModel.h"

@interface TSOCommunityViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
YB_SliderBtnViewDelegate,
TSOHomeCommunityTableViewCellDelegate
>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**顶部按钮选择*/
@property (nonatomic, strong) YB_SliderBtnView *btnView;
/**容器*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**我的关注控制器*/
@property (nonatomic, strong) TSOCommunitySubTableViewController *myAttentionVC;
/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;


/**是否隐藏底部tabbar*/
@property (nonatomic, assign) BOOL isHideBottomBar;

@end

static  NSString *const kTSOHomeCommunityTableViewCell = @"kTSOHomeCommunityTableViewCell";

@implementation TSOCommunityViewController

#pragma mark - LifeCycle

- (instancetype)initHideBottomBarPage{
    if (self = [super init]) {
        _isHideBottomBar = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupUI];
    self.page = 1;
    
    
}

- (void)setupUI{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.btnView];
    [self.view addSubview:self.tableView];
    
    
    [self.view addSubview:self.contentScrollView];
    if (_isHideBottomBar) {
        self.contentScrollView.frame = CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT - 64 -45);
    }else{
        self.contentScrollView.frame = CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT - 109 -45);
    }
    
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - 109-45);
    [self.contentScrollView addSubview:self.tableView];
    self.tableView.frame = self.contentScrollView.bounds;
    
}

- (void)setupNav{
    [super setupNav];
    if (!_isHideBottomBar) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    publishBtn.titleLabel.font = FONT(14);
    [publishBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    [publishBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishNewTopic:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 请求数据

- (void)requestData{
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [@{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue,
                                } mutableCopy];
    if (IsLogin) {
        [parameter setObject:[UserModel sharedUserModel].ID forKey:@"userId"];
    }
    [ShareBusinessManager.communityManager getCommunityArticleListWithParameters:parameter success:^(id responObject) {
        CommunityArticleModel *model = (CommunityArticleModel *)responObject;
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
            NSInteger cellCount = self.view.frame.size.height /100;//test
            if (self.dataList.count < cellCount) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            
            [self.tableView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }
        
        
        if (self.dataList.count == 0) {
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.contentScrollView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.dataList.count == 0) {
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.contentScrollView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
    }];
}

#pragma mark - YB_SliderBtnViewDelegate
- (void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button{
    
    if (button.tag == 0) {//推荐
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (button.tag == 1){//已加入
        
        [self addChildViewController:self.myAttentionVC];
        [self.contentScrollView addSubview:self.myAttentionVC.tableView];
        self.myAttentionVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.mj_h);
        [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

//MARK: - TSOHomeCommunityTableViewCellDelegate

-(void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell focusBtnDidClick:(NSString *)userId{
    
    if (IsLogin) {
        
        //判断是已关注还是取消关注
        NSMutableArray *changeCells = [[NSMutableArray alloc] init];
        
        if (cell.model.isfollow == YES) {
            [ShareBusinessManager.userManager postMyAttentionRemoveWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                
                for (int idx = 0; idx<self.dataList.count; idx++) {
                    CommunityArticle *model = self.dataList[idx];
                    if ([model.userId isEqualToNumber:cell.model.userId]) {
                        model.isfollow = NO;
                        [changeCells addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                    }
                }
                [self.tableView reloadRowsAtIndexPaths:changeCells withRowAnimation:UITableViewRowAnimationFade];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                
                
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }else{
            [ShareBusinessManager.userManager postMyAttentionAddWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                for (int idx = 0; idx<self.dataList.count; idx++) {
                    CommunityArticle *model = self.dataList[idx];
                    if ([model.userId isEqualToNumber:cell.model.userId]) {
                        model.isfollow = YES;
                        [changeCells addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
                    }
                }
                 [self.tableView reloadRowsAtIndexPaths:changeCells withRowAnimation:UITableViewRowAnimationFade];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
    
}

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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityArticle *model;
    if (_dataList.count >0) {
        model = _dataList[indexPath.row];
    }
    
    TSOHomeCommunityTableViewCell *communityCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeCommunityTableViewCell];
    communityCell.delegate = self;
    communityCell.model = model;
    
    return communityCell;
}

#pragma mark - Action
- (void)publishNewTopic:(UIButton *)button{
    
    if (IsLogin) {
        TSOPublishTopicViewController *newTopicVC = [[TSOPublishTopicViewController alloc] init];
        newTopicVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newTopicVC animated:YES];
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
   
}


#pragma mark - Setteer&Getter

- (YB_SliderBtnView *)btnView{
    if (_btnView == nil) {
        _btnView = [[YB_SliderBtnView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
        [_btnView setButtonTitleArray:@[@"推荐",@"我的关注"] ];
        _btnView.delegate = self;
    }
    return _btnView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOHomeCommunityTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
        [_tableView registerClass:[TSOHomeCommunityTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
        
    }
    return _tableView;
}

- (UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.backgroundColor = WHITECOLOR;
        _contentScrollView.scrollEnabled = NO;
        _contentScrollView.pagingEnabled = YES;
        
    }
    return _contentScrollView;
}

- (TSOCommunitySubTableViewController *)myAttentionVC{
    if (_myAttentionVC == nil) {
        _myAttentionVC = [[TSOCommunitySubTableViewController alloc] init];
    }
    return _myAttentionVC;
}



- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}
@end
