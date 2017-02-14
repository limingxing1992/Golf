//
//  TSOHomeViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/10/25.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeViewController.h"
#import "TSOHomeBtnListTableViewCell.h"
#import "TSOHomeMessageTableViewCell.h"
#import "TSOHomeInvitationTableViewCell.h"
#import "TSOHomeButton.h"
#import "TSOHomeCommunityTableViewCell.h"
#import "MyInviteMeViewController.h"
#import "HomeInfoModel.h"
#import "CommunityArticleModel.h"
#import "TSOCommunityTopicViewController.h"
#import "UIImage+Image.h"
#import "TSOCommunityViewController.h"
#import "TSOClubHomePageViewController.h"
@interface TSOHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
TSOHomeCommunityTableViewCellDelegate,
TSOHomeMessageTableViewCellDelegate
>

@property (nonatomic, strong) UITableView *tableView;
/**顶部轮播图*/
@property (nonatomic, strong) SDCycleScrollView *topScrollView;
/**影视动态轮播图*/
@property (nonatomic, strong) SDCycleScrollView *tvShowScrollView;
/**首页模型*/
@property (nonatomic, strong) HomeInfoModel *homeInfoModel;
/**pageController*/
@property (nonatomic, strong) STL_PageControl *tvShowPageControl;

@end

static  NSString *const kTSOHomeBtnListTableViewCell = @"kTSOHomeBtnListTableViewCell";
static  NSString *const kTSOHomeMessageTableViewCell = @"kTSOHomeMessageTableViewCell";
static  NSString *const kTSOHomeInvitationTableViewCell = @"kTSOHomeInvitationTableViewCell";
static  NSString *const kHeadTableViewCell = @"kHeadTableViewCell";
static  NSString *const kTSOHomeCommunityTableViewCell = @"kTSOHomeCommunityTableViewCell";
@implementation TSOHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI{
    
    self.view.backgroundColor = BACKGROUNDCOLOR;
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 17)];
    titleLb.font = FONT(17);
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = BLACKTEXTCOLOR;
    titleLb.text = @"小鸟娱动";
    [self.navigationItem setTitleView:titleLb];
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self requestData];
}



//MARK: - 请求数据
- (void)requestData{
    NSDictionary *parameter;
    if ([UserModel sharedUserModel].ID) {
        parameter = @{@"userId":[UserModel sharedUserModel].ID};
    }else{
        parameter = @{};
    }
   
    [ShareBusinessManager.homeManager getIndexInfoWithParameters:parameter success:^(id responObject) {
        HomeInfoModel *model = (HomeInfoModel *)responObject;
        if (model.errorCode.integerValue == 1) {
            self.homeInfoModel = model;
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:model.errorMsg];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)setHomeInfoModel:(HomeInfoModel *)homeInfoModel{
    _homeInfoModel = homeInfoModel;
    
    NSMutableArray *tvShowImgArr = [[NSMutableArray alloc] init];
    for (TvVoteActionModel *model in _homeInfoModel.data.voteActivityListInfo) {
        NSString *fullUrl = FULLIMGURL(model.imageUrl).absoluteString;
        [tvShowImgArr addObject:fullUrl];
    }
    self.tvShowScrollView.imageURLStringsGroup = tvShowImgArr;

    
    NSMutableArray *topAdImgArr = [[NSMutableArray alloc] init];
    for (AdModel *model in _homeInfoModel.data.adListInfo) {
        NSString *fullUrl = FULLIMGURL(model.img).absoluteString;
        [topAdImgArr addObject:fullUrl];
    }
    
    self.topScrollView.imageURLStringsGroup = topAdImgArr;
    
    weak(self)
    [self.topScrollView setClickItemOperationBlock:^(NSInteger idx) {
        //10-球场，20-俱乐部，30-投票活动
        AdModel *model = weakSelf.homeInfoModel.data.adListInfo[idx];
        if (model.linkType.integerValue == 10) {
            PlaceDetailViewController *placeVC = [[PlaceDetailViewController alloc] init];
            placeVC.ballPlaceId = model.linkId;
            placeVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:placeVC animated:YES];
            
        }
        if (model.linkType.integerValue == 20) {
            TSOClubHomePageViewController *clubVC = [[TSOClubHomePageViewController alloc] initWithClubID:model.linkId.stringValue];
            clubVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:clubVC animated:YES];
        }
        if (model.linkType.integerValue == 30) {
            TVToupiaoDetailViewController *detailVc = [[TVToupiaoDetailViewController alloc] init];
            detailVc.Id = model.linkId;
            [weakSelf.navigationController pushViewController:detailVc animated:YES];
        }
        
    }];

}



#pragma mark - TSOHomeCommunityTableViewCellDelegate
- (void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell nameLabelDidClick:(NSString *)name{
    
}

//MARK: - TSOHomeCommunityTableViewCellDelegate

-(void)tSOHomeCommunityTableViewCell:(TSOHomeCommunityTableViewCell *)cell focusBtnDidClick:(NSString *)userId{
    
    if (IsLogin) {
        //判断是已关注还是取消关注
        NSMutableArray *changeCells = [[NSMutableArray alloc] init];
        
        if (cell.model.isfollow == YES) {
            [ShareBusinessManager.userManager postMyAttentionRemoveWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                
                for (int idx = 0; idx<self.homeInfoModel.data.communityArticleList.count; idx++) {
                    CommunityArticle *model = self.homeInfoModel.data.communityArticleList[idx];
                    if ([model.userId isEqualToNumber:cell.model.userId]) {
                        model.isfollow = NO;
                        [changeCells addObject:[NSIndexPath indexPathForItem:idx +1 inSection:3]];
                    }
                }
                [self.tableView reloadRowsAtIndexPaths:changeCells withRowAnimation:UITableViewRowAnimationFade];
            } failure:^(NSInteger errCode, NSString *errorMsg) {
                [SVProgressHUD showErrorWithStatus:errorMsg];
            }];
        }else{
            [ShareBusinessManager.userManager postMyAttentionAddWithParameters:@{@"userId":userId} success:^(id responObject) {
                [SVProgressHUD showSuccessWithStatus:responObject];
                for (int idx = 0; idx < self.homeInfoModel.data.communityArticleList.count; idx++) {
                    CommunityArticle *model = self.homeInfoModel.data.communityArticleList[idx];
                    if ([model.userId isEqualToNumber:cell.model.userId]) {
                        model.isfollow = YES;
                        [changeCells addObject:[NSIndexPath indexPathForItem:idx +1 inSection:3]];
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


//MARK: - TSOHomeMessageTableViewCellDelegate

- (void)homeMessageTableViewCellMessageDidClick:(NSString *)orderNo{
    if (IsLogin) {
        OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] init];
        orderDetailVC.orderNo = orderNo;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }else{
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {//球友邀约
        if (IsLogin) {
            MyInviteMeViewController *invietMeVC = [[MyInviteMeViewController alloc] init];
            invietMeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invietMeVC animated:YES];
        }else{
            [self presentViewController:LoginNavi animated:YES completion:nil];
        }
        
    }
    if (indexPath.section == 2 && indexPath.row == 0) {//影视动态
        TVShowViewController *tvShowVC = [[TVShowViewController alloc] init];
        [self.navigationController pushViewController:tvShowVC animated:YES];
    }
    
    if (indexPath.section == 3 && indexPath.row == 0) {//社区动态
        self.tabBarController.selectedIndex = 2;
    }
    
    if (indexPath.section == 3 && indexPath.row > 0) {//社区动态列表
        CommunityArticle *model;
        if (self.homeInfoModel.data.communityArticleList.count >0) {
            model = self.homeInfoModel.data.communityArticleList[indexPath.row - 1];
        }
        
        TSOCommunityTopicViewController *topicVC = [[TSOCommunityTopicViewController alloc] initWithCommunityArticleID:model.ID.stringValue];
        [topicVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:topicVC animated:YES];
    }
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {//影视动态
        return 1;
    }
    if (section == 3) {//社区动态
       
        return self.homeInfoModel.data.communityArticleList.count + 1;
        
    }
    if (section == 1) {//球友邀约
        if (self.homeInfoModel.data.userInviteBall.ID) {
            return 2;
        }else{
            return 1;
        }
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 105;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 200;
    }else{
        return 5;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
//        self.topScrollView.autoScroll = YES;
        return self.topScrollView;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *contentView = [UIView new];
        contentView.backgroundColor = WHITECOLOR;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = GRAYCOLOR;
        [contentView addSubview:line];
        [contentView addSubview:self.tvShowScrollView];
        
        self.tvShowScrollView.autoScroll = NO;
        return contentView;
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TSOHomeBtnListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeBtnListTableViewCell];
            [listCell.clubBtn addTarget:self action:@selector(toClubViewController:) forControlEvents:UIControlEventTouchUpInside];
            [listCell.tvShowBtn addTarget:self action:@selector(toTVShowViewController:) forControlEvents:UIControlEventTouchUpInside];
            [listCell.communityBtn addTarget:self action:@selector(toCommunityViewController:) forControlEvents:UIControlEventTouchUpInside];
            [listCell.chartsBtn addTarget:self action:@selector(toChartsViewController:) forControlEvents:UIControlEventTouchUpInside];
            return listCell;
        }
        if (indexPath.row == 1) {
            TSOHomeMessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeMessageTableViewCell];
            messageCell.delegate = self;

            messageCell.model = self.homeInfoModel;

            return messageCell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:kHeadTableViewCell];
            return [self setupCell:headCell title:@"球友邀约" image:@"classify10"];
        }
        if (indexPath.row == 1) {
            TSOHomeInvitationTableViewCell *invitationCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeInvitationTableViewCell];
            if (self.homeInfoModel) {
                invitationCell.model = self.homeInfoModel.data.userInviteBall;
            }
            
            return invitationCell;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:kHeadTableViewCell];

            return [self setupCell:headCell title:@" 影视动态" image:@"classify11"];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            UITableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:kHeadTableViewCell];
            return [self setupCell:headCell title:@"社区动态" image:@"classify12"];;
        }
        if (indexPath.row >= 1) {
            TSOHomeCommunityTableViewCell *communityCell = [tableView dequeueReusableCellWithIdentifier:kTSOHomeCommunityTableViewCell];
            communityCell.delegate = self;

            //需要判断不能大于9
            CommunityArticle *model;
            if (self.homeInfoModel) {
                model = self.homeInfoModel.data.communityArticleList[indexPath.row - 1];
                communityCell.model = model;
            }
            return communityCell;
        }
    }
    return [[UITableViewCell alloc] init];
}

- (UITableViewCell *)setupCell:(UITableViewCell *)cell title:(NSString *)title image:(NSString *)imgStr{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
    cell.textLabel.font = FONT(16);//设置标题大小
    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
    cell.detailTextLabel.font = FONT(12);//设置详情字体大小
    cell.imageView.image = IMAGE(imgStr);
    cell.textLabel.text = title;
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, cell.mj_h - 0.5, SCREEN_WIDTH, 0.5 * KHeight_Scale)];
//    line.backgroundColor = GRAYCOLOR;
//    [cell addSubview:line];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 71 * KHeight_Scale;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        if (self.homeInfoModel.data.indexOrderListInfo.count > 0) {
            return 25 * KHeight_Scale;
        }else{
            return 0;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            return 95 * KHeight_Scale;
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row >= 1) {
            CGFloat height = [_tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:_tableView];
            return height;
        }
    }
    return 44;
}

#pragma mark - Action

- (void)toClubViewController:(UIButton *)button{
    TSOClubViewController *clubVC = [[TSOClubViewController alloc] init];
    clubVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:clubVC animated:YES];
}

- (void)toTVShowViewController:(UIButton *)button{
    TVShowViewController *tv = [[TVShowViewController alloc] init];
    [self.navigationController pushViewController:tv animated:YES];
}

- (void)toCommunityViewController:(UIButton *)button{
    self.tabBarController.selectedIndex = 2;
}

- (void)toChartsViewController:(UIButton *)button{
    if (IsLogin) {
        ChartsViewController *chartVC = [[ChartsViewController alloc] init];
        [self.navigationController pushViewController:chartVC animated:YES];
    }else{
        [self presentViewController:[STL_CommonIdea loginNavi] animated:YES completion:nil];
    }
}

- (void)messageBtnDidClick{
    
}
#pragma mark - Setter&Getter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH ,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TSOHomeBtnListTableViewCell class] forCellReuseIdentifier:kTSOHomeBtnListTableViewCell];
        [_tableView registerClass:[TSOHomeMessageTableViewCell class] forCellReuseIdentifier:kTSOHomeMessageTableViewCell];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kHeadTableViewCell];
        [_tableView registerClass:[TSOHomeInvitationTableViewCell class] forCellReuseIdentifier:kTSOHomeInvitationTableViewCell];
        [_tableView registerClass:[TSOHomeCommunityTableViewCell class] forCellReuseIdentifier:kTSOHomeCommunityTableViewCell];
        weak(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf requestData];
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}

- (SDCycleScrollView *)topScrollView{
    if (_topScrollView == nil) {
        _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH , 200)delegate:self placeholderImage:Placeholder_big];
        _topScrollView.autoScrollTimeInterval = 3;
        _topScrollView.backgroundColor = BACKGROUNDCOLOR;
        _topScrollView.placeholderImage = Placeholder_big;
    }
    return _topScrollView;
}

- (SDCycleScrollView *)tvShowScrollView{
    if (_tvShowScrollView == nil) {
        _tvShowScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 10, 95)delegate:self placeholderImage:Placeholder_big];
        _tvShowScrollView.backgroundColor = BACKGROUNDCOLOR;
        _tvShowScrollView.placeholderImage = Placeholder_big;
        _tvShowScrollView.showPageControl = YES;
        _tvShowScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _tvShowScrollView.currentPageDotColor = BLACKTEXTCOLOR;
        _tvShowScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _tvShowScrollView.pageControlDotSize = CGSizeMake(6, 6);
        _tvShowScrollView.layer.cornerRadius = 5;
        _tvShowScrollView.layer.masksToBounds = YES;
        _tvShowScrollView.autoScroll = NO;
        
        
        
        weak(self)
        [_tvShowScrollView setClickItemOperationBlock:^(NSInteger idx) {
            
            if (IsLogin) {
                TvVoteActionModel *model = weakSelf.homeInfoModel.data.voteActivityListInfo[idx];
                if ([UserModel sharedUserModel].sort < model.sort) {
                    NSString *text = [NSString stringWithFormat:@"当前活动等级需要%@",model.gradeName];
                    [STL_CommonIdea alertWithTarget:weakSelf Title:@"快去升级啊" message:text action_0:@"取消" action_1:@"确定" block_0:nil block_1:^{
                        //跳转荣誉页面升级
                        MyLevelViewController *levelVc = [[MyLevelViewController alloc] init];
                        [weakSelf.navigationController pushViewController:levelVc animated:YES];
                    }];
                }else{
                    TVToupiaoDetailViewController *detailVc = [[TVToupiaoDetailViewController alloc] init];
                    detailVc.Id = [NSNumber numberWithInt:model.ID.intValue];
                    [weakSelf.navigationController pushViewController:detailVc animated:YES];
                }
            }else{
                [weakSelf presentViewController:LoginNavi animated:YES completion:nil];
            }
        }];
    }
    return _tvShowScrollView;
}

@end
