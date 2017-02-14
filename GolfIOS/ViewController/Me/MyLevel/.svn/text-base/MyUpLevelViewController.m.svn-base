//
//  MyUpLevelViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyUpLevelViewController.h"
#import "MylevelUpSuccessViewController.h"

@interface MyUpLevelViewController ()
<
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UITableViewDelegate,
    UITableViewDataSource
>

/** 第一句*/
@property (nonatomic, strong) UILabel *firstLb;
/** 第二句*/
@property (nonatomic, strong) UILabel *secondLb;
/** 第三局*/
@property (nonatomic, strong) UILabel *thirdLb;
/** 图标*/
@property (nonatomic, strong) UIImageView *iv;
/** 升级视图*/
@property (nonatomic, strong) UIView *levelUpView;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 选择视图*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 升级数据*/
@property (nonatomic, strong) NSMutableArray *levelUpData;
/** 升级按钮*/
@property (nonatomic, strong) UIButton *upBtn;
/** 提示信息图*/
@property (nonatomic, strong) UIView *noticeView;
/** 提示语*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 协议*/
@property (nonatomic, strong) UIButton *ruleBtn;


/** 弹窗支付*/
@property (nonatomic, strong) UIView *payBackView;
/** 支付金额*/
@property (nonatomic, strong) UILabel *payPriceLb;
/** 支付标题*/
@property (nonatomic, strong) UILabel *tpayTitleLb;
/** 支付方式*/
@property (nonatomic, strong) UITableView *payTableView;
/** 支付方式数据源*/
@property (nonatomic, strong) NSArray *payData;

//当前选择支付
@property (nonatomic, assign) NSInteger currentSelectIndex;







@end

@implementation MyUpLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"升级";
    [self.contentView addSubview:self.firstLb];
    [self.contentView addSubview:self.secondLb];
    [self.contentView addSubview:self.thirdLb];
    [self.contentView addSubview:self.iv];
    [self.contentView addSubview:self.levelUpView];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.payBackView];
    
    [GOLFNotificationCenter addObserver:self selector:@selector(getPayResult:) name:PayResult object:nil];//注册通知中心处理支付回调结果
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutLevelInfoSubViews];
    [self changeUI];
    [self loadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:_currentSelectIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

/** 自动布局上半部信息*/
- (void)autoLayoutLevelInfoSubViews{
//    _firstLb.isAttributedContent = YES;
    _firstLb.sd_layout
    .topSpaceToView(self.contentView, 37)
    .centerXEqualToView(self.contentView)
    .widthIs(SCREEN_WIDTH)
    .heightIs(18);
//    [_firstLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _secondLb.sd_layout
    .topSpaceToView(_firstLb, 10)
    .centerXEqualToView(self.contentView)
    .widthIs(SCREEN_WIDTH)
    .heightIs(14);
    
    _thirdLb.sd_layout
    .topSpaceToView(_secondLb, 10)
    .centerXEqualToView(self.contentView)
    .autoHeightRatio(0);
    [_thirdLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _iv.sd_layout
    .topSpaceToView(_thirdLb, 10)
    .centerXEqualToView(self.contentView)
    .heightIs(89)
    .widthIs(165);
    
    _levelUpView.sd_layout
    .topSpaceToView(_iv, 0)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0);
    [self autoLayouLevelUpSubViews];
    
    [self.contentView setupAutoContentSizeWithBottomView:_levelUpView bottomMargin:0];
    
}
/** 布局升级视图*/
- (void)autoLayouLevelUpSubViews{
    _titleLb.sd_layout
    .centerYIs(22.5)
    .leftSpaceToView(_levelUpView, 15)
    .rightSpaceToView(_levelUpView, 15)
    .autoHeightRatio(0);
    
    NSInteger l = _levelUpData.count / 2;
    if (_levelUpData.count % 2) {
        l += 1;
    }
    
    _collectionView.sd_layout
    .topSpaceToView(_levelUpView, 45)
    .leftSpaceToView(_levelUpView, 15)
    .rightSpaceToView(_levelUpView, 15)
    .heightIs(l * 125);
    
    _upBtn.sd_layout
    .topSpaceToView(_collectionView, 10)
    .leftSpaceToView(_levelUpView, 15)
    .rightSpaceToView(_levelUpView, 15)
    .heightIs(45);
    [_upBtn setSd_cornerRadius:@5];
    
    _noticeView.sd_layout
    .centerXEqualToView(_levelUpView)
    .topSpaceToView(_upBtn, 15)
    .heightIs(10);
    
    _noticeLb.sd_layout
    .topSpaceToView(_noticeView, 0)
    .leftSpaceToView(_noticeView, 0)
    .heightIs(10);
    [_noticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _ruleBtn.sd_layout
    .topSpaceToView(_noticeView, 0)
    .leftSpaceToView(_noticeLb, 0)
    .heightIs(10);
    [_ruleBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:10];
    
    [_noticeView setupAutoWidthWithRightView:_ruleBtn rightMargin:0];
    
    [_levelUpView setupAutoHeightWithBottomView:_noticeView bottomMargin:20];
    
}

#pragma mark ----------------数据

/** 初始化数据*/
- (void)initData{
    [_gradeList removeObjectAtIndex:0];//剔除当前等级
    _levelUpData = [NSMutableArray arrayWithArray:_gradeList];
    _payData = @[@"支付宝支付", @"微信支付", @"银联支付", @"取消"];

    for (NSInteger i = 0; i < _levelUpData.count; i++) {
        MyLevelUpItemModel *model = _levelUpData[i];
        if (model.sort == _currentModel.sort) {
            _currentSelectIndex = i;
        }
    }
}

- (void)changeUI{
    
    MyLevelUpItemModel *model = _levelUpData[_currentSelectIndex];
    
//    NSString *text = @"3000鸟币一年就能获得伯爵等级";
    NSString *text_0 = [NSString stringWithFormat:@"%@鸟币一年就能获得%@等级", model.cash,model.name];
    NSMutableAttributedString *aSt = [[NSMutableAttributedString alloc] initWithString:text_0];
    [aSt addAttributes:@{NSFontAttributeName:FONT(18), NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(0, model.cash.length)];
    [aSt addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(model.cash.length + 8, model.name.length)];
    _firstLb.attributedText= aSt;

    
//    NSString *text = @"充值还送3000鸟币";
    NSString *text_1 = [NSString stringWithFormat:@"充值还送%@鸟币", model.cash];
    _secondLb.attributedText = [text_1 attributeStrWithAttributes:@{NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(4, model.cash.length)];
    
    [_payTableView reloadData];//刷新支付标题
}

- (void)loadData{
    
    if (!_gradeList) {
        _gradeList = [[NSMutableArray alloc] init];
    }
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [ShareBusinessManager.userManager postMyLevelGradeListWithParameters:nil
                                                                 success:^(id responObject) {
                                                                     [SVProgressHUD dismiss];
                                                                     MyLevelModel *model= responObject;
                                                                     [weakself.gradeList removeAllObjects];
                                                                     [weakself.gradeList addObjectsFromArray:model.gradeList];
                                                                     [weakself initData];
//                                                                     weakself.currentSelectIndex = 0;
                                                                     [weakself.collectionView reloadData];
                                                                 } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];

}

#pragma mark ----------------界面逻辑
/** 点击升级按钮*/
- (void)uplevelAction{
//    [SVProgressHUD showSuccessWithStatus:@"点击了我要升级"];
    [UIView animateWithDuration:0.25 animations:^{
        _payBackView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    }];

}
/** 查看荣誉升级协议*/
- (void)lookRuleAction{
    [SVProgressHUD showSuccessWithStatus:@"点击了查看协议"];
}
/** payBackView*/
- (void)payBackGroundViewAction{
    [UIView animateWithDuration:0.25 animations:^{
        _payBackView.transform = CGAffineTransformIdentity;
    }];
}

/** 点击选择支付方式进行支付*/
- (void)selectPayStyleBy:(UIButton *)btn{
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0:
        {//支付宝
            [self payLevelWithChannel:@10];
        }
            break;
        case 1:
        {//微信
            [self payLevelWithChannel:@20];
        }
            break;
        case 2:
        {
            [SVProgressHUD showSuccessWithStatus:@"暂未开通"];
        }
            break;
        case 3:
        {//取消
            [self payBackGroundViewAction];
        }
            break;
        default:
            break;
    }
}

- (void)payLevelWithChannel:(NSNumber *)channel{
    weak(self);
    [SVProgressHUD showWithStatus:@"支付中"];
    MyLevelUpItemModel *model = _levelUpData[_currentSelectIndex];
    [ShareBusinessManager.userManager postMyLevelUpWithParameters:@{@"channel":channel,
                                                                    @"gradeId":model.ID}
                                                          success:^(id responObject) {
                                                              [SVProgressHUD dismiss];
                                                              if ([channel isEqualToNumber:@20]) {
                                                                  PayReq *request = [[PayReq alloc] init];
                                                                  request.partnerId = responObject[@"partnerid"];
                                                                  request.prepayId= responObject[@"prepayid"];
                                                                  request.package = responObject[@"package"];
                                                                  request.nonceStr= responObject[@"noncestr"];
                                                                  request.timeStamp= [responObject[@"timestamp"] intValue];
                                                                  request.sign= responObject[@"sign"];
                                                                  [WXApi sendReq:request];
                                                              }else if([channel isEqualToNumber:@10]){
                                                                  [[AlipaySDK defaultService] payOrder:responObject fromScheme:@"wx7a25750ee0abd6de" callback:^(NSDictionary *resultDic) {
                                                                      [weakSelf aletInfoWithCode:[resultDic[@"resultStatus"] integerValue]];
                                                                  }];
                                                              }
                                                              
                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                          }];
}

#pragma mark ----------------统一支付结果结果回调
/** 支付回调*/
- (void)getPayResult:(NSNotification *)notification{
    //获取支付结果
    NSDictionary *dict = notification.userInfo;
    int code = [dict[@"code"] intValue];
    [self aletInfoWithCode:code];
}
/** 根据支付返回码弹窗*/
- (void)aletInfoWithCode:(NSInteger)code{
    [self payBackGroundViewAction];//移除支付列表
    MyLevelUpItemModel *model = _levelUpData[_currentSelectIndex];
    NSLog(@"%ld-------", model.sort);
    switch (code) {
        case 0:{
            [SVProgressHUD dismiss];
            [[UserModel sharedUserModel] setSort:model.sort];
            MylevelUpSuccessViewController *successVc = [[MylevelUpSuccessViewController alloc] init];
            successVc.sort = model.sort;
            [self.navigationController pushViewController:successVc animated:YES];
        }
            break;
        case (-1):{
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
            break;
        case (-2):
        {
            [SVProgressHUD showErrorWithStatus:@"取消支付"];
        }
            break;
        case 9000:{
            [SVProgressHUD dismiss];
            [[UserModel sharedUserModel] setSort:model.sort];

            MylevelUpSuccessViewController *successVc = [[MylevelUpSuccessViewController alloc] init];
            successVc.sort = model.sort;
            [self.navigationController pushViewController:successVc animated:YES];
        }
            break;
        case 6001:{
            [SVProgressHUD showErrorWithStatus:@"取消支付"];
        }
            break;
        case 4000:{
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
            break;
        case 5000:{
            [SVProgressHUD showErrorWithStatus:@"重复请求"];
        }
            break;
        case 6002:{
            [SVProgressHUD showErrorWithStatus:@"网络连接出错"];
        }
            break;
        default:
            break;
    }
}

#pragma mark ----------------collectionview代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _levelUpData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"levelUpCell" forIndexPath:indexPath];
    cell.contentView.layer.borderWidth = 1;
    cell.contentView.layer.borderColor = GRAYCOLOR.CGColor;
    cell.contentView.layer.cornerRadius = 5;
    
    UILabel *lb;
    
    if (!cell.contentView.subviews.count) {
        lb = [[UILabel alloc] init];
        lb.font = FONT(30);
        lb.textColor = BLACKTEXTCOLOR;
        [cell.contentView addSubview:lb];
        lb.sd_layout
        .centerXEqualToView(cell.contentView)
        .centerYEqualToView(cell.contentView)
        .autoHeightRatio(0);
        [lb setSingleLineAutoResizeWithMaxWidth:150];
    }else{
        lb = cell.contentView.subviews.firstObject;
        lb.textColor = BLACKTEXTCOLOR;
    }
    MyLevelUpItemModel *model = _levelUpData[indexPath.row];
    lb.text = model.name;

    if (_currentSelectIndex == indexPath.row) {
        cell.contentView.layer.borderColor  = GLOBALCOLOR.CGColor;
        lb.textColor = GLOBALCOLOR;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor  = GLOBALCOLOR.CGColor;
    UILabel *lb = cell.contentView.subviews.firstObject;
    lb.textColor = GLOBALCOLOR;
    if (_currentSelectIndex == indexPath.row) {
        //继续点击上次位置不做响应
        return;
    }
    _currentSelectIndex = indexPath.row;
    [self changeUI];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor  = GRAYCOLOR.CGColor;
    UILabel *lb = cell.contentView.subviews.firstObject;
    lb.textColor = BLACKTEXTCOLOR;;

}

#pragma mark ----------------tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _payData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view addSubview:self.tpayTitleLb];
    [view addSubview:self.payPriceLb];
    
    _tpayTitleLb.sd_layout
    .centerXEqualToView(view)
    .topSpaceToView(view, 30)
    .autoHeightRatio(0);
    [_tpayTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _payPriceLb.sd_layout
    .topSpaceToView(_tpayTitleLb, 10)
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .heightIs(25);
    
    MyLevelUpItemModel *model = _levelUpData[_currentSelectIndex];
    NSString *text = [NSString stringWithFormat:@"¥%@", model.cash];
    _payPriceLb.attributedText = [text attributeStrWithAttributes:@{NSFontAttributeName:FONT(15)} range:NSMakeRange(0, 1)];
    return view;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 45)];
    btn.titleLabel.font = FONT(14);
    btn.layer.cornerRadius = 5;
    btn.tag = indexPath.row;
    NSString *text = _payData[indexPath.row];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(selectPayStyleBy:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:btn];
    switch (indexPath.row) {
        case 0:
        {
            [btn setBackgroundColor:RGBColor(39, 122, 254)];
        }
            break;
        case 1:
        {
            [btn setBackgroundColor:GLOBALCOLOR];
        }
            break;
        case 2:
        {
            [btn setBackgroundColor:[UIColor orangeColor]];
        }
            break;
        case 3:
        {
            [btn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateNormal];
            [btn setBackgroundColor:WHITECOLOR];
            btn.layer.borderColor = GRAYCOLOR.CGColor;;
            btn.layer.borderWidth = 1;
        }
            break;
            
        default:
            break;
    }
    return cell;
}



#pragma mark ----------------实例

- (UILabel *)firstLb{
    if (!_firstLb) {
        _firstLb = [[UILabel alloc] init];
        _firstLb.textColor = BLACKTEXTCOLOR;
        _firstLb.font = FONT(14);
        _firstLb.textAlignment = NSTextAlignmentCenter;
//        NSString *text = @"3000鸟币一年就能获得伯爵等级";
//        NSMutableAttributedString *aSt = [[NSMutableAttributedString alloc] initWithString:text];
//        [aSt addAttributes:@{NSFontAttributeName:FONT(18), NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(0, 4)];
//        [aSt addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(12, 2)];
//        _firstLb.attributedText= aSt;
    }
    return _firstLb;
}

- (UILabel *)secondLb{
    if (!_secondLb) {
        _secondLb = [[UILabel alloc] init];
        _secondLb.font = FONT(14);
        _secondLb.textColor = BLACKTEXTCOLOR;
        _secondLb.textAlignment = NSTextAlignmentCenter;
//        NSString *text = @"充值还送3000鸟币";
//        _secondLb.attributedText = [text attributeStrWithAttributes:@{NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(4, 4)];
    }
    return _secondLb;
}

- (UILabel *)thirdLb{
    if (!_thirdLb) {
        _thirdLb = [[UILabel alloc] init];
        _thirdLb.textColor = BLACKTEXTCOLOR;
        _thirdLb.font = FONT(14);
        _thirdLb.textAlignment = NSTextAlignmentCenter;
        NSString *text = @"1鸟币=1人民币";
        NSMutableAttributedString *aSt = [[NSMutableAttributedString alloc] initWithString:text];
        [aSt addAttribute:NSForegroundColorAttributeName value:BLACKCOLOR range:NSMakeRange(0, 1)];
        [aSt addAttribute:NSForegroundColorAttributeName value:BLACKCOLOR range:NSMakeRange(4, 1)];
        _thirdLb.attributedText = aSt;
    }
    return _thirdLb;
}

- (UIImageView *)iv{
    if (!_iv) {
        _iv = [[UIImageView alloc] init];
        _iv.image = IMAGE(@"classify127");
    }
    return _iv;
}

- (UIView *)levelUpView{
    if (!_levelUpView) {
        _levelUpView  = [[UIView alloc] init];
        _levelUpView.backgroundColor = WHITECOLOR;
        
        [_levelUpView sd_addSubviews:@[self.titleLb, self.collectionView, self.upBtn, self.noticeView]];
    }
    return _levelUpView;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"会员等级：";
    }
    return _titleLb;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45) / 2, 115);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = WHITECOLOR;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"levelUpCell"];
    }
    return _collectionView;
}

- (UIButton *)upBtn{
    if (!_upBtn) {
        _upBtn = [[UIButton alloc] init];
        _upBtn.backgroundColor = GLOBALCOLOR;
        _upBtn.titleLabel.font = FONT(14);
        [_upBtn setTitle:@"我要去升级" forState:UIControlStateNormal];
        [_upBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_upBtn addTarget:self action:@selector(uplevelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upBtn;
}

- (UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc] init];
        [_noticeView addSubview:self.noticeLb];
        [_noticeView addSubview:self.ruleBtn];
    }
    return _noticeView;
}

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(10);
        _noticeLb.textColor = LIGHTTEXTCOLOR;
        _noticeLb.text = @"点击我要去升级，表示您已经同意小鸟娱动";
    }
    return _noticeLb;
}

- (UIButton *)ruleBtn{
    if (!_ruleBtn) {
        _ruleBtn = [[UIButton alloc] init];
        _ruleBtn.titleLabel.font = FONT(10);
        [_ruleBtn setTitle:@"荣誉升级协议" forState:UIControlStateNormal];
        [_ruleBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_ruleBtn addTarget:self action:@selector(lookRuleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ruleBtn;
}

- (UIView *)payBackView{
    if (!_payBackView) {
        _payBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _payBackView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
        [_payBackView addSubview:self.payTableView];
        _payTableView.sd_layout
        .bottomSpaceToView(_payBackView, 0)
        .leftSpaceToView(_payBackView, 0)
        .rightSpaceToView(_payBackView, 0)
        .heightIs(60 *_payData.count + 115);
        
        UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payBackGroundViewAction)];
        [_payBackView addGestureRecognizer:tap];
    }
    return _payBackView;
}

- (UITableView *)payTableView{
    if (!_payTableView) {
        _payTableView = [[UITableView alloc] init];
        _payTableView.backgroundColor = WHITECOLOR;
        _payTableView.delegate = self;
        _payTableView.dataSource = self;
        _payTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _payTableView;
    
}

- (UILabel *)payPriceLb{
    if (!_payPriceLb) {
        _payPriceLb = [[UILabel alloc] init];
        _payPriceLb.font = FONT(25);
        _payPriceLb.textAlignment = NSTextAlignmentCenter;
        _payPriceLb.textColor = BLACKTEXTCOLOR;
    }
    return _payPriceLb;
}

- (UILabel *)tpayTitleLb{
    if (!_tpayTitleLb) {
        _tpayTitleLb = [[UILabel alloc] init];
        _tpayTitleLb.font = FONT(14);
        _tpayTitleLb.textColor = SHENTEXTCOLOR;
        _tpayTitleLb.text = @"需付款";
    }
    return _tpayTitleLb;
}



@end
