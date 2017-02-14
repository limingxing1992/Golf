//
//  MyLevelViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/8.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyLevelViewController.h"

@interface MyLevelViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UIWebViewDelegate
>
/** 头部背景图*/
@property (nonatomic, strong) UIView *topView;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 用户等级*/
@property (nonatomic, strong) UILabel *userNameLb;
///** 当前等级*/
//@property (nonatomic, strong) UILabel *currentLevelLb;
///** 将要升级等级*/
//@property (nonatomic, strong) UILabel *futureLevelLb;
///** 进度条*/
//@property (nonatomic, strong) LevelProgressView *progressView;






/** 特权视图*/
@property (nonatomic, strong) UIView *privilegeView;
/** 特权标题*/
@property (nonatomic, strong) UILabel *levelPowerTitleLb;
/** 分割线*/
@property (nonatomic, strong) UIView *powerLineView;
/** 特权图*/
//@property (nonatomic, strong) UICollectionView *privilegeCollectionView;
//@property (nonatomic, strong) NSMutableArray *privilegeData;
@property (nonatomic, strong) UIWebView *webView;


/** 切割线*/
@property (nonatomic, strong) UIView *middleLineView;


/** 等级视图*/
@property (nonatomic, strong) UIView *levelView;
/** 等级视图标题*/
@property (nonatomic, strong) UILabel *levelTitleLb;
/** 分割线*/
@property (nonatomic, strong) UIView *levelLineView;
/** 等级列表*/
@property (nonatomic, strong) UITableView *levelTableView;
/** 等级数据*/
@property (nonatomic, strong) NSMutableArray *levelData;


/** 数据源*/
@property (nonatomic, strong) MyLevelModel *model;


@end

@implementation MyLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"我的荣誉";
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.privilegeView];
    [self.contentView addSubview:self.middleLineView];
    [self.contentView addSubview:self.levelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(175);
    [self autoLayoutTopSubViews];
    
    _privilegeView.sd_layout
    .topSpaceToView(_topView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
//    .heightIs(245);
    [self autoLayoutPrivillageSubViews];
    
    _middleLineView.sd_layout
    .topSpaceToView(_privilegeView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
    
    _levelView.sd_layout
    .topSpaceToView(_middleLineView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    [self autoLayoutLevelSubViews];
    
    [self.contentView setupAutoContentSizeWithBottomView:_levelView bottomMargin:0];

    [self loadData];//加载数据


}
/** 自动头部视图布局*/
- (void)autoLayoutTopSubViews{
    _headIv.sd_layout
    .centerXEqualToView(_topView)
    .topSpaceToView(_topView, 30)
    .heightIs(75)
    .widthIs(105);

    _userNameLb.sd_layout
    .centerXEqualToView(_headIv)
    .bottomSpaceToView(_topView, 30)
    .heightIs(14);
    [_userNameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
//

}
/** 布局特权视图*/
- (void)autoLayoutPrivillageSubViews{
    _levelPowerTitleLb.sd_layout
    .centerYIs(22.5)
    .leftSpaceToView(_privilegeView, 15)
    .rightSpaceToView(_privilegeView, 15)
    .autoHeightRatio(0);
    
    _powerLineView.sd_layout
    .topSpaceToView(_privilegeView, 45)
    .leftSpaceToView(_privilegeView, 15)
    .rightSpaceToView(_privilegeView, 0)
    .heightIs(0.5);
    
    
    _webView.sd_layout
    .topSpaceToView(_powerLineView, 0)
    .leftSpaceToView(_privilegeView, 0)
    .rightSpaceToView(_privilegeView, 0)
    .heightIs(10);
//    NSInteger l = _privilegeData.count / 3;
//    if (_privilegeData.count % 3) {
//        l += 1;
//    }
//    
//    _privilegeCollectionView.sd_layout
//    .topSpaceToView(_powerLineView, 0)
//    .leftSpaceToView(_privilegeView, 0)
//    .rightSpaceToView(_privilegeView, 0)
//    .heightIs(l *88);
    [_privilegeView setupAutoHeightWithBottomView:_webView bottomMargin:10];

}
/** 自动布局等级视图*/
- (void)autoLayoutLevelSubViews{
    _levelTitleLb.sd_layout
    .centerYIs(22.5)
    .leftSpaceToView(_levelView, 15)
    .rightSpaceToView(_levelView, 15)
    .autoHeightRatio(0);
    
    _levelLineView.sd_layout
    .topSpaceToView(_levelView, 45)
    .leftSpaceToView(_levelView, 15)
    .rightSpaceToView(_levelView, 0)
    .heightIs(0.5);
    
    _levelTableView.sd_layout
    .topSpaceToView(_levelLineView, 0)
    .leftSpaceToView(_levelView, 0)
    .rightSpaceToView(_levelView, 0)
    .heightIs(_levelData.count *45);
    
    [_levelView setupAutoHeightWithBottomView:_levelTableView bottomMargin:0];
    

}

#pragma mark ----------------数据

/** 初始化数据*/
- (void)initData{
//    _privilegeData = [[NSMutableArray alloc] initWithObjects:@"0",@"1", @"2", @"3", @"4", @"5", nil];
    _levelData = [[NSMutableArray alloc] init];
}

- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [ShareBusinessManager.userManager postMyLevelGradeListWithParameters:nil
                                                                 success:^(id responObject) {                                                                     
                                                                     weakself.model = responObject;
                                                                     [weakself changeUI];
                                                                     [SVProgressHUD dismiss];
                                                                 } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];
}

- (void)changeUI{
    _userNameLb.text = [NSString stringWithFormat:@"我的等级：%@",_model.userData.name];
    _levelPowerTitleLb.text = [NSString stringWithFormat:@"%@特权",_model.userData.name];
    [_webView loadHTMLString:_model.service baseURL:nil];
    [_levelData removeAllObjects];
    [_levelData addObjectsFromArray:_model.gradeList];
    [_levelTableView reloadData];
    _levelTableView.sd_layout
    .heightIs(_levelData.count *45);

}

#pragma mark ----------------web代理

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat scrollHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];//获取html高度
    [self.webView setHeight_sd:scrollHeight];//修改高度
    [self.privilegeView updateLayout];//立马布局
}

//停止加载
- (void)dealloc{
    _webView.delegate = nil;
    [_webView stopLoading];
}


//#pragma mark ----------------collectionView代理

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _privilegeData.count;
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    PrivilegeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"privilegecell" forIndexPath:indexPath];
//    return cell;
//
//}

#pragma mark ----------------tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _levelData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LevelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelCell"];
    MyLevelUpItemModel *model =_levelData[indexPath.row];
    cell.model = model;
    GOLFWeakObj(self);
    cell.block = ^(id responObject){
        //跳转升级界面
        MyUpLevelViewController *upLevelVc = [[MyUpLevelViewController alloc] init];
        upLevelVc.currentModel = responObject;
        upLevelVc.gradeList = [_model.gradeList mutableCopy];
        [weakself.navigationController pushViewController:upLevelVc animated:YES];
    };
    return cell;
}


#pragma mark ----------------实例化

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = RGBColor(240, 103, 80);
        [_topView addSubview:self.headIv];
        [_topView addSubview:self.userNameLb];
//        [_topView addSubview:self.topIv];
//        [_topView addSubview:self.pointsLb];
        //        [_topView addSubview:self.pointsView];
        //        [_topView addSubview:self.pointsDetailBtn];
    }
    return _topView;
    
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image  = IMAGE(@"classify201");
    }
    return _headIv;
}
//
- (UILabel *)userNameLb{
    if (!_userNameLb) {
        _userNameLb= [[UILabel alloc] init];
        _userNameLb.font = FONT(14);
        _userNameLb.textColor = WHITECOLOR;
        _userNameLb.text = [NSString stringWithFormat:@"我的等级：%@", [UserModel sharedUserModel].gradeName];
    }
    return _userNameLb;
}
//
//- (LevelProgressView *)progressView{
//    if (!_progressView) {
//        _progressView = [[LevelProgressView alloc] init];
//        _progressView.backgroundColor = ClearColor;
//    }
//    return _progressView;
//}


- (UIView *)privilegeView{
    if (!_privilegeView) {
        _privilegeView = [[UIView alloc] init];
        _privilegeView.backgroundColor = WHITECOLOR;
        [_privilegeView addSubview:self.levelPowerTitleLb];
        [_privilegeView addSubview:self.powerLineView];
        [_privilegeView addSubview:self.webView];
    }
    return _privilegeView;
}


- (UILabel *)levelPowerTitleLb{
    if (!_levelPowerTitleLb) {
        _levelPowerTitleLb = [[UILabel alloc] init];
        _levelPowerTitleLb.font = FONT(14);
        _levelPowerTitleLb.textColor = BLACKTEXTCOLOR;
        _levelPowerTitleLb.text = @"会员特权";
    }
    return _levelPowerTitleLb;

}

- (UIView *)powerLineView{
    if (!_powerLineView) {
        _powerLineView = [[UIView alloc] init];
        _powerLineView.backgroundColor = GRAYCOLOR;
    }
    return _powerLineView;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.backgroundColor = WHITECOLOR;
        _webView.delegate = self;
        _webView.opaque = NO;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}


//- (UICollectionView *)privilegeCollectionView{
//    if (!_privilegeCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(SCREEN_WIDTH / 3, 88);
//        layout.minimumLineSpacing = 0;
//        layout.minimumInteritemSpacing = 0;
//        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        _privilegeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        _privilegeCollectionView.backgroundColor = WHITECOLOR;
//        _privilegeCollectionView.delegate = self;
//        _privilegeCollectionView.dataSource = self;
//        [_privilegeCollectionView registerClass:[PrivilegeCollectionViewCell class] forCellWithReuseIdentifier:@"privilegecell"];
//    }
//    return _privilegeCollectionView;
//}

- (UIView *)middleLineView{
    if (!_middleLineView) {
        _middleLineView = [[UIView alloc] init];
        _middleLineView.backgroundColor = GRAYCOLOR;
    }
    return _middleLineView;
}

- (UIView *)levelView{
    if (!_levelView) {
        _levelView = [[UIView alloc] init];
        _levelView.backgroundColor = WHITECOLOR;
        [_levelView addSubview:self.levelTitleLb];
        [_levelView addSubview:self.levelLineView];
        [_levelView addSubview:self.levelTableView];
    }
    return _levelView;


}

- (UILabel *)levelTitleLb{
    if (!_levelTitleLb) {
        _levelTitleLb = [[UILabel alloc] init];
        _levelTitleLb.font = FONT(14);
        _levelTitleLb.textColor = BLACKTEXTCOLOR;
        _levelTitleLb.text = @"会员等级";
    }
    return _levelTitleLb;
}

- (UIView *)levelLineView{
    if (!_levelLineView) {
        _levelLineView  = [[UIView alloc] init];
        _levelLineView.backgroundColor = GRAYCOLOR;
    }
    return _levelLineView;
}

- (UITableView *)levelTableView{
    if (!_levelTableView) {
        _levelTableView = [[UITableView alloc] init];
        _levelTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _levelTableView.delegate = self;
        _levelTableView.dataSource = self;
        _levelTableView.backgroundColor = WHITECOLOR;
        [_levelTableView registerClass:[LevelTableViewCell class] forCellReuseIdentifier:@"levelCell"];
    }
    return _levelTableView;

}

@end
