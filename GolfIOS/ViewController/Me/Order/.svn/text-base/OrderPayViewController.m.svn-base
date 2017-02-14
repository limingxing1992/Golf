//
//  OrderPayViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "OrderPayViewController.h"

@interface OrderPayViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
/** 订单信息*/
@property (nonatomic, strong) UIView *infoView;

/** 总价标题*/
@property (nonatomic, strong) UILabel *totalPriceTitleLb;

/** 价格*/
@property (nonatomic, strong) UILabel *totalPriceLb;

/** 订单编号*/
@property (nonatomic, strong) UILabel *orderNumLb;
/** 订单时间*/
@property (nonatomic, strong) UILabel *orderTimeLb;





/** APP货币支付视图*/
@property (nonatomic, strong) UIView *shellPayView;
/** 小鸟钱包*/
@property (nonatomic, strong) UILabel *shellTitle;
/** 余额*/
@property (nonatomic, strong) UILabel *balanceLb;
/** 提示语*/
@property (nonatomic, strong) UILabel *noticeBirdLb;
/** 余额支付开关*/
@property (nonatomic, strong) UISwitch *shellSwitch;

/** 支付方式选择视图*/
@property (nonatomic, strong) UITableView *tableView;
/** 支付方式数据*/
@property (nonatomic, strong) NSArray *payStyleData;
/** 支付方式 0 == 支付宝  1== 微信 2== 银联 默认支付宝*/
@property (nonatomic, assign) NSInteger payStatus;
/** 是否使用余额支付*/
@property (nonatomic, assign) BOOL useBalance;

/** 当前订单金额*/
@property (nonatomic, assign) float totalPrice;

/** 支付按钮视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 支付按钮*/
@property (nonatomic, strong) UIButton *payBtn;

@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"支付订单";
    [self.contentView addSubview:self.infoView];
    [self.contentView addSubview:self.shellPayView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.bottomView];
    
    [GOLFNotificationCenter addObserver:self selector:@selector(getPayResult:) name:PayResult object:nil];//注册通知中心处理支付回调结果
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];//布局
}

- (void)viewDidAppear:(BOOL)animated{
    //判断余额是否足以支付
    BOOL ret = [self okUseBlanceMoneyPayForOrder];
    if (ret) {
        //余额足以支付//关闭支付方式
        [GOLFNotificationCenter postNotificationName:@"payNoti" object:nil userInfo:@{@"isOpen":@0}];
    }else{
        //余额不足以支付//打开支付方式
        [GOLFNotificationCenter postNotificationName:@"payNoti" object:nil userInfo:@{@"isOpen":@1}];
        
        if ([UserModel sharedUserModel].money.floatValue == 0) {
            //当前账户无余额
            _shellSwitch.enabled = NO;
            [_shellSwitch setOn:NO];
            _useBalance = NO;
        }

    }
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

#pragma mark ----------------布局界面

/** 自动布局*/
- (void)autoLayoutSubViews{
    _infoView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(135);
    [self autoLayoutInfoViewSubViews];
    
    
    _shellPayView.sd_layout
    .topSpaceToView(_infoView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(45);
    [self autoLayoutShellViewSubViews];
    
    _tableView.sd_layout
    .topSpaceToView(_shellPayView, 0.5)
    .rightSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(45 + _payStyleData.count * 60);
    
    _bottomView.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(60);
    
    _payBtn.sd_layout
    .centerYEqualToView(_bottomView)
    .leftSpaceToView(_bottomView, 15)
    .rightSpaceToView(_bottomView, 15)
    .heightIs(40);
    [_payBtn setSd_cornerRadius:@5];
    [self.contentView setupAutoContentSizeWithBottomView:_bottomView bottomMargin:0];
    
}
/** 布局支付视图*/
- (void)autoLayoutShellViewSubViews{
    _shellTitle.sd_layout
    .centerYEqualToView(_shellPayView)
    .leftSpaceToView(_shellPayView, 15)
    .autoHeightRatio(0);
    [_shellTitle setSingleLineAutoResizeWithMaxWidth:300];
    
    _balanceLb.sd_layout
    .centerYEqualToView(_shellTitle)
    .leftSpaceToView(_shellTitle, 5)
    .autoHeightRatio(0);
    [_balanceLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _shellSwitch.sd_layout
    .centerYEqualToView(_shellPayView)
    .rightSpaceToView(_shellPayView, 15)
    .heightIs(30)
    .widthIs(50);
    
}
/** 布局订单信息视图*/
- (void)autoLayoutInfoViewSubViews{
    _totalPriceTitleLb.sd_layout
    .centerYIs(22.5)
    .leftSpaceToView(_infoView, 15)
    .autoHeightRatio(0);
    [_totalPriceTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _totalPriceLb.sd_layout
    .centerYEqualToView(_totalPriceTitleLb)
    .rightSpaceToView(_infoView, 15)
    .autoHeightRatio(0);
    [_totalPriceLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _orderNumLb.sd_layout
    .centerYIs(67.5)
    .leftEqualToView(_totalPriceTitleLb)
    .autoHeightRatio(0);
    [_orderNumLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _orderTimeLb.sd_layout
    .centerYIs(112.5)
    .leftEqualToView(_orderNumLb)
    .autoHeightRatio(0);
    [_orderTimeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
}


#pragma mark ----------------数据处理

/** 初始化数据*/
- (void)initData{
    _payStyleData = @[@"支付宝", @"微信",@"银联"];
    _totalPrice = [_model.orderInfo.totalPrice floatValue];
}

#pragma mark ----------------界面逻辑

/** 余额支付开关动作*/
- (void)useFiveShellAction:(UISwitch *)sender{
    
    _useBalance = sender.isOn;//开启和关闭五云珠支付
    BOOL ret = [self okUseBlanceMoneyPayForOrder];
    
    if (sender.isOn) {
        //余额支付打开
        if (ret) {
            //余额足以支付//关闭支付方式
            [GOLFNotificationCenter postNotificationName:@"payNoti" object:nil userInfo:@{@"isOpen":@0}];
        }else{
            //余额不足以支付//打开支付方式
            [GOLFNotificationCenter postNotificationName:@"payNoti" object:nil userInfo:@{@"isOpen":@1}];
        }
    }else{
        //余额支付关闭//打开支付方式
        [GOLFNotificationCenter postNotificationName:@"payNoti" object:nil userInfo:@{@"isOpen":@1}];
    }
}
/** 判断当前用户余额是否足以支付订单*/
- (BOOL)okUseBlanceMoneyPayForOrder{
    return [UserModel sharedUserModel].money.floatValue >= _totalPrice;
}
/** 支付发起动作*/
- (void)beginPayAction{
    
    
    [SVProgressHUD showWithStatus:@"正在支付"];
    //先判断五云珠是否打开
    //如果打开。判断余额是否足以支付订单
    //如果余额足以支付订单。调用余额支付
    //如果余额不足以支付订单。调用当前选中支付方式支付订单金额减去余额剩下金额
    BOOL ret = [self okUseBlanceMoneyPayForOrder];
    
    
    if (_useBalance) {
        //使用余额支付
        if (ret) {
            //余额足以支付订单金额
            //此处调用余额支付
            [self payWithUseBalanceShell];
        }else{
            //余额不足以支付
            [self payWithBlanceMoney];
        }
    }else{
        //不使用余额支付
        //使用当前选中支付方式支付
        [self payWithBlanceMoney];
    }
    
    
    
}
/** 使用余额支付*/
- (void)payWithUseBalanceShell{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderPayWithParameters:@{@"channel":@30,
                                                                     @"orderNo":_model.orderInfo.orderNo}
                                                           success:^(id responObject) {
                                                               [SVProgressHUD dismiss];
                                                               STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
                                                               successVc.orderNo =  weakself.model.orderInfo.orderNo;
                                                               successVc.type = 0;
                                                               successVc.orderPrice = weakself.model.orderInfo.totalPrice;
                                                               [weakself.navigationController pushViewController:successVc animated:YES];
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           }];
}
/** 使用第三方支付*/
- (void)payWithBlanceMoney{
    weak(self)
    //进入此方法只有两种情况。
    //1 使用余额支付。但余额不足
    //2 未使用余额支付
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (_useBalance) {
        //使用了余额支付
        [dict setValue:[UserModel sharedUserModel].money forKey:@"balance"];
    }else{
        [dict setValue:@"0" forKey:@"balance"];
    }
    
    [dict setValue:_model.orderInfo.orderNo forKey:@"orderNo"];
    [SVProgressHUD showWithStatus:@"支付中"];
    
    switch (_payStatus) {
        case 0:
        {
            //使用支付宝支付
            [dict setValue:@10 forKey:@"channel"];
            [ShareBusinessManager.userManager postMyOrderPayWithParameters:dict
                                                                   success:^(id responObject) {
                                                                       [SVProgressHUD dismiss];
                                                                       [[AlipaySDK defaultService] payOrder:responObject fromScheme:@"wx7a25750ee0abd6de" callback:^(NSDictionary *resultDic) {
                                                                           [weakSelf aletInfoWithCode:[resultDic[@"resultStatus"] integerValue]];
                                                                       }];
                                                                
                                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                   }];
        }
            break;
        case 1:
        {
            //使用微信
            [dict setValue:@20 forKey:@"channel"];
            [ShareBusinessManager.userManager postMyOrderPayWithParameters:dict
                                                                   success:^(id responObject) {
                                                                       [SVProgressHUD dismiss];
                                                                       PayReq *request = [[PayReq alloc] init];
                                                                       request.partnerId = responObject[@"partnerid"];
                                                                       request.prepayId= responObject[@"prepayid"];
                                                                       request.package = responObject[@"package"];
                                                                       request.nonceStr= responObject[@"noncestr"];
                                                                       request.timeStamp= [responObject[@"timestamp"] intValue];
                                                                       request.sign= responObject[@"sign"];
                                                                       [WXApi sendReq:request];
                                                                       
                                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                   }];

        }
            break;
        case 2:
        {
            [SVProgressHUD dismiss];
        }
            break;
        default:
            break;
    }
}


#pragma mark ----------------统一支付结果结果回调
/** 支付回调*/
- (void)getPayResult:(NSNotification *)notification{
    //获取支付结果
    //    weak(self);
    NSDictionary *dict = notification.userInfo;
    int code = [dict[@"code"] intValue];
    [self aletInfoWithCode:code];
}
/** 根据支付返回码弹窗*/
- (void)aletInfoWithCode:(NSInteger)code{
    switch (code) {
        case 0:{
            //微信支付成功
            [SVProgressHUD dismiss];
            STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
            successVc.orderNo = _model.orderInfo.orderNo;
            successVc.type = 0;
            successVc.orderPrice = _model.orderInfo.totalPrice;
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
            //支付宝支付成功
            [SVProgressHUD dismiss];
            STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
            successVc.orderNo = _model.orderInfo.orderNo;
            successVc.type = 0;
            successVc.orderPrice = _model.orderInfo.totalPrice;
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


#pragma mark ----------------tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payStyleData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    headView.backgroundColor = WHITECOLOR;
    UILabel *titleLb = [[UILabel alloc] init];
    titleLb.font = FONT(14);
    titleLb.textColor = BLACKTEXTCOLOR;
    titleLb.text = @"支付方式";
    [headView addSubview:titleLb];
    titleLb.sd_layout
    .centerYEqualToView(headView)
    .leftSpaceToView(headView, 15)
    .rightSpaceToView(headView, 15)
    .autoHeightRatio(0);
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
    [cell setInfoWith:self.payStyleData[indexPath.row]];
    cell.block = ^(id responObject){
        if ([responObject isEqualToString:@"支付宝"]) {
            self.payStatus = 0;
        }else if([responObject isEqualToString:@"微信"]){
            self.payStatus = 1;
        }else if ([responObject isEqualToString:@"银联"]){
            _payStatus = 2;
        }
    };
    return cell;
    
    
}


#pragma mark ----------------实例

- (UIView *)infoView{
    if (!_infoView) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = WHITECOLOR;
        for (NSInteger i = 0; i < 2; i++) {
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = GRAYCOLOR;
            [_infoView addSubview:lineView];
            
            lineView.sd_layout
            .topSpaceToView(_infoView, 45 *(i + 1))
            .rightSpaceToView(_infoView, 0)
            .leftSpaceToView(_infoView, 0)
            .heightIs(0.5);
        }
        [_infoView sd_addSubviews:@[self.totalPriceTitleLb, self.totalPriceLb, self.orderNumLb, self.orderTimeLb]];
    }
    return _infoView;
}

- (UILabel *)totalPriceTitleLb{
    if (!_totalPriceTitleLb) {
        _totalPriceTitleLb = [[UILabel alloc] init];
        _totalPriceTitleLb.font = FONT(16);
        _totalPriceTitleLb.textColor = BLACKTEXTCOLOR;
        _totalPriceTitleLb.text = @"订单总价";
    }
    return _totalPriceTitleLb;
}

- (UILabel *)totalPriceLb{
    if (!_totalPriceLb) {
        _totalPriceLb = [[UILabel alloc] init];
        _totalPriceLb.font = FONT(16);
        _totalPriceLb.textColor  = [UIColor redColor];
        _totalPriceLb.text = [NSString stringWithFormat:@"¥%@", _model.orderInfo.totalPrice];
    }
    return _totalPriceLb;
}

- (UILabel *)orderNumLb{
    if (!_orderNumLb) {
        _orderNumLb = [[UILabel alloc] init];
        _orderNumLb.font = FONT(14);
        _orderNumLb.textColor = BLACKTEXTCOLOR;
        _orderNumLb.text = [NSString stringWithFormat:@"订单编号：%@", _model.orderInfo.orderNo];
    }
    return _orderNumLb;
}

- (UILabel *)orderTimeLb{
    if (!_orderTimeLb) {
        _orderTimeLb = [[UILabel alloc] init];
        _orderTimeLb.font = FONT(14);
        _orderTimeLb.textColor = BLACKTEXTCOLOR;
        _orderTimeLb.text = [NSString stringWithFormat:@"预约时间：%@", _model.orderInfo.bookTime];
    }
    return _orderTimeLb;
}

- (UIView *)shellPayView{
    if (!_shellPayView) {
        _shellPayView = [[UIView alloc] init];
        _shellPayView.backgroundColor = WHITECOLOR;
        [_shellPayView sd_addSubviews:@[self.shellTitle, self.balanceLb,  self.shellSwitch]];
    }
    return _shellPayView;
    
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUNDCOLOR;
        _tableView.separatorColor = GRAYCOLOR;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"payCell"];
    }
    return _tableView;
}

- (UILabel *)shellTitle{
    if (!_shellTitle) {
        _shellTitle = [[UILabel alloc] init];
        _shellTitle.font = FONT(14);
        _shellTitle.textColor = BLACKTEXTCOLOR;
        _shellTitle.text = @"小鸟钱包";
    }
    return _shellTitle;
}

- (UILabel *)balanceLb{
    if (!_balanceLb) {
        _balanceLb = [[UILabel alloc] init];
        _balanceLb.font = FONT(12);
        _balanceLb.textColor = [UIColor redColor];
        _balanceLb.text = [NSString stringWithFormat:@"%@鸟币", [UserModel sharedUserModel].money] ;
    }
    return _balanceLb;
}

- (UILabel *)noticeBirdLb{
    if (!_noticeBirdLb) {
        _noticeBirdLb = [[UILabel alloc] init];
        _noticeBirdLb.font = FONT(12);
        _noticeBirdLb.textColor = SHENTEXTCOLOR;
        _noticeBirdLb.text = @"使用小鸟钱包，享受优惠哦";
        _noticeBirdLb.textAlignment = NSTextAlignmentRight;
    }
    return _noticeBirdLb;
}

- (UISwitch *)shellSwitch{
    if (!_shellSwitch) {
        _shellSwitch = [[UISwitch alloc] init];
        _shellSwitch.on = YES;
        _shellSwitch.onTintColor = GLOBALCOLOR;
        _shellSwitch.tintColor = GRAYCOLOR;
        [_shellSwitch addTarget:self action:@selector(useFiveShellAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _shellSwitch;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = WHITECOLOR;
        [_bottomView addSubview:self.payBtn];
    }
    return _bottomView;
}

- (UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_payBtn setBackgroundColor:GLOBALCOLOR];
        _payBtn.titleLabel.font = FONT(18);
        [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(beginPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

@end
