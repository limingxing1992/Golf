//
//  PayOrderViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "PayOrderViewController.h"

@interface PayOrderViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
/** 订单信息视图*/
@property (nonatomic, strong) UIView *infoView;
/** 球场标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 打球时间--标题*/
@property (nonatomic, strong) UILabel *timeTitleLb;
/** 打球日期*/
@property (nonatomic, strong) UILabel *timeDateLb;
/** 打球周几*/
@property (nonatomic, strong) UILabel *timeWeekLb;
/** 打球时间*/
@property (nonatomic, strong) UILabel *timeLb;

/** 信息列表*/
@property (nonatomic, strong) UITableView *userTableView;
/** 个人信息标题*/
@property (nonatomic, strong) NSArray *titleAry_0;
@property (nonatomic, strong) NSArray *titleAry_1;


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


/** 支付按钮视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 支付按钮*/
@property (nonatomic, strong) UIButton *payBtn;




/** 当前订单金额*/
@property (nonatomic, assign) float totalPrice;


/** 支付方式 0 == 支付宝  1== 微信 2== 银联 默认支付宝*/
@property (nonatomic, assign) NSInteger payStatus;
/** 是否使用余额支付*/
@property (nonatomic, assign) BOOL useBalance;




@end

@implementation PayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"支付订单";
    [self.contentView addSubview:self.infoView];
    [self.contentView addSubview:self.userTableView];
    [self.contentView addSubview:self.shellPayView];
    [self.contentView addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [GOLFNotificationCenter addObserver:self selector:@selector(getPayResult:) name:PayResult object:nil];//注册通知中心处理支付回调结果

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];//布局
}

- (void)viewDidAppear:(BOOL)animated{
    //判断余额是否足以支付
    _useBalance = _shellSwitch.isOn;
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


#pragma mark ----------------界面布局

/** 自动布局*/
- (void)autoLayoutSubViews{
    _infoView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(72);
    [self autoLayoutInfoViewSubViews];
    
    _userTableView.sd_layout
    .topSpaceToView(_infoView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(180);
    
    _shellPayView.sd_layout
    .topSpaceToView(_userTableView, 10)
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
    .bottomSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(60);
    
    _payBtn.sd_layout
    .centerYEqualToView(_bottomView)
    .leftSpaceToView(_bottomView, 15)
    .rightSpaceToView(_bottomView, 15)
    .heightIs(40);
    [_payBtn setSd_cornerRadius:@5];
    
    [self.contentView setupAutoContentSizeWithBottomView:_tableView bottomMargin:20];
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
/** 自动布局球场信息视图*/
- (void)autoLayoutInfoViewSubViews{
    _titleLb.sd_layout
    .centerYIs(18)
    .leftSpaceToView(_infoView, 15)
    .rightSpaceToView(_infoView, 15)
    .autoHeightRatio(0);
    
    _timeTitleLb.sd_layout
    .centerYIs(54)
    .leftEqualToView(_titleLb)
    .autoHeightRatio(0);
    [_timeTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeDateLb.sd_layout
    .centerYEqualToView(_timeTitleLb)
    .leftSpaceToView(_timeTitleLb, 5)
    .autoHeightRatio(0);
    [_timeDateLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _timeWeekLb.sd_layout
    .centerYEqualToView(_timeDateLb)
    .leftSpaceToView(_timeDateLb, 5)
    .autoHeightRatio(0);
    [_timeWeekLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _timeLb.sd_layout
    .centerYEqualToView(_timeWeekLb)
    .leftSpaceToView(_timeWeekLb, 5)
    .rightSpaceToView(_infoView, 15)
    .autoHeightRatio(0);
    
}

#pragma mark ----------------数据处理

/** 初始化数据*/
- (void)initData{
    _payStyleData = @[@"支付宝", @"微信",@"银联"];
    _titleAry_0 = @[@"打球人数", @"联系人姓名", @"联系人电话"];
    _titleAry_1 = @[@"备注"];
    float price = _model.price.floatValue;
    
    _totalPrice = price *_model.count;
    
    
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
/** 只用余额支付*/
- (void)payWithUseBalanceShell{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderPayWithParameters:@{@"channel":@30,
                                                                     @"orderNo":_orderNo}
                                                           success:^(id responObject) {
                                                               [SVProgressHUD dismiss];
                                                               PlaceSumbitSuccessViewController *successVc = [[PlaceSumbitSuccessViewController alloc] init];
                                                               [weakself.navigationController pushViewController:successVc animated:YES];
                                                           } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                               [SVProgressHUD showErrorWithStatus:errorMsg];
                                                           }];
}
/** 使用第三方支付*/
- (void)payWithBlanceMoney{
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
    
    if (!_orderNo) {
        [SVProgressHUD showErrorWithStatus:@"订单编号缺失"];
        return;
    }
    [dict setValue:_orderNo forKey:@"orderNo"];
    
    weak(self);
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
    NSDictionary *dict = notification.userInfo;
    int code = [dict[@"code"] intValue];
    [self aletInfoWithCode:code];
}
/** 根据支付返回码弹窗*/
- (void)aletInfoWithCode:(NSInteger)code{
    switch (code) {
        case 0:{
            [SVProgressHUD dismiss];
            PlaceSumbitSuccessViewController *successVc = [[PlaceSumbitSuccessViewController alloc] init];
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
            PlaceSumbitSuccessViewController *successVc = [[PlaceSumbitSuccessViewController alloc] init];
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
    if (tableView == _userTableView) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _userTableView) {
        if (section == 0) {
            return _titleAry_0.count;
        }else{
            return _titleAry_1.count;
        }
    }
    
    return self.payStyleData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _userTableView) {
        return 40;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _userTableView) {
        return 10;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == _userTableView) {
        return nil;
    }
    
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
    
    
    if (tableView == _userTableView) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"userCell"];
        cell.textLabel.font = FONT(12);
        cell.textLabel.textColor = BLACKTEXTCOLOR;
        cell.detailTextLabel.textColor = LIGHTTEXTCOLOR;
        cell.detailTextLabel.font = FONT(12);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.textLabel.text = _titleAry_0[indexPath.row];
            switch (indexPath.row) {
                case 0:
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld人",_model.count];
                }
                    break;
                case 1:
                {
                    cell.detailTextLabel.text = _model.connectName;
                }
                    break;
                case 2:
                {
                    cell.detailTextLabel.text = _model.connectPhone;
                }
                    break;
                default:
                    break;
            }
        }else{
            cell.textLabel.text = _titleAry_1[indexPath.row];
            cell.detailTextLabel.text = _model.connectNotice;
        }
        return cell;

    }
    
    
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
        [_infoView sd_addSubviews:@[self.titleLb, self.timeTitleLb, self.timeDateLb, self.timeWeekLb, self.timeLb]];
    }
    return _infoView;
}

- (UIView *)shellPayView{
    if (!_shellPayView) {
        _shellPayView = [[UIView alloc] init];
        _shellPayView.backgroundColor = WHITECOLOR;
        [_shellPayView sd_addSubviews:@[self.shellTitle, self.balanceLb, self.shellSwitch]];
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
        _balanceLb.textColor = OrangeCOLOR;
        _balanceLb.text = [NSString stringWithFormat:@"%@鸟币", [UserModel sharedUserModel].money];
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

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = _placeName;
    }
    return _titleLb;
}

- (UILabel *)timeTitleLb{
    if (!_timeTitleLb) {
        _timeTitleLb = [[UILabel alloc] init];
        _timeTitleLb.font = FONT(12);
        _timeTitleLb.textColor = LIGHTTEXTCOLOR;
        _timeTitleLb.text = @"打球时间";
    }
    return _timeTitleLb;
}

- (UILabel *)timeDateLb{
    if (!_timeDateLb) {
        _timeDateLb = [[UILabel alloc] init];
        _timeDateLb.font = FONT(14);
        _timeDateLb.textColor = GLOBALCOLOR;
        _timeDateLb.text = [NSString stringWithFormat:@"%.2ld月%.2ld号", _model.playDateMonth, _model.playDateDay];
    }
    return _timeDateLb;
}

- (UILabel *)timeWeekLb{
    if (!_timeWeekLb) {
        _timeWeekLb = [[UILabel alloc] init];
        _timeWeekLb.font = FONT(12);
        _timeWeekLb.textColor = LIGHTTEXTCOLOR;
        _timeWeekLb.text = _model.playWeek;
    }
    return _timeWeekLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(14);
        _timeLb.textColor = GLOBALCOLOR;
        _timeLb.text = _model.starTime;
    }
    return _timeLb;
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
        _payBtn.titleLabel.font = FONT(14);
        float price = _model.price.floatValue;
        price = price *_model.count;
        
        [_payBtn setTitle:[NSString stringWithFormat:@"确认支付 ¥%.2f",price] forState:UIControlStateNormal];
        [_payBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(beginPayAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;

}

- (UITableView *)userTableView{
    if (!_userTableView) {
        _userTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _userTableView.backgroundColor = BACKGROUNDCOLOR;
        _userTableView.separatorColor = GRAYCOLOR;
        _userTableView.separatorInset = UIEdgeInsetsZero;
        _userTableView.delegate = self;
        _userTableView.dataSource = self;
        _userTableView.scrollEnabled= NO;
        [_userTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"userCell"];
    }
    return _userTableView;
}

@end
