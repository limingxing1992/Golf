//
//  MyPointsViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyPointsViewController.h"
#import "MyPointsConvertCollectionViewCell.h"


@interface MyPointsViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

/** 头部视图*/
@property (nonatomic, strong) UIView *topView;
/** 头部图片*/
@property (nonatomic, strong) UIImageView *topIv;
///** 积分承载视图*/
//@property (nonatomic, strong) UIView *pointsView;
/** 积分余额*/
@property (nonatomic, strong) UILabel *pointsLb;
///** 积分余额图*/
//@property (nonatomic, strong) UIImageView *pointsIv;
///** 查看积分明细按钮*/
//@property (nonatomic, strong) UIButton *pointsDetailBtn;
///** 积分明细图*/
//@property (nonatomic, strong) UIImageView *pointsDetailIv;
///** 积分明细*/
//@property (nonatomic, strong) UILabel *pointsDetailLb;


/** 积分视图*/
@property (nonatomic, strong) UITableView *tableView;


/** 赚积分的视图*/
@property (nonatomic, strong) UIView *profitView;
/** 预订球场*/
@property (nonatomic, strong) STL_MixBtn *appointBtn;
/** 充值*/
@property (nonatomic, strong) STL_MixBtn *fillBtn;
/** 更多*/
@property (nonatomic, strong) STL_MixBtn *userInfoBtn;

/** 花积分的视图*/
@property (nonatomic, strong) UIView *useView;

/** 兑换列表*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 兑换列表数据*/
@property (nonatomic, strong) NSMutableArray *convertData;


@end

@implementation MyPointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的积分";
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _tableView.sd_layout
    .topSpaceToView(self.view, NaviBar_HEIGHT)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    [self updateMyBalance];
}
/** 自动布局头部视图*/
- (void)autoLayoutTopSubViews{
    _topIv.sd_layout
    .topSpaceToView(_topView, 18)
    .centerXEqualToView(_topView)
    .widthIs(100)
    .heightIs(75);
    
    _pointsLb.sd_layout
    .bottomSpaceToView(_topView, 20)
    .centerXEqualToView(_topView)
    .heightIs(14);
    [_pointsLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
}
/** 自动布局赚积分的视图*/
- (void)autoLayoutProfilSubViews{
    
    _fillBtn.sd_layout
    .centerYEqualToView(_profitView)
    .centerXIs(SCREEN_WIDTH / 6);

    _appointBtn.sd_layout
    .centerYEqualToView(_profitView)
    .centerXIs(SCREEN_WIDTH/ 2);
    
    
    _userInfoBtn.sd_layout
    .centerYEqualToView(_profitView)
    .centerXIs(SCREEN_WIDTH /6 *5);
}
/** 自动布局华积分的视图*/
- (void)autoLayoutUseSubViews{
    _collectionView.sd_layout
    .topSpaceToView(_useView, 0)
    .leftSpaceToView(_useView, 0)
    .rightSpaceToView(_useView, 0)
    .heightIs(130);
    
//    [_useView setupAutoHeightWithBottomView:_collectionView bottomMargin:0];
}

#pragma mark ----------------界面逻辑
/** 预订球场*/
- (void)apointAction{
    [SVProgressHUD showSuccessWithStatus:@"预订球场"];
    PlaceAppointViewController *vc = [[PlaceAppointViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
/** 充值*/
- (void)fillAciton{
    [SVProgressHUD showSuccessWithStatus:@"去充值"];
    BirdWalletFillViewController *vc = [[BirdWalletFillViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
/** 更多*/
- (void)userFillAction{
    MyPointsMoreViewController *vc = [[MyPointsMoreViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----------------数据

- (void)initData{
    _convertData = [[NSMutableArray alloc] init];
}

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD show];
    [ShareBusinessManager.userManager postMyPointsConvertListWithParameters:nil success:^(id responObject) {
        [weakself.convertData removeAllObjects];
        [weakself.convertData addObjectsFromArray:responObject];
        [SVProgressHUD dismiss];
        weakself.collectionView.sd_layout
        .heightIs([weakself minCollctionHeight]);
        [weakself.collectionView reloadData];
        [weakself.tableView reloadData];

    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

/** 计算collection高度*/
- (CGFloat )minCollctionHeight{
    NSInteger count = _convertData.count;
    NSInteger flg = count / 3;
    NSInteger fff = count % 3;
    if (fff) {
        flg += 1;
    }
    
    NSLog(@"%ld", flg);
    return flg *((SCREEN_WIDTH - 150)/ 3 + 30) + 40 + (flg- 1)*20;
}

/** 本页面支付充值成功后需要及时刷新余额*/
- (void)updateMyBalance{
    GOLFWeakObj(self);
    [ShareBusinessManager.loginManager postUserBanlanceScoreWithParameters:nil
                                                                   success:^(id responObject) {
                                                                       [UserModel sharedUserModel].money = responObject[@"money"];
                                                                       [UserModel sharedUserModel].score = [responObject[@"score"] stringValue];
                                                                       weakself.pointsLb.text = [NSString stringWithFormat:@"我的积分：%@", [UserModel sharedUserModel].score];
                                                                   }
                                                                   failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [UserModel sharedUserModel].money = @"0";
                                                                       [UserModel sharedUserModel].score = @"0";
                                                                   }];
}

#pragma mark ----------------tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section ==1) {
        
        return [self minCollctionHeight];
    }
    
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 150;
    }else if (section == 1){
        return 10;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.topView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return self.profitView;
    }else if (section == 1){
        return self.collectionView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"pointsCell"];
    cell.textLabel.font = FONT(16);
    cell.textLabel.textColor = BLACKTEXTCOLOR;
    cell.imageView.image = IMAGE(@"classify154");
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"赚积分";
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"花积分";
    }
    
    return cell;
}

#pragma mark ----------------集合视图代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _convertData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyPointsConvertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"convertCell" forIndexPath:indexPath];
    cell.model = _convertData[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyPointsModel *model = _convertData[indexPath.row];
    MyPointsFreePlayController *play = [[MyPointsFreePlayController alloc] init];
    play.PointsModel = model;
    [self.navigationController pushViewController:play animated:YES];
    
}


#pragma mark ----------------实例

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = RGBColor(240, 103, 80);
        [_topView addSubview:self.topIv];
        [_topView addSubview:self.pointsLb];
//        [_topView addSubview:self.pointsView];
//        [_topView addSubview:self.pointsDetailBtn];
        [self autoLayoutTopSubViews];
    }
    return _topView;

}

- (UIImageView *)topIv{
    if (!_topIv) {
        _topIv = [[UIImageView alloc] init];
        _topIv.image = IMAGE(@"classify200");
    }
    return _topIv;
}
- (UILabel *)pointsLb{
    if (!_pointsLb) {
        _pointsLb = [[UILabel alloc] init];
        _pointsLb.font = FONT(14);
        _pointsLb.textColor = WHITECOLOR;
        NSString *text = [NSString stringWithFormat:@"我的积分：%@", [UserModel sharedUserModel].score];
        _pointsLb.text = text;
    }
    return _pointsLb;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = BACKGROUNDCOLOR;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pointsCell"];
    }
    return _tableView;

}

- (UIView *)profitView{
    if (!_profitView) {
        _profitView = [[UIView alloc] init];
        _profitView.backgroundColor = WHITECOLOR;
        [_profitView sd_addSubviews:@[self.appointBtn, self.fillBtn, self.userInfoBtn]];
        [self autoLayoutProfilSubViews];
    }
    return _profitView;

}

- (STL_MixBtn *)appointBtn{
    if (!_appointBtn) {
        _appointBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify136") title:@"预订球场"];
        [_appointBtn addTarget:self action:@selector(apointAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appointBtn;
}

- (STL_MixBtn *)fillBtn{
    if (!_fillBtn) {
        _fillBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify178") title:@"充值"];
        [_fillBtn addTarget:self action:@selector(fillAciton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fillBtn;
}

- (STL_MixBtn *)userInfoBtn{
    if (!_userInfoBtn) {
        _userInfoBtn = [[STL_MixBtn alloc] initWithImage:IMAGE(@"classify179") title:@"更多"];
        [_userInfoBtn addTarget:self action:@selector(userFillAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userInfoBtn;
}

- (UIView *)useView{
    if (!_useView) {
        _useView = [[UIView alloc] init];
        _useView.backgroundColor = WHITECOLOR;
        [_useView addSubview:self.collectionView];
        [self autoLayoutUseSubViews];
    }
    return _useView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 150)/ 3, (SCREEN_WIDTH - 150)/ 3 + 30);
        layout.minimumLineSpacing= 20;
        layout.minimumInteritemSpacing = 50;
        layout.scrollDirection= UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[MyPointsConvertCollectionViewCell class] forCellWithReuseIdentifier:@"convertCell"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = WHITECOLOR;
    }
    return _collectionView;
}

@end
