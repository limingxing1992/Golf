//
//  MyClubViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubViewController.h"
#import "MyClubHeaderView.h"
#import "MyClubListViewController.h"
#import "MyClubDetailViewController.h"
#import "TSOClubHomePageViewController.h"
#import "MyClubCreatClubViewController.h"

#import "MyClubArticleTableViewCell.h"
#import "TSOClubNoticeDetailViewController.h"

@interface MyClubViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
YB_SliderBtnViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate,
MyClubHeaderViewDelegate
>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;
/**顶部按钮选择*/
@property (nonatomic, strong) YB_SliderBtnView *btnView;
/**容器*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/** 已加入视图*/
@property (nonatomic, strong) MyClubHeaderView *myJoinedView;
/** 已创建视图*/
@property (nonatomic, strong) MyClubHeaderView *myCreatedView;
/** 存放已加入的数据*/
@property (nonatomic, strong) NSMutableArray *JoinedListData;
/** 存放已创建的数据*/
@property (nonatomic, strong) NSMutableArray *CreatedListData;

/** 记录已加入视图的高度*/
@property (nonatomic, assign) CGFloat JoinedViewHeight;
/** 记录已加入视图的高度*/
@property (nonatomic, assign) CGFloat CreatedViewHeight;


/**page*/
@property (nonatomic, assign) NSInteger page;
/**page*/
@property (nonatomic, assign) NSInteger createdPage;
/**page*/
@property (nonatomic, assign) NSInteger joinedPage;
/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end

static  NSString *const kTSOHomeCommunityTableViewCell = @"kTSOHomeCommunityTableViewCell";
static  NSString *const kSectionTitleTableViewCell = @"kSectionTitleTableViewCell";

@implementation MyClubViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的俱乐部";
    self.rightStr_0 = @"创建";
    self.page = 1;
    self.joinedPage = 1;
    self.createdPage = 1;
    self.isAutoBack = NO;
    
    [self loadMyjoinedListData];
    [self requestData];
    
    [self setupUI];
    
    //注册通知
    [GOLFNotificationCenter addObserver:self selector:@selector(updateCreatedView) name:@"updateCreatedClubList" object:nil];
}

-(void)updateCreatedView{
    
    [self loadMyCreatedListData];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark - 创建俱乐部（跳转控制器）
-(void)right_0_action{
    
    MyClubCreatClubViewController *vc = [[MyClubCreatClubViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupUI{
    self.view.backgroundColor = BACKGROUNDCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.btnView];
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - 请求俱乐部帖子的数据
- (void)requestData{
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    GOLFWeakObj(self);
    NSDictionary *parameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE.stringValue};
    //我的帖子
    [ShareBusinessManager.userManager postMyArticleListWithParameters:parameter success:^(id responObject) {
        
        [weakself.dataList addObjectsFromArray:responObject];
        if (weakself.dataList.count > 0) {
            weakself.page ++;
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer setState:MJRefreshStateIdle];
            [weakself.tableView reloadData];
        }else{
             weakself.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [weakself.tableView.mj_footer endRefreshing];
    }];
    
    
}

#pragma mark - 请求已加入俱乐部的数据
-(void)loadMyjoinedListData{
    
    self.joinedPage = 1;
    [self.JoinedListData removeAllObjects];
    //参数字段
    NSDictionary *joinedParameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_joinedPage],
                                      @"pageSize":PAGESIZE.stringValue};
    //已加入
    [ShareBusinessManager.userManager postMyClubJoinedListWithParameters:joinedParameter success:^(id responObject) {
        //遍历数据模型数组
        for (MyClubItemModel *model in responObject) {
            [self.JoinedListData addObject:model];
        }
        NSLog(@"----------已加入----------%@",self.JoinedListData);
        [self setJoinedView];
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];

}

#pragma mark - 请求已创建俱乐部的数据
-(void)loadMyCreatedListData{
    
    self.createdPage = 1;
        
    [self.CreatedListData removeAllObjects];

    //参数字段
    NSDictionary *createdParameter = @{@"currentPage":[NSString stringWithFormat:@"%zd",_createdPage],
                                       @"pageSize":PAGESIZE.stringValue};
    //已创建
    [ShareBusinessManager.userManager postMyClubCreatedListWithParameters:createdParameter success:^(id responObject) {
        //遍历数据模型数组
        for (MyClubItemModel *model in responObject) {
            [self.CreatedListData addObject:model];
        }
        NSLog(@"----------已创建----------%@",self.CreatedListData);
        [self setCreatedView];
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];

}

#pragma mark - 通过数组模型获取滚动视图的高度
-(CGFloat)getHeightFromDataList:(NSArray*)datalist{
    CGFloat ScrollViewHeight;
    if (datalist.count == 0) {
        ScrollViewHeight = 0.0f;
    }else if(datalist.count <= 2){
        ScrollViewHeight = 98.0f;
    }else{
        ScrollViewHeight = 158.0f;
    }
    return ScrollViewHeight;
}

-(void)setCreatedView{
    _CreatedViewHeight = [self getHeightFromDataList:self.CreatedListData];
    self.contentScrollView.frame = CGRectMake(0, 109, SCREEN_WIDTH, _CreatedViewHeight);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, _CreatedViewHeight);
    [self.contentScrollView addSubview:self.myCreatedView];
    self.myCreatedView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _CreatedViewHeight);
    self.myCreatedView.DataList = self.CreatedListData;
    
    [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = CGRectMake(0, 109 + _CreatedViewHeight,SCREEN_WIDTH, SCREEN_HEIGHT - _CreatedViewHeight - 109);
    }];
}


-(void)setJoinedView{
    
    //计算高度
    _JoinedViewHeight = [self getHeightFromDataList:self.JoinedListData];
    //设置大小
    self.contentScrollView.frame = CGRectMake(0, 109, SCREEN_WIDTH, _JoinedViewHeight);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, _JoinedViewHeight);
    [self.contentScrollView addSubview:self.myJoinedView];
    self.myJoinedView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _JoinedViewHeight);
    self.myJoinedView.DataList = self.JoinedListData;
    
    
    [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = CGRectMake(0, 109 + _JoinedViewHeight,SCREEN_WIDTH, SCREEN_HEIGHT - _JoinedViewHeight - 109);
    }];
}



#pragma mark - YB_SliderBtnViewDelegate
- (void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button{
    if (button.tag == 0) {//已加入
        [self loadMyjoinedListData];
    }else if (button.tag == 1){
        //创建
        [self loadMyCreatedListData];
    }
}
#pragma mark - 空白页代理

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return EmptyImage;
}

#pragma mark - 头部按钮点击的代理
-(void)MyClubHeaderView:(MyClubHeaderView *)MyClubHeaderView btnDidClickWithClubModel:(MyClubItemModel *)model btnTag:(NSInteger)btnTag{
    
    if (MyClubHeaderView == self.myJoinedView) {
        if (btnTag == 101) {//跳转到列表视图
            MyClubListViewController *vc = [[MyClubListViewController alloc] init];
            vc.pageColumn = 0;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //跳转到对应创建的俱乐部的详细视图
            TSOClubHomePageViewController *vc = [[TSOClubHomePageViewController alloc] initWithClubID:model.clubId];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }else{
        if (btnTag == 101) {
            //跳转到列表视图
            MyClubListViewController *vc = [[MyClubListViewController alloc] init];
            vc.pageColumn = 1;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //跳转到对应创建的俱乐部的详细视图
            MyClubDetailViewController  *vc = [[MyClubDetailViewController alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyArticleItemModel *model;
    if (_dataList.count >0) {
        model = _dataList[indexPath.row];
    }
    TSOClubNoticeDetailViewController *topicVC = [[TSOClubNoticeDetailViewController alloc] initWithArticleID:model.ID];
    [self.navigationController pushViewController:topicVC animated:YES];
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataList.count != 0) {
        return 2;
    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }else{
        return self.dataList.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height;
    if (section == 0) {
        return 10;
    }
    if (section == 1) {
        height = 0.5f;
    }
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0){
        
        UITableViewCell *myArticleCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSectionTitleTableViewCell];
        myArticleCell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
        myArticleCell.textLabel.font = FONT(15);//设置标题大小
        myArticleCell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
        myArticleCell.userInteractionEnabled = NO;
        myArticleCell.textLabel.text = @"我的帖子";
        return myArticleCell;
        
    }else if(indexPath.section == 1){
        //帖子
        MyArticleItemModel *model;
        if (_dataList.count >0) {
            model = _dataList[indexPath.row];
        }
        
        MyClubArticleTableViewCell *communityCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeCommunityTableViewCell];
        communityCell.model = model;
        return communityCell;

    }
    
    return [[UITableViewCell alloc] init];
}


#pragma mark - Setteer&Getter

- (YB_SliderBtnView *)btnView{
    if (_btnView == nil) {
        _btnView = [[YB_SliderBtnView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
        [_btnView setButtonTitleArray:@[@"已加入",@"已创建"] ];
        _btnView.delegate = self;
    }
    return _btnView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_footer.automaticallyHidden = YES;
        
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestData];
            [weakSelf.tableView.mj_footer endRefreshing];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
        
        [_tableView registerClass:[MyClubArticleTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSectionTitleTableViewCell];
        
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

- (MyClubHeaderView *)myCreatedView{
    if (_myCreatedView== nil) {
        _myCreatedView = [[MyClubHeaderView alloc] init];
        _myCreatedView.delegate = self;
    }
    return _myCreatedView;
}

-(MyClubHeaderView *)myJoinedView{
    if (!_myJoinedView) {
        _myJoinedView = [[MyClubHeaderView alloc] init];
        _myJoinedView.delegate = self;
    }
    return _myJoinedView;
}

- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSMutableArray alloc] init];
        
    }
    return _dataList;
}

- (NSMutableArray *)JoinedListData{
    if (_JoinedListData== nil) {
        _JoinedListData = [[NSMutableArray alloc] init];
    }
    return _JoinedListData;
}
-(NSMutableArray *)CreatedListData{
    if (_CreatedListData== nil) {
        _CreatedListData = [[NSMutableArray alloc] init];
    }
    return _CreatedListData;
}

@end
