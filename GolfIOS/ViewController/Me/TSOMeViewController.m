//
//  TSOMeViewController.m
//  GolfIOS
//
//  Created by yangbin on 16/10/25.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOMeViewController.h"
#import "TSOPersonalScoreRecordViewController.h"

@interface TSOMeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

/** 头部背景图*/
@property (nonatomic, strong) UIImageView *topBackIv;
/** 底部线条*/
@property (nonatomic, strong) UIView *topLineView;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 等级图*/
@property (nonatomic, strong) UIImageView *levelIv;
/** 用户昵称*/
@property (nonatomic, strong) UILabel *userNameLb;
/** 用户性别图标*/
@property (nonatomic, strong) UIImageView *userIndicatorIv;
/** 用户杆数标题*/
@property (nonatomic, strong) UILabel *ganshuTitleLb;
/** 用户杆数*/
@property (nonatomic, strong) UILabel *ganshuLb;
/** 用户差点标题*/
@property (nonatomic, strong) UILabel *chadianTitleLb;
/** 用户差点*/
@property (nonatomic, strong) UILabel *chadianLb;
/** 分割线*/
@property (nonatomic, strong) UIView *lineView;
/** 我的社区按钮*/
@property (nonatomic, strong) UIButton *myHomeBtn;



/** 列表*/
@property (nonatomic, strong) UITableView *tableView;
/** 上半部数据*/
@property (nonatomic, strong) NSArray *listData_0;
/** 下半部数据*/
@property (nonatomic, strong) NSArray *listData_1;

/** 用户余额*/
@property (nonatomic, copy) NSString *balance;
/** 用户积分*/
@property (nonatomic, copy) NSString *points;



@end

@implementation TSOMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor = WHITECOLOR;
    [self.contentView addSubview:self.topBackIv];//添加头部
    self.name = @"我的";
    self.showBack = NO;
    self.rightIm_0 = IMAGE(@"classify215");
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.tableView];//添加列表
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.contentView.frame = CGRectMake(0, NaviBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NaviBar_HEIGHT - 49);
    [self autoLayoutHeadIv];
    [self updateUI];//每次进入页面都会刷新数据
    if (IsLogin) {
        [self reloadUserBalance];
    }
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark ----------------自动布局

- (void)autoLayoutHeadIv{
    _topBackIv.sd_layout
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(125);
    
    _headIv.sd_layout
    .topSpaceToView(_topBackIv, 20)
    .leftSpaceToView(_topBackIv, 10)
    .heightIs(70)
    .widthEqualToHeight();
    
    _userNameLb.sd_layout
    .leftSpaceToView(_headIv, 15)
    .topSpaceToView(_topBackIv, 30)
    .heightIs(16);
    [_userNameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    
    _levelIv.sd_layout
    .topSpaceToView(_userNameLb, 5)
    .leftEqualToView(_userNameLb)
    .heightIs(10)
    .widthIs(37.5);
    
    _userIndicatorIv.sd_layout
    .centerYEqualToView(_userNameLb)
    .leftSpaceToView(_userNameLb, 3)
    .heightIs(14.5)
    .widthIs(14);
    
    _lineView.sd_layout
    .topSpaceToView(_levelIv, 11)
    .leftEqualToView(_levelIv)
    .rightSpaceToView(_topBackIv, 0)
    .heightIs(1);
    
    _myHomeBtn.sd_layout
    .bottomSpaceToView(_lineView, 16)
    .rightSpaceToView(_topBackIv, 20)
    .heightIs(30)
    .widthIs(70);
    
    _ganshuTitleLb.sd_layout
    .topSpaceToView(_lineView, 20)
    .leftEqualToView(_lineView)
    .heightIs(14);
    [_ganshuTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _ganshuLb.sd_layout
    .centerYEqualToView(_ganshuTitleLb)
    .leftSpaceToView(_ganshuTitleLb, 3)
    .heightIs(14);
    [_ganshuLb setSingleLineAutoResizeWithMaxWidth:400];
    
    _chadianTitleLb.sd_layout
    .centerYEqualToView(_ganshuTitleLb)
    .leftSpaceToView(_ganshuLb, 20)
    .heightIs(14);
    [_chadianTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _chadianLb.sd_layout
    .centerYEqualToView(_chadianTitleLb)
    .leftSpaceToView(_chadianTitleLb, 3)
    .heightIs(14);
    [_chadianLb setSingleLineAutoResizeWithMaxWidth:400];
    
    
    _topLineView.sd_layout
    .topSpaceToView(_topBackIv, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
    
    _tableView.sd_layout
    .topSpaceToView(_topLineView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs((_listData_0.count + _listData_1.count) * 45 + 10);
    
    [self.contentView setupAutoContentSizeWithBottomView:_tableView bottomMargin:10];
}


#pragma mark ----------------数据初始化

/** 初始化数据*/
- (void)initData{
    NSString *listPath_0 = [[NSBundle mainBundle] pathForResource:@"MeList_0" ofType:@"plist"];
    _listData_0 = [[NSArray alloc] initWithContentsOfFile:listPath_0];
    NSString *listPath_1 = [[NSBundle mainBundle] pathForResource:@"MeList_1" ofType:@"plist"];
    _listData_1 = [[NSArray alloc] initWithContentsOfFile:listPath_1];
    _balance = @"0";
    _points = @"0";
}
/** 刷新界面*/
- (void)updateUI{
    UserModel *model = [UserModel sharedUserModel];

    //更新头像
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_small];
    
    //等级图更新
    [_levelIv setImage:[UserModel sharedUserModel].levelImg];
    //昵称更新。有昵称显示昵称。没有显示手机号
    _userNameLb.text = model.nickName;
    if ([model.nickName length]) {
        _userNameLb.text = model.nickName;
    }else{
        _userNameLb.text = model.userName;
    }
    //更新金钱和积分
    _balance = [NSString stringWithFormat:@"%@",[UserModel sharedUserModel].money];
    if (!_balance) {
        _balance = @"0";
    }     _points = [UserModel sharedUserModel].score;
    if (!_points) {
        _points = @"0";
    }
    [_tableView reloadData];
    
    //更新杆数和差点
    _ganshuLb.text = [UserModel sharedUserModel].polesNumber;
    _chadianLb.text = [UserModel sharedUserModel].handicap;
    
    //更新性别图标
    if ([UserModel sharedUserModel].sex ==1) {
        //男
        _userIndicatorIv.image = IMAGE(@"classify238");
    }else if([UserModel sharedUserModel].sex == 2){
        //女
        _userIndicatorIv.image = IMAGE(@"classify239");
    }else{
        //保密
    }
    
}
/** 刷新用户余额和积分数据*/
- (void)reloadUserBalance{
    GOLFWeakObj(self);
    [ShareBusinessManager.loginManager postUserBanlanceScoreWithParameters:nil
                                                                   success:^(id responObject) {
                                                                       [UserModel sharedUserModel].money = responObject[@"money"];
                                                                       [UserModel sharedUserModel].score = [responObject[@"score"] stringValue];
                                                                       [weakself updateUI];
                                                                   }
                                                                   failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [UserModel sharedUserModel].money = @"0";
                                                                       [UserModel sharedUserModel].score = @"0";
                                                                       [weakself updateUI];
                                                                   }];
}


#pragma mark ----------------界面逻辑
/** 导航栏右侧进入设置界面*/
- (void)right_0_action{
    SettingViewController *settingVc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
/** 进入各次级页面*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断登录
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
        return;
    }
    
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {//进入我的订单
                OrderListViewController *orderListVc = [[OrderListViewController alloc] init];
                [self.navigationController pushViewController:orderListVc animated:YES];
            }
                break;
            case 1:
            {//进入我的钱包
                BirdWalletViewController *birdWalletVc = [[BirdWalletViewController alloc] init];
                [self.navigationController pushViewController:birdWalletVc animated:YES];
            }
                break;
            case 2:
            {//进入我的积分
                MyPointsViewController *pointsVc = [[MyPointsViewController alloc] init];
                [self.navigationController pushViewController:pointsVc animated:YES];
            }
                break;
            case 3:
            {//进入我的荣誉
                MyLevelViewController *levelVc = [[MyLevelViewController alloc] init];
                [self.navigationController pushViewController:levelVc animated:YES];
            }
                break;
            case 4:
            {//进入我的收藏
                MyFavoriteViewController *favoriteVc = [[MyFavoriteViewController alloc] init];
                [self.navigationController pushViewController:favoriteVc animated:YES];
            }
            default:
                break;
        }
    }else{
        
        switch (indexPath.row) {
            case 0:
            {//进入我的邀请
                MyInviteMeViewController *inviteVc = [[MyInviteMeViewController alloc] init];
                [self.navigationController pushViewController:inviteVc animated:YES];
            }
                break;
            case 1:
            {//我的好友
                MyFirendViewController *firendVc = [[MyFirendViewController alloc] init];
                [self.navigationController pushViewController:firendVc animated:YES];
            }
                break;
            case 2:
            {//我的俱乐部
                MyClubViewController *clubVc = [[MyClubViewController alloc] init];
                [self.navigationController pushViewController:clubVc animated:YES];
            }
                break;
            case 3:
            {//我的成绩
//                MyGolfScoreViewController *golfScore = [[MyGolfScoreViewController alloc] init];
//                [self.navigationController pushViewController:golfScore animated:YES];
                TSOPersonalScoreRecordViewController *scoreRecordVC = [[TSOPersonalScoreRecordViewController alloc] init];
                scoreRecordVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:scoreRecordVC animated:YES];
            }
                break;
            case 4:
            {//我的动态
                MyMessageViewController *messageVc = [[MyMessageViewController alloc] init];
                [self.navigationController pushViewController:messageVc animated:YES];
            }
                break;
            default:
                break;
        }

    }



}
/** 点击头像视图*/
- (void)topBackIvAction{
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }else{
        //进入个人资料界面
        UserInfoViewController *infoVc = [[UserInfoViewController alloc] init];
        [self.navigationController pushViewController:infoVc animated:YES];
    }
}

/** 进入我的社区*/
- (void)intoMyHomeAction{
    if (!IsLogin) {
        [self presentViewController:LoginNavi animated:YES completion:nil];
    }else{
        TSOCommunityMySpaceViewController *mySpaceVc = [[TSOCommunityMySpaceViewController alloc] init];
        mySpaceVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mySpaceVc animated:YES];
    }
}

#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _listData_0.count;
    }
    return _listData_1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"listCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//消除选中样式
    cell.textLabel.font = FONT(14);//设置标题大小
    cell.textLabel.textColor = SHENTEXTCOLOR;//设置标题颜色
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(@"classify8")];//设置指示图
    cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;//设置详请字体颜色
    cell.detailTextLabel.font = FONT(14);//设置详情字体大小
    
    NSDictionary *info;
    if (indexPath.section == 0) {
        info = _listData_0[indexPath.row];
        if (indexPath.row == 1) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"余额%@",_balance]];
            [str addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(2, _balance.length)];
            cell.detailTextLabel.attributedText = str;
        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = _points;
        }
    }else{
        info = _listData_1[indexPath.row];
    }
    cell.textLabel.text = info[@"title"];
    cell.imageView.image = IMAGE(info[@"image"]);
    return cell;
}

#pragma mark ----------------实例

- (UIImageView *)topBackIv{
    if (!_topBackIv) {
        _topBackIv = [[UIImageView alloc] init];
        _topBackIv.image = IMAGE(@"classify91");
        _topBackIv.userInteractionEnabled = YES;
        [_topBackIv addSubview:self.headIv];
        [_topBackIv addSubview:self.levelIv];
        [_topBackIv addSubview:self.userNameLb];
        [_topBackIv addSubview:self.userIndicatorIv];
        [_topBackIv addSubview:self.ganshuTitleLb];
        [_topBackIv addSubview:self.ganshuLb];
        [_topBackIv addSubview:self.chadianTitleLb];
        [_topBackIv addSubview:self.chadianLb];
        [_topBackIv addSubview:self.lineView];
        [_topBackIv addSubview:self.myHomeBtn];
    }
    return _topBackIv;

}

- (UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = GRAYCOLOR;
    }
    return _topLineView;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.layer.borderColor = RGBColor(127, 200, 143).CGColor;
        _headIv.layer.borderWidth = 2;
        _headIv.layer.cornerRadius = 32.5;
        _headIv.image = Placeholder_small;
        _headIv.userInteractionEnabled = YES;
        _headIv.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topBackIvAction)];
        [_headIv addGestureRecognizer:tap];
//        [_headIv addSubview:self.levelIv];
    }
    return _headIv;
}

- (UIImageView *)levelIv{
    if (!_levelIv) {
        _levelIv = [[UIImageView alloc] init];
        _levelIv.image = IMAGE(@"classify148");
//        [_levelIv addSubview:self.levelLb];
    }
    return _levelIv;
}

- (UILabel *)userNameLb{
    if (!_userNameLb) {
        _userNameLb= [[UILabel alloc] init];
        _userNameLb.font = FONT(16);
        _userNameLb.textColor = WHITECOLOR;
        _userNameLb.text = @"登录/注册";
    }
    return _userNameLb;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGBColor(155, 209, 106);
    }
    return _lineView;
}

- (UILabel *)ganshuTitleLb{
    if (!_ganshuTitleLb) {
        _ganshuTitleLb = [[UILabel alloc] init];
        _ganshuTitleLb.font = FONT(12);
        _ganshuTitleLb.textColor = WHITECOLOR;
        _ganshuTitleLb.text = @"杆数";
    }
    return _ganshuTitleLb;
}

- (UILabel *)ganshuLb{
    if (!_ganshuLb) {
        _ganshuLb = [[UILabel alloc] init];
        _ganshuLb.font = FONT(12);
        _ganshuLb.textColor = WHITECOLOR;
        _ganshuLb.text = @"0";
    }
    return _ganshuLb;
}

- (UILabel *)chadianTitleLb{
    if (!_chadianTitleLb) {
        _chadianTitleLb = [[UILabel alloc] init];
        _chadianTitleLb.font = FONT(12);
        _chadianTitleLb.textColor = WHITECOLOR;
        _chadianTitleLb.text = @"差点";
    }
    return _chadianTitleLb;
}

- (UILabel *)chadianLb{
    if (!_chadianLb) {
        _chadianLb = [[UILabel alloc] init];
        _chadianLb.font = FONT(12);
        _chadianLb.textColor  = WHITECOLOR;
        _chadianLb.text = @"0";
    }
    return _chadianLb;
}

- (UIButton *)myHomeBtn{
    if (!_myHomeBtn) {
        _myHomeBtn = [[UIButton alloc] init];
        _myHomeBtn.titleLabel.font = FONT(14);
        [_myHomeBtn setTitle:@"我的社区" forState:UIControlStateNormal];
        [_myHomeBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_myHomeBtn setImage:IMAGE(@"classify213") forState:UIControlStateNormal];
        [_myHomeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
        [_myHomeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 15)];
        [_myHomeBtn addTarget:self action:@selector(intoMyHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myHomeBtn;

}

- (UIImageView *)userIndicatorIv{
    if (!_userIndicatorIv) {
        _userIndicatorIv = [[UIImageView alloc] init];
        _userIndicatorIv.image = IMAGE(@"classify238");
    }
    return _userIndicatorIv;
}






- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
    }
    return _tableView;
}

@end
