//
//  TSOClubViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubViewController.h"
#import "UIImage+Image.h"
#import "TSOClubPublishTopicViewController.h"
#import "TSOClubNoticeDetailViewController.h"
#import "ClubArticleModel.h"
#import "ClubArticle.h"
#import "TSOClubJoinedTableViewController.h"
#import "TSOClubSearchResultTableViewController.h"

@interface TSOClubViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
YB_SliderBtnViewDelegate,
UISearchResultsUpdating,
UISearchResultsUpdating


>


/**顶部选择栏目视图*/
@property (nonatomic, strong) YB_SliderBtnView *btnView;
/**推荐tableview*/
@property (nonatomic, strong) UITableView *tableView;

/**已加入*/
@property (nonatomic, strong) TSOClubJoinedTableViewController *joinedVC;

/**搜索控制器*/
@property (nonatomic, strong) UISearchController *searchVC;

/**网络请求练得数据*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

/**容器视图*/
@property (nonatomic, strong) UIScrollView *contentScrollView;


/**搜索结果显示控制器*/
@property (nonatomic, strong) TSOClubSearchResultTableViewController *resultVC;
/**搜索结果*/
@property (nonatomic, strong) NSMutableArray *searchDataList;

@end

@implementation TSOClubViewController

static NSString *const kTSOClubTableViewCell = @"kTSOClubTableViewCell";

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
}

- (void)setupNav{
    [super setupNav];
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    publishBtn.titleLabel.font = FONT(14);
    [publishBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    [publishBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishNewTopic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:publishBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setupUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.btnView];
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    [self.view addSubview:searchBarView];
    [searchBarView addSubview:self.searchVC.searchBar];
    
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.frame = CGRectMake(0, 152, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_btnView.frame));
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - CGRectGetMaxY(_btnView.frame));
    [self.contentScrollView addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    self.joinedVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 数据请求
//请求"推荐"数据 只有公告
- (void)requestArticleData{
    
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    NSDictionary *parameters = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                 @"pageSize":PAGESIZE.stringValue};
//    NSLog(@"请求推荐数据参数%@",parameters);
    [ShareBusinessManager.clubManager getClubRecommendNoticeListWithParameters:parameters success:^(id responObject) {
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
            NSInteger cellCount = self.contentScrollView.frame.size.height /100;
            if (self.dataList.count < cellCount +1) {
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
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        if (self.dataList.count == 0) {
            UIImageView *placeHoderImageView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
            placeHoderImageView.image = EmptyImage;
            self.tableView.tableFooterView = placeHoderImageView;
        }else{
            self.tableView.tableFooterView = [UIView new];
        }
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [_tableView.mj_footer endRefreshing];
    }];
    
}

//#pragma mark - DZNEmptyDataSetSource
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//    return EmptyImage;
//}
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
//    return WHITECOLOR;
//}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self.searchDataList removeAllObjects];
    NSString *searchString = [searchController.searchBar text];
    NSDictionary *parameter = @{@"searchName":searchString};
    
    
    if (searchString.length > 0) {
        [ShareBusinessManager.clubManager searchClubArticleListWithParameters:parameter success:^(id responObject) {
            ClubArticleModel *model = (ClubArticleModel *)responObject;
            if (model.errorCode.integerValue == 1) {
                if (model.data.dataList > 0) {
                    [self.searchDataList addObjectsFromArray:model.data.dataList];
                }
            }
            self.resultVC.searchDataList = self.searchDataList;
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }
    
}

#pragma mark - YB_SliderBtnViewDelegate

-(void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button{

    if (button.tag == 0) {//推荐
        
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (button.tag == 1){//已加入
        [self addChildViewController:self.joinedVC];
        [self.contentScrollView addSubview:self.joinedVC.tableView];
        [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH *1, 0) animated:YES];
        
    }
    
}
#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ClubArticle *model = self.dataList[indexPath.row];
    TSOClubTableViewCell *clubCell = [tableView dequeueReusableCellWithIdentifier:kTSOClubTableViewCell];
    model.from = @0;
    clubCell.model = model;
    return clubCell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticle *model;
    if (self.dataList.count >0 ) {
        model = self.dataList[indexPath.row];
    }
    
    TSOClubNoticeDetailViewController *noticeVC = [[TSOClubNoticeDetailViewController alloc] initWithArticleID:model.ID.stringValue];
    noticeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:noticeVC animated:YES];
}



#pragma mark - Action

//发帖
- (void)publishNewTopic{
    if (IsLogin) {
        TSOClubPublishTopicViewController *topicVC = [[TSOClubPublishTopicViewController alloc] init];
        topicVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topicVC animated:YES];
    }else{
        
        weak(self);
        [STL_CommonIdea alertWithTarget:weakSelf Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
            
        } block_1:^{
            
        }];
    }
    
}

#pragma mark - Setter&Getter


- (YB_SliderBtnView *)btnView{
    if (_btnView == nil) {
        _btnView = [[YB_SliderBtnView alloc] init];
        _btnView.frame = CGRectMake(0, 108, SCREEN_WIDTH, 44);
        _btnView.delegate = self;
        [_btnView setButtonTitleArray:@[@"推荐",@"已加入"]];
    }
    return _btnView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.emptyDataSetSource = self;
//        _tableView.emptyDataSetDelegate = self;
       
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        [_tableView registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:kTSOClubTableViewCell];
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestArticleData];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestArticleData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (UISearchController *)searchVC{
    if (_searchVC == nil) {
        _searchVC = [[UISearchController alloc] initWithSearchResultsController:self.resultVC];
        
        _searchVC.searchResultsUpdater = self;
        
        _searchVC.view.backgroundColor = BACKGROUNDCOLOR;
        _searchVC.hidesNavigationBarDuringPresentation = YES;//
        self.definesPresentationContext = YES;//
        UISearchBar *bar = _searchVC.searchBar;
        bar.barStyle = UIBarStyleDefault;
        
        bar.placeholder = @"输入您要搜索的内容";
        UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
        view.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        view.layer.borderWidth = 1;
        bar.translucent = YES;
        bar.barTintColor = BACKGROUNDCOLOR;
        bar.tintColor = GLOBALCOLOR;
        CGRect rect = bar.frame;
        rect.size.height = 45;
        bar.frame = rect;
        
    }
    return _searchVC;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
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

- (TSOClubJoinedTableViewController *)joinedVC{
    if (_joinedVC == nil) {
        _joinedVC = [[TSOClubJoinedTableViewController alloc] init];
        
    }
    return _joinedVC;
}



- (TSOClubSearchResultTableViewController *)resultVC{
    if (_resultVC == nil) {
        _resultVC = [[TSOClubSearchResultTableViewController alloc] init];
        weak(self);
        _resultVC.callBack = ^(ClubArticle *model){
            TSOClubNoticeDetailViewController *noticeVC = [[TSOClubNoticeDetailViewController alloc] initWithArticleID:model.ID.stringValue];
            noticeVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:noticeVC animated:YES];
        };
    }
    return _resultVC;
}

- (NSMutableArray *)searchDataList{
    if (_searchDataList == nil) {
        _searchDataList = [[NSMutableArray alloc] init];
        
    }
    return _searchDataList;
}
@end
