//
//  TSOClubHomePageViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubHomePageViewController.h"
#import "UIImage+Image.h"
#import "TSOClubHeadView.h"
#import "TSOClubTableViewCell.h"
#import "TSOClubIntroductionViewController.h"
#import "TSOClubApplyView.h"
#import "TSOClubApplyStatusViewController.h"
#import "ClubIndexModel.h"
#import "ClubArticleModel.h"
#import "ClubArticle.h"
#import "TSOClubHomePageArticleTableViewController.h"
#import "TSOClubNoticeDetailViewController.h"
#import "SeverStatus.h"


@interface TSOClubHomePageViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIActionSheetDelegate,
TSOClubApplyViewDelegate,
YB_SliderBtnViewDelegate
>

/**俱乐部顶部view*/
@property (nonatomic, strong) TSOClubHeadView *topView;
/**滑动条*/
@property (nonatomic, strong) YB_SliderBtnView *sliderView;
/**tableview*/
@property (nonatomic, strong) UITableView *tableView;
/**蒙版*/
@property (nonatomic, strong) UIView *maskView;

/**俱乐部id*/
@property (nonatomic, strong) NSString *clubID;
/**俱乐部主页模型*/
@property (nonatomic, strong) ClubIndexModel *clubHomePageModel;

/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**page*/
@property (nonatomic, assign) NSInteger page;

/**滚动容器视图*/
@property (nonatomic, strong) UIScrollView *contentScrollView;
/**subVC*/
@property (nonatomic, strong) TSOClubHomePageArticleTableViewController *subVC;

@end

static NSString *const kTSOClubTableViewCell = @"kTSOClubTableViewCell";

@implementation TSOClubHomePageViewController

- (instancetype)initWithClubID:(NSString *)clubID{
    if (self = [super init]) {
        self.clubID = clubID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
}

- (void)setupUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 105);
    self.sliderView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), SCREEN_WIDTH, 45);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.sliderView.frame),SCREEN_WIDTH ,SCREEN_HEIGHT - CGRectGetMaxY(self.sliderView.frame) - 64);
    
    [self.sliderView setButtonTitleArray:@[@"公告",@"帖子"]];

    [self.topView applyBtnAddTarget:self action:@selector(applyAddClub)];
    [self.topView nameLabelAddTarget:self action:@selector(checkClubInfo)];
    
    self.subVC = [[TSOClubHomePageArticleTableViewController alloc] initWithClubID:self.clubID];
   
    
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.sliderView.frame),SCREEN_WIDTH ,SCREEN_HEIGHT - CGRectGetMaxY(self.sliderView.frame) - 64);
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - CGRectGetMaxY(self.sliderView.frame) - 64);
    [self.contentScrollView addSubview:self.tableView];
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);

    self.subVC.tableView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    
    
    
}


- (void)setupNav{
    [super setupNav];
    self.navTitle = nil;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    titleLb.font = FONT(17);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = WHITECOLOR;
    titleLb.text = @"俱乐部主页";
    [self.navigationItem setTitleView:titleLb];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"classify143"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button sizeToFit];
    [button addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GLOBALCOLOR] forBarMetrics:UIBarMetricsDefault];
    
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
    moreBtn.titleLabel.font = FONT(14);
    [moreBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    [moreBtn setImage:IMAGE(@"classify86") forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self.tableView.mj_header beginRefreshing];
    [self requestClubIndex];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}

#pragma mark - 请求数据

- (void)requestClubIndex{
    
    if (self.clubID.length > 0) {
        NSMutableDictionary *parameter = [@{@"clubId":_clubID} mutableCopy];
        if (IsLogin) {
            [parameter setObject:[UserModel sharedUserModel].ID forKey:@"userId"];
        }
        
        NSLog(@"===---===%@",parameter);
        [ShareBusinessManager.clubManager getClubIndexWithParameters:parameter success:^(id responObject) {
            ClubIndexModel *model = (ClubIndexModel *)responObject;
            if (model.errorCode.integerValue == 1) {
                self.clubHomePageModel = model;
            }
            
        } failure:^(NSInteger errCode, NSString *errorMsg) {
            
        }];
    }
    
}

- (void)requestClubArticle{
    
    if (self.page == 1) {
        [self.dataList removeAllObjects];
    }
    
    NSMutableDictionary *parameter = [@{@"clubId":_clubID,
                                @"currentPage":[NSString stringWithFormat:@"%zd",_page],
                                @"pageSize":PAGESIZE,
                                @"type":@"10"} mutableCopy];
   
    
    [ShareBusinessManager.clubManager getClubArticleListWithParameters:parameter success:^(id responObject) {
        ClubArticleModel *model = (ClubArticleModel *)responObject;
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
            NSInteger cellCount = self.tableView.frame.size.height /100;
            if (self.dataList.count < cellCount + 1) {
                self.tableView.mj_footer.hidden = YES;
            }else{
                self.tableView.mj_footer.hidden = NO;
            }
            if (self.dataList.count == 0) {
                self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:EmptyImage];
            }else{
                self.tableView.tableFooterView = [UIView new];
            }
            
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
        [_tableView.mj_footer endRefreshing];
    }];
}



#pragma mark - YB_SliderBtnViewDelegate

- (void)yb_SliderBtnView:(YB_SliderBtnView *)view buttonDidClicked:(UIButton *)button{
    if (button.tag == 0) {//公告
        
        [self.contentScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if (button.tag == 1){//帖子
        
        [self.contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH *1, 0) animated:YES];
        [self addChildViewController:self.subVC];
        [self.contentScrollView addSubview:self.subVC.tableView];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticle *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    model.from = @3;//test
    TSOClubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTSOClubTableViewCell];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClubArticle *model;
    if (self.dataList.count > 0) {
        model = self.dataList[indexPath.row];
    }
    TSOClubNoticeDetailViewController *detailVC =[[TSOClubNoticeDetailViewController alloc] initWithDisableArticleID:model.ID.stringValue];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"查看简介");
        TSOClubIntroductionViewController *clubVC = [[TSOClubIntroductionViewController alloc] initWithClubId:self.clubID];
        clubVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:clubVC animated:YES];
    }
    if (buttonIndex == 1) {
        NSLog(@"退出俱乐部");
    }
}

#pragma mark - Action

- (void)backToFront{
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)moreBtnClick{
    [self checkClubInfo];
}

- (void)checkClubInfo{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"查看俱乐部简介", @"退出俱乐部",nil];
    [actionSheet showInView:self.view];
}
//申请加入俱乐部
- (void)applyAddClub{
    
    switch (self.clubHomePageModel.data.isjoin.integerValue) {
        case 0://已申请
        {
            TSOClubApplyStatusViewController *scuessVC = [[TSOClubApplyStatusViewController alloc] initIsScuess:NO];
            scuessVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scuessVC animated:YES];
        }
            break;
        case 1://已经加入
        {
            TSOClubApplyStatusViewController *scuessVC = [[TSOClubApplyStatusViewController alloc] initIsScuess:YES];
            scuessVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scuessVC animated:YES];
        }
            break;
        
        default://未申请
            [self showApplyView];
            break;
    }

}

- (void)showApplyView{
    TSOClubApplyView *applyView = [[TSOClubApplyView alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH * 0.9, 200)];
    applyView.delegate = self;
    applyView.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT * 0.3);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.maskView = [[UIView alloc] initWithFrame:window.bounds];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMask)];
    [self.maskView addGestureRecognizer:tap];
    if ([UIDevice currentDevice].systemVersion.floatValue > 9.0) {
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:applyView.bounds];
        [applyView addSubview:effectView];
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        effectView.effect = blurEffect;
        
        [window addSubview:self.maskView];
        [self.maskView addSubview:applyView];
        
        [UIView animateWithDuration:0.25 animations:^{
            effectView.effect = nil;
        } completion:^(BOOL finished) {
            [effectView removeFromSuperview];
        }];
    }else{
        [window addSubview:self.maskView];
        [self.maskView addSubview:applyView];
    }
}

- (void)dismissMask{

    [self.maskView removeFromSuperview];
    
}

#pragma mark - TSOClubApplyViewDelegate

- (void)clubApplyViewCancelButtonDidClick{
    [self dismissMask];
}

- (void)clubApplyView:(TSOClubApplyView *)view applyButtonDidClick:(NSString *)reasonStr{
    NSLog(@"%@",reasonStr);
    [self dismissMask];
    //请求加入
    [SVProgressHUD showWithStatus:@"正在申请"];
    //请求成功跳转到成功页面
    NSDictionary *parameter = @{@"clubId":self.clubID,
                                @"joinReason":reasonStr};
    [ShareBusinessManager.clubManager getJoinClubWithParameters:parameter success:^(id responObject) {
        SeverStatus *model = (SeverStatus *)responObject;
        if (model.errorCode.integerValue == 1) {
            [SVProgressHUD dismiss];
            TSOClubApplyStatusViewController *scuessVC = [[TSOClubApplyStatusViewController alloc] initIsScuess:YES];
            scuessVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scuessVC animated:YES];
        }else{
            
            //测试  跳转应该放在请求成功的情况下  现在请求成功的状态不合理暂时放在这里
            [SVProgressHUD dismiss];
            TSOClubApplyStatusViewController *scuessVC = [[TSOClubApplyStatusViewController alloc] initIsScuess:NO];
            scuessVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:scuessVC animated:YES];

        }
        
        
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
    

}

#pragma mark - Setter&Getter

- (TSOClubHeadView *)topView{
    if (_topView == nil) {
        _topView = [[TSOClubHeadView alloc] init];
        
        _topView.backgroundColor = GLOBALCOLOR;
    }
    return _topView;
}

- (YB_SliderBtnView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [[YB_SliderBtnView alloc] init];
        _sliderView.delegate = self;
        
    }
    return _sliderView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TSOClubTableViewCell class] forCellReuseIdentifier:kTSOClubTableViewCell];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        weak(self);
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf requestClubArticle];
            
        }];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _page = 1;
            [weakSelf requestClubArticle];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (void)setClubHomePageModel:(ClubIndexModel *)clubHomePageModel{
    _clubHomePageModel = clubHomePageModel;
    _topView.model = clubHomePageModel;

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

@end
