//
//  BirdWalletFillViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BirdWalletFillViewController.h"

@interface BirdWalletFillViewController ()
<
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource,
    UITextFieldDelegate,
    UITableViewDelegate,
    UITableViewDataSource
>
/** 上半部视图*/
@property (nonatomic, strong) UIView *topView;
/** 活动说明 */
@property (nonatomic, strong) UILabel *actionIntroduceLb_0;
@property (nonatomic, strong) UILabel *actionIntroduceLb_1;
@property (nonatomic, strong) UILabel *actionIntroduceLb_2;
/** 上半部视图——第二种输入其他金额*/
@property (nonatomic, strong) UIView *topView_else;
/** 标题*/
@property (nonatomic, strong) UILabel *elseTitleLb;
/** 输入框*/
@property (nonatomic, strong) UITextField *elseTf;
/** 提示*/
@property (nonatomic, strong) UILabel *elseNoticeLb;
/** 活动图标*/
@property (nonatomic, strong) UIImageView *actionIv;

/** 中间切割线*/
@property (nonatomic, strong) UIView *middleLineView;


/** 下班部视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 充值标题*/
@property (nonatomic, strong) UILabel *fillTitleLb;
/** 充值选择图*/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 充值选择数据*/
@property (nonatomic, strong) NSMutableArray *fillTitleData;
/** 充值按钮*/
@property (nonatomic, strong) UIButton *fillBtn;
/** 提示语承载体*/
@property (nonatomic, strong) UIView *noticeView;
/** 提示语*/
@property (nonatomic, strong) UILabel *noticeLb;
/** 充值协议*/
@property (nonatomic, strong) UIButton *fillRuleBtn;
/** 余额*/
@property (nonatomic, strong) UILabel *balanceLb;
/** 分割线*/
@property (nonatomic, strong) UIView *indicatiorLine;
/** 活动规则*/
@property (nonatomic, strong) UIButton *actionRuleBtn;

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





/** 保存用户当前选择支付余额,从0 到 N 对应数组，默认 100 无选择*/
@property (nonatomic, assign) NSInteger fillSelectIndex;

/** 当前支付金额*/
@property (nonatomic, strong) NSString *priceText;




@end

@implementation BirdWalletFillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"充值";
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.middleLineView];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.topView_else];
    [self.contentView setBackgroundColor:WHITECOLOR];

//    [self.view addSubview:self.payBackView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.payBackView];
    [self loadData];
    [GOLFNotificationCenter addObserver:self selector:@selector(getPayResult:) name:PayResult object:nil];//注册通知中心处理支付回调结果

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topView.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(245);
    [self autoLayoutTopSubViews];
    _middleLineView.sd_layout
    .topSpaceToView(self.contentView, 245)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(0.5);
    
    _bottomView.sd_layout
    .topSpaceToView(self.contentView, 245.5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    [self autoLayoutBottomSubViews];
    
    
    self.topView_else.sd_layout
    .topSpaceToView(self.contentView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(245);
    [self autoLayoutTopElseSubViews];
    
    [self.contentView setupAutoContentSizeWithBottomView:_bottomView bottomMargin:0];

    [self.topView_else removeFromSuperview];
    
    [self selectFillPriceByIndex:0];//默认选中第一个支付金额
}

- (void)viewDidAppear:(BOOL)animated{
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];

}

/** 自动布局上半部其他金额*/
- (void)autoLayoutTopElseSubViews{
    _elseTitleLb.sd_layout
    .topSpaceToView(_topView_else, 45)
    .centerXEqualToView(_topView_else)
    .autoHeightRatio(0);
    [_elseTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _elseTf.sd_layout
    .topSpaceToView(_elseTitleLb, 40)
    .leftSpaceToView(_topView_else, 45)
    .rightSpaceToView(_topView_else, 45)
    .heightIs(50);
    
    _elseNoticeLb.sd_layout
    .topSpaceToView(_elseTf, 20)
    .centerXEqualToView(_elseTitleLb)
    .autoHeightRatio(0);
    [_elseNoticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
}
/** 自动布局上半部*/
- (void)autoLayoutTopSubViews{
    _actionIntroduceLb_0.sd_layout
    .topSpaceToView(_topView, 50)
    .centerXEqualToView(_topView)
    .widthIs(SCREEN_WIDTH)
    .heightIs(25);
    
    _actionIntroduceLb_1.sd_layout
    .topSpaceToView(_actionIntroduceLb_0, 10)
    .centerXEqualToView(_actionIntroduceLb_0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(16);
    
    _actionIntroduceLb_2.sd_layout
    .topSpaceToView(_actionIntroduceLb_1, 10)
    .centerXEqualToView(_actionIntroduceLb_1)
    .widthIs(SCREEN_WIDTH)
    .heightIs(16);
    
    _actionIv.sd_layout
    .bottomSpaceToView(_topView, 0)
    .centerXEqualToView(_topView)
    .heightIs(85)
    .widthIs(165);
    
}
/** 自动布局下半部*/
- (void)autoLayoutBottomSubViews{
    
    _fillTitleLb.sd_layout
    .leftSpaceToView(_bottomView, 15)
    .rightSpaceToView(_bottomView, 15)
    .centerYIs(22.5)
    .autoHeightRatio(0);
    
    
    NSInteger count = _fillTitleData.count / 3;
    NSInteger bb = _fillTitleData.count % 3;
    if (bb) {
        count += 1;
    }
    _collectionView.sd_layout
    .topSpaceToView(_bottomView, 45)
    .leftSpaceToView(_bottomView, 0)
    .rightSpaceToView(_bottomView, 0)
    .heightIs(count * 65 + (count - 1) *15);
    
    _fillBtn.sd_layout
    .topSpaceToView(_collectionView, 15)
    .leftSpaceToView(_bottomView, 15)
    .rightSpaceToView(_bottomView, 15)
    .heightIs(45);
    [_fillBtn setSd_cornerRadius:@5];
    
    _noticeView.sd_layout
    .centerXEqualToView(_bottomView)
    .topSpaceToView(_fillBtn, 0)
    .heightIs(40);
    
    _noticeLb.sd_layout
    .bottomSpaceToView(_noticeView, 0)
    .leftSpaceToView(_noticeView, 0)
    .autoHeightRatio(0);
    [_noticeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _fillRuleBtn.sd_layout
    .centerYEqualToView(_noticeLb)
    .leftSpaceToView(_noticeLb, 0)
    .heightIs(40);
    [_fillRuleBtn setupAutoSizeWithHorizontalPadding:0 buttonHeight:40];
    
    [_noticeView setupAutoWidthWithRightView:_fillRuleBtn rightMargin:0];
    
    _balanceLb.sd_layout
    .centerXIs(SCREEN_WIDTH/ 4)
    .topSpaceToView(_noticeView, 15)
    .autoHeightRatio(0);
    [_balanceLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH / 2];
    
    _indicatiorLine.sd_layout
    .centerYEqualToView(_balanceLb)
    .centerXEqualToView(_bottomView)
    .widthIs(1)
    .heightIs(20);
    
    _actionRuleBtn.sd_layout
    .centerYEqualToView(_indicatiorLine)
    .centerXIs(SCREEN_WIDTH / 4 *3)
    .heightIs(30);
    [_actionRuleBtn setupAutoSizeWithHorizontalPadding:20 buttonHeight:30];
    
    [_bottomView setupAutoHeightWithBottomView:_indicatiorLine bottomMargin:20];

}

- (void)autoLayoutCollectionView{
    NSInteger count = _fillTitleData.count / 3;
    NSInteger bb = _fillTitleData.count % 3;
    if (bb) {
        count += 1;
    }
    _collectionView.sd_layout
    .heightIs(count * 65 + (count - 1) *15);
}
#pragma mark ----------------数据

/** 初始化数据*/
- (void)initData{
    MyBirdWalletFillRuleModel *model = [[MyBirdWalletFillRuleModel alloc] init];
    model.cash = @"充值金额";
    _fillTitleData = [[NSMutableArray alloc] initWithObjects:model, nil];
    _fillSelectIndex = 100;
    _payData = @[@"支付宝支付", @"微信支付", @"银联支付", @"取消"];
}

/** 数据请求*/
- (void)loadData{
    GOLFWeakObj(self);
    [SVProgressHUD showWithStatus:@"努力加载中"];
    [ShareBusinessManager.userManager postMyBirdWalletFillRuleWithParameters:nil
                                                                     success:^(id responObject) {
                                                                         [weakself.fillTitleData removeAllObjects];
                                                                         [weakself.fillTitleData addObjectsFromArray:responObject];
                                                                         MyBirdWalletFillRuleModel *model = [[MyBirdWalletFillRuleModel alloc] init];
                                                                         model.cash = @"充值金额";
                                                                         [weakself.fillTitleData addObject:model];
                                                                         [weakself autoLayoutCollectionView];
                                                                         [weakself.collectionView reloadData];
                                                                         [SVProgressHUD dismiss];
                                                                         weakself.fillSelectIndex = 100;//重置选中位置
                                                                         [weakself selectFillPriceByIndex:0];//默认选中第一个支付金额
                                                                     } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                         [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                     }];
}

#pragma mark ----------------界面逻辑
/** 点击余额*/
- (void)selectFillPriceByIndex:(NSInteger)index{

    if (index == _fillSelectIndex) {
        //选择了上次点击位置，不做任何反应
        return;
    }
    
    if (index == _fillTitleData.count - 1) {
        [_topView removeFromSuperview];
        [self.contentView addSubview:self.topView_else];
    }else{
        [_topView_else removeFromSuperview];
        _elseTf.text = @"";
        [self.contentView addSubview:self.topView];
        [_payTableView reloadData];
        MyBirdWalletFillRuleModel *model  = _fillTitleData[index];
        [self updateUIBy:model];//更新活动视图
    }
    _fillSelectIndex = index;
    
}
/** 根据当前选择充值。刷新充值规则*/
- (void)updateUIBy:(MyBirdWalletFillRuleModel *)model{
    NSString *text_0 = [NSString stringWithFormat:@"充%@鸟币", model.cash];
    _actionIntroduceLb_0.attributedText = [text_0 attributeStrWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25], NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(1, model.cash.length)];

    //计算充值金额。加上赠送金额
    float cash = [model.cash doubleValue];
    float giftMoney = [model.giveCash doubleValue];
    float totalAmount =  cash + giftMoney;
    
    NSString *totalStr = [NSString stringWithFormat:@"%.2f", totalAmount];
    NSString *text_1 = [NSString stringWithFormat:@"送%@鸟币，可得%@鸟币余额", model.giveCash, totalStr];
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:text_1];
    [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(0, 1)];
    [aStr addAttribute:NSForegroundColorAttributeName value:BLACKCOLOR range:NSMakeRange(1, model.giveCash.length)];
    [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(model.giveCash.length +6, totalStr.length)];
    _actionIntroduceLb_1.attributedText = aStr;
    
    NSString *text_2 = [NSString stringWithFormat:@"再送您%@积分",model.giveSorce];
    _actionIntroduceLb_2.attributedText = [text_2 attributeStrWithAttributes:@{NSForegroundColorAttributeName: BLACKCOLOR} range:NSMakeRange(3, model.giveSorce.length)];
}
/** 去充值*/
- (void)gotoFillAction{
    if (_fillSelectIndex == 100) {
        [SVProgressHUD showErrorWithStatus:@"请选择充值金额"];
        return;
    }
    
    if (_fillSelectIndex == _fillTitleData.count - 1) {
        if (!_elseTf.text.length) {
            [SVProgressHUD showErrorWithStatus:@"请输入充值金额"];
            return;
        }else{
            [_payTableView reloadData];
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _payBackView.transform = CGAffineTransformMakeTranslation(0, -SCREEN_HEIGHT);
    }];
}
/** 查看充值返现协议*/
- (void)lookFillRuleAction{
    [SVProgressHUD showSuccessWithStatus:@"查看协议"];
}
/** 查看活动规则*/
- (void)lookActionRuleAction{
    [SVProgressHUD showSuccessWithStatus:@"查看规则"];
}
/** return键位*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/** payBackView*/
- (void)payBackGroundViewAction{
    [UIView animateWithDuration:0.25 animations:^{
        _payBackView.transform = CGAffineTransformIdentity;
    }];
}
/** 点击选择支付方式进行支付*/
- (void)selectPayStyleBy:(UIButton *)btn{
    [self.view endEditing:YES];
    [SVProgressHUD show];
    weak(self);
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0:
        {//支付宝
            
            
            [ShareBusinessManager.userManager postMyBirdWalletFillWithParameters:@{@"amount":_priceText,
                                                                                   @"channel":@10}
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
        {//微信
            [ShareBusinessManager.userManager postMyBirdWalletFillWithParameters:@{@"amount":_priceText,
                                                                                   @"channel":@20}
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
    [self payBackGroundViewAction];
    switch (code) {
        case 0:{
            //微信支付成功
            [STL_CommonIdea alertWithTarget:self Title:@"充值成功" message:nil action_0:nil action_1:@"确定" block_0:nil block_1:nil];
            [self updateMyBalance];
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
            [STL_CommonIdea alertWithTarget:self Title:@"充值成功" message:nil action_0:nil action_1:@"确定" block_0:nil block_1:nil];
            [self updateMyBalance];
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
/** 本页面支付充值成功后需要及时刷新余额*/
- (void)updateMyBalance{
    GOLFWeakObj(self);
    [ShareBusinessManager.loginManager postUserBanlanceScoreWithParameters:nil
                                                                   success:^(id responObject) {
                                                                       [UserModel sharedUserModel].money = responObject[@"money"];
                                                                       [UserModel sharedUserModel].score = [responObject[@"score"] stringValue];
                                                                       weakself.balanceLb.text = [NSString stringWithFormat:@"余额：%@鸟币", [UserModel sharedUserModel].money];
                                                                   }
                                                                   failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       [UserModel sharedUserModel].money = @"0";
                                                                       [UserModel sharedUserModel].score = @"0";
                                                                   }];
}

#pragma mark ----------------collectionView代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _fillTitleData.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyBirdFillCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    MyBirdWalletFillRuleModel *model = _fillTitleData[indexPath.row];
    cell.model = model;
    if (indexPath.row == _fillTitleData.count - 1) {
        cell.titleLb.text = model.cash;
        cell.titleLb.font = FONT(14);
    }else{
        NSString *text = [NSString stringWithFormat:@"%@元",model.cash];
        NSAttributedString *aStr = [text attributeStrWithAttributes:@{NSFontAttributeName:FONT(12)} range:NSMakeRange(text.length - 1, 1)];
        cell.titleLb.attributedText = aStr;
    }
    
    if (indexPath.row == 0) {
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithAttributedString:cell.titleLb.attributedText];
        [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(0, aStr.length)];
        cell.titleLb.attributedText = aStr;
        cell.contentView.layer.borderColor = GLOBALCOLOR.CGColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyBirdFillCollectionViewCell *cell = (MyBirdFillCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor = GLOBALCOLOR.CGColor;
    UILabel *lb = cell.titleLb;
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithAttributedString:lb.attributedText];
    [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(0, aStr.length)];
    lb.attributedText = aStr;
    [self selectFillPriceByIndex:indexPath.row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyBirdFillCollectionViewCell *cell = (MyBirdFillCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.layer.borderColor = GRAYCOLOR.CGColor;
    UILabel *lb = cell.titleLb;
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithAttributedString:lb.attributedText];
    [aStr addAttribute:NSForegroundColorAttributeName value:BLACKTEXTCOLOR range:NSMakeRange(0, aStr.length)];
    lb.attributedText = aStr;
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
    
    NSString *text;
    if (_fillSelectIndex != 100) {
        if (_fillSelectIndex == _fillTitleData.count - 1) {
            text = [NSString stringWithFormat:@"¥%@",_elseTf.text];
            _priceText = _elseTf.text;
        }else{
            MyBirdWalletFillRuleModel *model = _fillTitleData[_fillSelectIndex];
            NSString *pat = model.cash;
            text = [NSString stringWithFormat:@"¥%@",pat];
            _priceText = model.cash;
        }
    }
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

#pragma mark ----------------实例化

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = WHITECOLOR;
        [_topView addSubview:self.actionIntroduceLb_0];
        [_topView addSubview:self.actionIntroduceLb_1];
        [_topView addSubview:self.actionIntroduceLb_2];
        [_topView addSubview:self.actionIv];
    }
    return _topView;

}

- (UIView *)middleLineView{
    if (!_middleLineView) {
        _middleLineView = [[UIView alloc] init];
        _middleLineView.backgroundColor = GRAYCOLOR;
    }
    return _middleLineView;
}

- (UIView *)topView_else{
    if (!_topView_else) {
        _topView_else   = [[UIView alloc] init];
        _topView_else.backgroundColor = WHITECOLOR;
        [_topView_else addSubview:self.elseTitleLb];
        [_topView_else addSubview:self.elseTf];
        [_topView_else addSubview:self.elseNoticeLb];
    }
    return _topView_else;

}

- (UILabel *)elseTitleLb{
    if (!_elseTitleLb) {
        _elseTitleLb = [[UILabel alloc] init];
        _elseTitleLb.font = FONT(16);
        _elseTitleLb.textColor = BLACKTEXTCOLOR;
        _elseTitleLb.text = @"其他金额";
    }
    return _elseTitleLb;
}

- (UITextField *)elseTf{
    if (!_elseTf) {
        _elseTf = [[UITextField alloc] init];
        _elseTf.font = FONT(18);
        _elseTf.borderStyle = UITextBorderStyleRoundedRect;
        _elseTf.textColor = BLACKTEXTCOLOR;
        _elseTf.textAlignment = NSTextAlignmentCenter;
        _elseTf.keyboardType = UIKeyboardTypeDecimalPad;
        _elseTf.returnKeyType = UIReturnKeyDone;
        _elseTf.placeholder = @"手动输入充值金额";
        _elseTf.delegate = self;
    }
    return _elseTf;
}

- (UILabel *)elseNoticeLb{
    if (!_elseNoticeLb) {
        _elseNoticeLb = [[UILabel alloc] init];
        _elseNoticeLb.font = FONT(14);
        _elseNoticeLb.textColor = BLACKTEXTCOLOR;
        _elseNoticeLb.text = @"生态冲返，乐享不停";
    }
    return _elseNoticeLb;
}

- (UILabel *)actionIntroduceLb_0{
    if (!_actionIntroduceLb_0) {
        _actionIntroduceLb_0 = [[UILabel alloc] init];
        _actionIntroduceLb_0.font = FONT(16);
        _actionIntroduceLb_0.textColor = SHENTEXTCOLOR;
        _actionIntroduceLb_0.textAlignment = NSTextAlignmentCenter;
//        NSString *text = @"充5000鸟币";
//        _actionIntroduceLb_0.attributedText = [text attributeStrWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:25], NSForegroundColorAttributeName:BLACKCOLOR} range:NSMakeRange(1, 4)];
    }
    return _actionIntroduceLb_0;
}

- (UILabel *)actionIntroduceLb_1{
    if (!_actionIntroduceLb_1) {
        _actionIntroduceLb_1 = [[UILabel alloc] init];
        _actionIntroduceLb_1.font = FONT(16);
        _actionIntroduceLb_1.textColor = SHENTEXTCOLOR;
        _actionIntroduceLb_1.textAlignment = NSTextAlignmentCenter;
//        NSString *text = @"送3000鸟币，可得8000鸟币余额";
//        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:text];
//        [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(0, 1)];
//        [aStr addAttribute:NSForegroundColorAttributeName value:BLACKCOLOR range:NSMakeRange(1, 4)];
//        [aStr addAttribute:NSForegroundColorAttributeName value:GLOBALCOLOR range:NSMakeRange(10, 4)];
//        _actionIntroduceLb_1.attributedText = aStr;
    }
    return _actionIntroduceLb_1;
}

- (UILabel *)actionIntroduceLb_2{
    if (!_actionIntroduceLb_2) {
        _actionIntroduceLb_2 = [[UILabel alloc] init];
        _actionIntroduceLb_2.font = FONT(16);
        _actionIntroduceLb_2.textColor = SHENTEXTCOLOR;
        _actionIntroduceLb_2.textAlignment = NSTextAlignmentCenter;
//        NSString *text = @"再送您5000积分";
//        _actionIntroduceLb_2.attributedText = [text attributeStrWithAttributes:@{NSForegroundColorAttributeName: BLACKCOLOR} range:NSMakeRange(3, 4)];
    }
    return _actionIntroduceLb_2;
}

- (UIImageView *)actionIv{
    if (!_actionIv) {
        _actionIv = [[UIImageView alloc] init];
        _actionIv.image = IMAGE(@"classify112");
    }
    return _actionIv;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = WHITECOLOR;
        [_bottomView addSubview:self.fillTitleLb];
        [_bottomView addSubview:self.collectionView];
        [_bottomView addSubview:self.fillBtn];
        [_bottomView addSubview:self.noticeView];
        [_bottomView addSubview:self.balanceLb];
        [_bottomView addSubview:self.indicatiorLine];
        [_bottomView addSubview:self.actionRuleBtn];
    }
    return _bottomView;

}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 60)/ 3, 65);
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = WHITECOLOR;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MyBirdFillCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UILabel *)fillTitleLb{
    if (!_fillTitleLb) {
        _fillTitleLb = [[UILabel alloc] init];
        _fillTitleLb.font = FONT(16);
        _fillTitleLb.textColor = SHENTEXTCOLOR;
        _fillTitleLb.text = @"充值金额：";
    }
    return _fillTitleLb;
}

- (UIButton *)fillBtn{
    if (!_fillBtn) {
        _fillBtn = [[UIButton alloc] init];
        _fillBtn.backgroundColor = GLOBALCOLOR;
        _fillBtn.titleLabel.font = FONT(14);
        [_fillBtn setTitle:@"去充值" forState:UIControlStateNormal];
        [_fillBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_fillBtn addTarget:self action:@selector(gotoFillAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fillBtn;
}

- (UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc] init];
        [_noticeView addSubview:self.noticeLb];
        [_noticeView addSubview:self.fillRuleBtn];
    }
    return _noticeView;
}

- (UILabel *)noticeLb{
    if (!_noticeLb) {
        _noticeLb = [[UILabel alloc] init];
        _noticeLb.font = FONT(10);
        _noticeLb.textColor = LIGHTTEXTCOLOR;
        _noticeLb.text = @"点击我要去充值，即表示您已经同意小鸟娱动";
    }
    return _noticeLb;
}

- (UIButton *)fillRuleBtn{
    if (!_fillRuleBtn) {
        _fillRuleBtn = [[UIButton alloc] init];
        _fillRuleBtn.titleLabel.font = FONT(10);
        [_fillRuleBtn setTitle:@"充值返现协议" forState:UIControlStateNormal];
        [_fillRuleBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [_fillRuleBtn addTarget:self action:@selector(lookFillRuleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fillRuleBtn;
}

- (UILabel *)balanceLb{
    if (!_balanceLb) {
        _balanceLb = [[UILabel alloc] init];
        _balanceLb.font = FONT(12);
        _balanceLb.textColor = BLACKTEXTCOLOR;
        _balanceLb.text = [NSString stringWithFormat:@"余额：%@鸟币", [UserModel sharedUserModel].money];
    }
    return _balanceLb;
}

- (UIView *)indicatiorLine{
    if (!_indicatiorLine) {
        _indicatiorLine = [[UIView alloc] init];
        _indicatiorLine.backgroundColor = GRAYCOLOR;
    }
    return _indicatiorLine;
}

- (UIButton *)actionRuleBtn{
    if (!_actionRuleBtn) {
        _actionRuleBtn = [[UIButton alloc] init];
        _actionRuleBtn.titleLabel.font = FONT(12);
        NSString *text = @"活动规则";
        NSAttributedString *aStr = [text attributeStrWithAttributes:@{NSUnderlineStyleAttributeName: @1, NSForegroundColorAttributeName:BLACKTEXTCOLOR} range:NSMakeRange(0, text.length)];
        [_actionRuleBtn setAttributedTitle:aStr forState:UIControlStateNormal];
        [_actionRuleBtn addTarget:self action:@selector(lookActionRuleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionRuleBtn;
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

