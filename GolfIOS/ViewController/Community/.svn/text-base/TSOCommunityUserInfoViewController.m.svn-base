//
//  TSOCommunityUserInfoViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOCommunityUserInfoViewController.h"
#import "TSOUserCommentCell.h"
#import "TSOUserPublishedTopicCell.h"

#import "CommunityUserDeailModel.h"
#import "CommunityArticleModel.h"

#import "TSOCommunityMySpaceViewController.h"//test

@interface TSOCommunityUserInfoViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

/**顶部用户信息View*/
@property (nonatomic, strong) TSOCommunityUserInfoView *topUserInfoView;
/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**选择*/
@property (nonatomic, strong) YB_SliderBtnView *chooseView;
/**我的帖子*/
@property (nonatomic, strong) UILabel *myArticleLb;
/**用户id*/
@property (nonatomic, strong) NSString *userID;
/**page*/
@property (nonatomic, assign) NSInteger page;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;


@end


static  NSString *const kTSOUserPublishedTopicCell = @"kTSOUserPublishedTopicCell";
@implementation TSOCommunityUserInfoViewController

- (instancetype)initWithUserID:(NSString *)ID{
    if (self = [super init]) {
        self.userID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    self.page = 1;
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.topUserInfoView];
    [self.view addSubview:self.myArticleLb];
    [self.view addSubview:self.tableView];

    self.myArticleLb.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.topUserInfoView, 0.5)
    .rightEqualToView(self.view)
    .heightIs(44);
    
    self.tableView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.myArticleLb, 0.5)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    [self.topUserInfoView focusBtnAddTarget:self action:@selector(addAttention)];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self requestcommunityUserDeail];
    [self requestUserCommunityArticleList];
}

//MARK: - Action
- (void)addAttention{
    if (IsLogin) {
        if (self.topUserInfoView.model.isfollow == YES) {
            [ShareBusinessManager.userManager postMyAttentionRemoveWithParameters:@{@"userId":self.topUserInfoView.model.ID} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                [self requestcommunityUserDeail];
                
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }else{
            [ShareBusinessManager.userManager postMyAttentionAddWithParameters:@{@"userId":self.topUserInfoView.model.ID} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
               [self requestcommunityUserDeail];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
}

#pragma mark - 网络请求

- (void)requestcommunityUserDeail{
    
    
    NSDictionary *parameter = @{@"myUserId":[UserModel sharedUserModel].ID,
                                @"userId":self.userID};
    NSLog(@"%@==========",parameter);
    [ShareBusinessManager.communityManager getcommunityUserDeailWithParameters:parameter success:^(id responObject) {
        CommunityUserDeailModel *model = (CommunityUserDeailModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.topUserInfoView.model = model.data;
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        
    }];
    
    
}

- (void)requestUserCommunityArticleList{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue,
                                @"userId":self.userID};
   
    [ShareBusinessManager.communityManager getUserCommunityArticleListWithParameters:parameter success:^(id responObject) {
        CommunityArticleModel *model = (CommunityArticleModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            
            if (model.data.dataList.count > 0) {
                
                [self.dataList addObjectsFromArray:model.data.dataList];
                self.page ++;
                [self.tableView reloadData];
            }
            if (model.data.dataList.count < PAGESIZE.integerValue) {
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

#pragma mark - Setter&Getter

- (TSOCommunityUserInfoView *)topUserInfoView{
    if (_topUserInfoView == nil) {
        _topUserInfoView = [[TSOCommunityUserInfoView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 68)];

    }
    return _topUserInfoView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
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

- (YB_SliderBtnView *)chooseView{
    if (_chooseView == nil) {
        _chooseView = [[YB_SliderBtnView alloc] initWithFrame:CGRectMake(0, 73 + 63, SCREEN_WIDTH, 44)];
        [_chooseView setButtonTitleArray:@[@"帖子",@"评价"]];
       
    }
    return _chooseView;
}

- (UILabel *)myArticleLb{
    if (_myArticleLb == nil) {
        _myArticleLb = [[UILabel alloc] init];
        _myArticleLb.backgroundColor = WHITECOLOR;
        _myArticleLb.text = @"    我的帖子";
        _myArticleLb.font = FONT(14);
        _myArticleLb.textColor = LIGHTTEXTCOLOR;
    }
    return _myArticleLb;
}


- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}

@end
