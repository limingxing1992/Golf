//
//  OrderDetailViewController.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()
/** 订单信息模块*/
@property (nonatomic, strong) UIView *orderInfoView;
/** 订单编号标题*/
@property (nonatomic, strong) UILabel *orderNumTitleLb;
/** 编号*/
@property (nonatomic, strong) UILabel *orderNumLb;
/** 下单时间标题*/
@property (nonatomic, strong) UILabel *orderTimeTitleLB;
/** 下单时间*/
@property (nonatomic, strong) UILabel *orderTimeLb;
/** 订单状态*/
@property (nonatomic, strong) UILabel *orderStyleTitleLb;
/** 订单状态*/
@property (nonatomic, strong) UILabel *orderStyleLb;
/** 状态按钮*/
@property (nonatomic, strong) UIButton *styleBtn;
/** 超时说明*/
@property (nonatomic, strong) UILabel *outRefundLb;


//退款信息可能不展示
/** 退款视图*/
@property (nonatomic, strong) UIView *refundView;
/** 退款标题*/
@property (nonatomic, strong) UILabel *refundTitleLb;
/** 退款金额*/
@property (nonatomic, strong) UILabel *refundLb;
/** 退款详细*/
@property (nonatomic, strong) UILabel *refundDetailLb;







/** 球场信息标题*/
@property (nonatomic, strong) UIView *placeTitleView;
/** 高尔夫球场预订标题*/
@property (nonatomic, strong) UILabel *placeTitleLb;

/** 球场信息模块*/
@property (nonatomic, strong) UIView *goodsInfoView;
/** 球场头像*/
@property (nonatomic, strong) UIImageView *goodsIv;
/** 球场名称*/
@property (nonatomic, strong) UILabel *nameLb;
/** 套餐标题*/
@property (nonatomic, strong) UILabel *comboTitleLb;
/** 套餐名称*/
@property (nonatomic, strong) UILabel *comboLb;
/** 时间标题*/
@property (nonatomic, strong) UILabel *timeTitleLb;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** 数量标题*/
@property (nonatomic, strong) UILabel *numTitleLb;
/** 数量*/
@property (nonatomic, strong) UILabel *numeLb;

/** 联系人模块*/
@property (nonatomic, strong) UIView *nameView;
/** 姓名标题*/
@property (nonatomic, strong) UILabel *nameTitleLb;
/** 联系人姓名*/
@property (nonatomic, strong) UILabel *connectNameLb;
/** 手机号码模块*/
@property (nonatomic, strong) UIView *phoneView;
/** 号码标题*/
@property (nonatomic, strong) UILabel *phoneTitleLb;
/** 手机号*/
@property (nonatomic, strong) UILabel *phoneLb;
/** 联系地址模块*/
@property (nonatomic, strong) UIView *adressView;
/** 联系地址标题*/
@property (nonatomic, strong) UILabel *adressTitleLb;
/** 联系地址*/
@property (nonatomic, strong) UILabel *adressLb;


/** 第一个价格信息模块*/
@property (nonatomic, strong) UIView *orderPriceInfoView;
/** 第一个价格标题*/
@property (nonatomic, strong) UILabel *orderPriceTitleLb;
/** 第一个价格*/
@property (nonatomic, strong) UILabel *orderPriceLb;

///** 第二个价格信息模块*/
//@property (nonatomic, strong) UIView *orderPayPriceInfoView;
///** 第二个金额标题*/
//@property (nonatomic, strong) UILabel *orderRealPriceTitleLb;
///** 第二个金额*/
//@property (nonatomic, strong) UILabel *orderRealPriceLb;





/** 底部按钮视图*/
@property (nonatomic, strong) UIView *bottomView;
/** 底部按钮*/
@property (nonatomic, strong) UIButton *bottomBtn;


@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"订单详情";
    [self.contentView sd_addSubviews:@[self.orderInfoView,
                                       self.refundView,
                                       self.placeTitleView,
                                       self.goodsInfoView,
                                       self.nameView,
                                       self.phoneView,
                                       self.adressView,
                                       self.orderPriceInfoView]];
    [self.view addSubview:self.bottomView];
    _orderStyle = _model.orderInfo.status;
    [GOLFNotificationCenter addObserver:self selector:@selector(loadData) name:OrderDetailUpdate object:nil];
    if (_orderNo) {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoLayoutSubViews];//布局
    [self changeUIStyleByOrderStyle];//根据订单状态修改界面

}

- (void)dealloc{
    [GOLFNotificationCenter removeObserver:self name:OrderDetailUpdate object:nil];
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _orderInfoView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(90);
    [self autoLayoutOrderInfoSubViews];
    
    _refundView.sd_layout
    .topSpaceToView(_orderInfoView, 0)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(30);
    [self autoLayoutRefundSubViews];

    _placeTitleView.sd_layout
    .topSpaceToView(_refundView, 10)
    .leftEqualToView(_orderInfoView)
    .rightEqualToView(_orderInfoView)
    .heightIs(45);
    
    _goodsInfoView.sd_layout
    .topSpaceToView(_placeTitleView, 0.5)
    .leftEqualToView(_placeTitleView)
    .rightEqualToView(_placeTitleView)
    .heightIs(95);
    
    [self autoLayoutGoodsInfoSubViews];
    
    _nameView.sd_layout
    .topSpaceToView(_goodsInfoView, 10)
    .leftEqualToView(_goodsInfoView)
    .rightEqualToView(_goodsInfoView)
    .heightIs(45);
    
    _phoneView.sd_layout
    .topSpaceToView(_nameView, 0.5)
    .leftEqualToView(_nameView)
    .rightEqualToView(_nameView)
    .heightRatioToView(_nameView, 1);
    
    _adressView.sd_layout
    .topSpaceToView(_phoneView, 0.5)
    .leftEqualToView(_phoneView)
    .rightEqualToView(_phoneView)
    .heightRatioToView(_phoneView, 1);
    
    [self autoLayoutConnectInfoSubViews];

    _orderPriceInfoView.sd_layout
    .topSpaceToView(_adressView, 20)
    .leftEqualToView(_adressView)
    .rightEqualToView(_adressView)
    .heightIs(45);
    
    
//    _orderPayPriceInfoView.sd_layout
//    .topSpaceToView(_orderPriceInfoView, 0.5)
//    .leftEqualToView(_orderPriceInfoView)
//    .rightEqualToView(_orderPriceInfoView)
//    .heightIs(45);
    
    _bottomView.sd_layout
    .bottomSpaceToView(self.view, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(50);
    [self autoLayoutPriceSubViews];
    
    _bottomBtn.sd_layout
    .centerYEqualToView(_bottomView)
    .leftSpaceToView(_bottomView, 15)
    .rightSpaceToView(_bottomView, 15)
    .heightRatioToView(_bottomView, 0.75);
    [_bottomBtn setSd_cornerRadius:@3];
    
    [self.contentView setupAutoContentSizeWithBottomView:_orderPriceInfoView bottomMargin:70];
    
}
/** 自动布局订单信息模块*/
- (void)autoLayoutOrderInfoSubViews{
    
    
    _orderNumTitleLb.sd_layout
    .centerYIs(15)
    .leftSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    [_orderNumTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _orderNumLb.sd_layout
    .centerYEqualToView(_orderNumTitleLb)
    .leftSpaceToView(_orderNumTitleLb, 3)
    .rightSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    
    _orderTimeTitleLB.sd_layout
    .centerYIs(45)
    .leftSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    [_orderTimeTitleLB setSingleLineAutoResizeWithMaxWidth:300];
    
    _orderTimeLb.sd_layout
    .centerYEqualToView(_orderTimeTitleLB)
    .leftSpaceToView(_orderTimeTitleLB, 3)
    .rightSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    
    _orderStyleTitleLb.sd_layout
    .centerYIs(75)
    .leftSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    [_orderStyleTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _orderStyleLb.sd_layout
    .centerYEqualToView(_orderStyleTitleLb)
    .leftSpaceToView(_orderStyleTitleLb, 3)
    .autoHeightRatio(0);
    [_orderStyleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _styleBtn.sd_layout
    .centerYEqualToView(_orderStyleLb)
    .leftSpaceToView(_orderStyleLb, 0)
    .heightIs(20);
    [_styleBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:20];
    
    _outRefundLb.sd_layout
    .centerYEqualToView(_styleBtn)
    .leftSpaceToView(_styleBtn,0)
    .rightSpaceToView(_orderInfoView, 15)
    .heightIs(20);
    

}
/** 布局球场信息模块*/
- (void)autoLayoutGoodsInfoSubViews{
    
    _placeTitleLb.sd_layout
    .centerYEqualToView(_placeTitleView)
    .leftSpaceToView(_placeTitleView, 15)
    .rightSpaceToView(_placeTitleView, 15)
    .autoHeightRatio(0);
    
    _goodsIv.sd_layout
    .centerYEqualToView(_goodsInfoView)
    .leftSpaceToView(_goodsInfoView, 15)
    .heightIs(70)
    .widthEqualToHeight();
    
    _nameLb.sd_layout
    .topEqualToView(_goodsIv)
    .leftSpaceToView(_goodsIv, 10)
    .rightSpaceToView(_goodsInfoView, 15)
    .heightIs(14);
    
    _comboTitleLb.sd_layout
    .topSpaceToView(_nameLb, 10)
    .leftEqualToView(_nameLb)
    .heightIs(12);
    [_comboTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _comboLb.sd_layout
    .centerYEqualToView(_comboTitleLb)
    .leftSpaceToView(_comboTitleLb, 0)
    .rightSpaceToView(_goodsInfoView, 15)
    .heightIs(12);
    
    _timeTitleLb.sd_layout
    .topSpaceToView(_comboTitleLb, 4)
    .leftEqualToView(_nameLb)
    .autoHeightRatio(0);
    [_timeTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLb.sd_layout
    .centerYEqualToView(_timeTitleLb)
    .leftSpaceToView(_timeTitleLb, 0)
    .rightSpaceToView(_goodsInfoView, 15)
    .autoHeightRatio(0);
    
    _numTitleLb.sd_layout
    .bottomEqualToView(_goodsIv)
    .leftEqualToView(_timeTitleLb)
    .autoHeightRatio(0);
    [_numTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _numeLb.sd_layout
    .centerYEqualToView(_numTitleLb)
    .leftSpaceToView(_numTitleLb, 0)
    .rightSpaceToView(_goodsInfoView, 0)
    .autoHeightRatio(0);
    
}
/** 布局联系人信息模块*/
- (void)autoLayoutConnectInfoSubViews{
    
    _phoneTitleLb.sd_layout
    .centerYEqualToView(_phoneView)
    .leftSpaceToView(_phoneView, 15)
    .autoHeightRatio(0);
    [_phoneTitleLb setSingleLineAutoResizeWithMaxWidth:200];

    _phoneLb.sd_layout
    .centerYEqualToView(_phoneTitleLb)
    .leftSpaceToView(_phoneTitleLb, 10)
    .rightSpaceToView(_phoneView, 15)
    .autoHeightRatio(0);
    
    _nameTitleLb.sd_layout
    .centerYEqualToView(_nameView)
    .leftSpaceToView(_nameView, 15)
    .rightEqualToView(_phoneTitleLb)
    .autoHeightRatio(0);
    
    _connectNameLb.sd_layout
    .centerYEqualToView(_nameTitleLb)
    .leftSpaceToView(_nameTitleLb, 10)
    .rightSpaceToView(_nameView, 15)
    .autoHeightRatio(0);

    
    _adressTitleLb.sd_layout
    .centerYEqualToView(_adressView)
    .leftSpaceToView(_adressView, 15)
    .rightEqualToView(_phoneTitleLb)
    .autoHeightRatio(0);
    
    _adressLb.sd_layout
    .centerYEqualToView(_adressTitleLb)
    .leftSpaceToView(_adressTitleLb, 10)
    .rightSpaceToView(_adressView, 15)
    .autoHeightRatio(0);
    

}
/** 自动布局价格信息*/
- (void)autoLayoutPriceSubViews{
    _orderPriceTitleLb.sd_layout
    .centerYEqualToView(_orderPriceInfoView)
    .leftSpaceToView(_orderPriceInfoView, 15)
    .autoHeightRatio(0);
    [_orderPriceTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _orderPriceLb.sd_layout
    .centerYEqualToView(_orderPriceTitleLb)
    .rightSpaceToView(_orderPriceInfoView, 15)
    .autoHeightRatio(0);
    [_orderPriceLb setSingleLineAutoResizeWithMaxWidth:300];
    
//    _orderRealPriceTitleLb.sd_layout
//    .centerYEqualToView(_orderPayPriceInfoView)
//    .leftSpaceToView(_orderPayPriceInfoView, 15)
//    .heightRatioToView(_orderPayPriceInfoView, 1);
//    [_orderRealPriceTitleLb setSingleLineAutoResizeWithMaxWidth:300];
//    
//    _orderRealPriceLb.sd_layout
//    .centerYEqualToView(_orderPayPriceInfoView)
//    .rightSpaceToView(_orderPayPriceInfoView, 15)
//    .heightRatioToView(_orderPayPriceInfoView, 1);
//    [_orderRealPriceLb setSingleLineAutoResizeWithMaxWidth:300];

}
/** 自动布局退款信息*/
- (void)autoLayoutRefundSubViews{
    _refundTitleLb.sd_layout
    .centerYEqualToView(_refundView)
    .leftSpaceToView(_refundView, 15)
    .heightRatioToView(_refundView, 1);
    [_refundTitleLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _refundLb.sd_layout
    .centerYEqualToView(_refundView)
    .leftSpaceToView(_refundTitleLb, 0)
    .heightRatioToView(_refundTitleLb, 1);
    [_refundLb setSingleLineAutoResizeWithMaxWidth:300];
    
//    _refundDetailLb.sd_layout
//    .centerYEqualToView(_refundView)
//    .leftSpaceToView(_refundLb, 3)
//    .rightSpaceToView(_refundView, 15)
//    .heightRatioToView(_refundTitleLb, 1);
}

#pragma mark ----------------数据
/** 根据订单状态处理界面显示逻辑*/
- (void)changeUIStyleByOrderStyle{
    
    _outRefundLb.sd_layout
    .heightIs(0);
    switch (_orderStyle) {
        case OrderWaitPayStyle:
        {//代付款
            _orderStyleLb.text = @"待付款";
            [_styleBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [_bottomBtn setTitle:@"去付款" forState:UIControlStateNormal];
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
//            _orderPayPriceInfoView.sd_layout
//            .heightIs(0);//隐藏第二个价格信息条
        }
            break;
        case OrderWaitSureStyle:
        {//待确认
            _orderStyleLb.text = @"待确认";
            [_styleBtn setTitle:@"申请退款" forState:UIControlStateNormal];
//            [_bottomBtn setTitle:@"去付款" forState:UIControlStateNormal];
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
//            _orderPayPriceInfoView.sd_layout
//            .heightIs(0);//隐藏第二个价格信息条
            _bottomView.sd_layout
            .heightIs(0);//隐藏底部按钮

        }
            break;
        case OrderAvailableStyle:
        {//可使用(可以退款)
            _orderStyleLb.text = @"可使用";
            [_styleBtn setTitle:@"申请退款" forState:UIControlStateNormal];
            [_bottomBtn setTitle:@"确认使用" forState:UIControlStateNormal];
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
            
        }
            break;
        case OrderRefundingStyle:
        {//退款中
            _orderStyleLb.textColor = GLOBALCOLOR;
            _orderStyleLb.text = @"退款中， 请耐心等待";
            _bottomView.sd_layout
            .heightIs(0);//隐藏底部按钮
            [_styleBtn removeFromSuperview];//隐藏状态按钮
        }
            break;
        case OrderDoneRefundStyle:
        {//已退款
            _orderStyleLb.text = @"已退款";
            [_bottomBtn setTitle:@"重新预订" forState:UIControlStateNormal];
            [_styleBtn removeFromSuperview];//隐藏状态按钮
            
        }
            break;
        case OrderDoneCancelStyle:
        {//已取消
            _orderStyleLb.text = @"已取消";
            [_bottomBtn setTitle:@"重新预订" forState:UIControlStateNormal];
            [_styleBtn removeFromSuperview];//隐藏状态按钮
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
//            _orderPayPriceInfoView.sd_layout
//            .heightIs(0);//隐藏实付金额条
        }
            break;
        case OrderUnAvailableStyle:
        {//已使用
            _orderStyleLb.text = @"已使用";
            [_bottomBtn setTitle:@"去评价" forState:UIControlStateNormal];
            [_styleBtn removeFromSuperview];//隐藏状态按钮
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
        }
            break;
        case OrderDoneJugeStyle:
        {
            _orderStyleLb.text = @"已评价";
            [_bottomBtn setTitle:@"查看评价信息" forState:UIControlStateNormal];
            [_styleBtn removeFromSuperview];//隐藏状态按钮
            _refundView.sd_layout
            .heightIs(0);//隐藏退款信息
        }
            break;
        default:
            break;
    }


}
/** 刷新界面*/
- (void)reloadUI{
    _orderStyle = _model.orderInfo.status;
    _orderNumLb.text = _model.orderInfo.orderNo;
    _orderTimeLb.text = _model.orderInfo.orderTime;
    _orderStyleLb.text = _model.orderInfo.statusName;
    _nameLb.text = _model.ballPlaceInfo.name;
    _comboLb.text = _model.serviceInfo.name;
    _timeLb.text = _model.orderInfo.bookTime;
    _numeLb.text = _model.orderInfo.personNum;
    [_goodsIv sd_setImageWithURL:FULLIMGURL(_model.serviceInfo.logoUrl) placeholderImage:Placeholder_middle];
    _connectNameLb.text = _model.orderInfo.phoneUser;
    _phoneLb.text  = _model.orderInfo.phoneNumber;
    _adressLb.text = _model.orderInfo.remark;
    _orderPriceLb.text = [NSString stringWithFormat:@"¥%@", _model.orderInfo.totalPrice];
    [self changeUIStyleByOrderStyle];
}
/** 请求数据*/
- (void)loadData{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (_orderNo) {
        [dict setValue:_orderNo forKey:@"orderNo"];
    }else{
        [dict setValue:_model.orderInfo.orderNo forKey:@"orderNo"];
    }
    
    [SVProgressHUD showWithStatus:@"刷新订单中"];
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderDetailWithParameters:dict
                                                              success:^(id responObject) {
                                                                  weakself.model = responObject;
                                                                  [weakself reloadUI];
                                                                  [SVProgressHUD dismiss];
                                                              }
                                                              failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                  [SVProgressHUD showErrorWithStatus:errorMsg];
                                                              }];;
}

#pragma mark ----------------界面逻辑
/** 底部按钮动作*/
- (void)bottomAction:(UIButton *)btn{
    GOLFWeakObj(self);
    switch (_orderStyle) {
        case OrderWaitPayStyle:
        {//跳转支付页面
            OrderPayViewController *payVc = [[OrderPayViewController alloc] init];
            payVc.model = _model;
            [self.navigationController pushViewController:payVc animated:YES];
        }
            break;
        case OrderAvailableStyle:
        {//可使用
            //确认使用
            [STL_CommonIdea alertWithTarget:self Title:@"确认使用？" message:@"请再次确认已使用订单" action_0:@"确认使用" action_1:@"放弃" block_0:^{
                [weakself useOrderByOrderInfo:_model.orderInfo];
            } block_1:nil];
        }
            break;
        case OrderUnAvailableStyle:
        {//已使用，跳转评价
            OrderCommentViewController *commentVc = [[OrderCommentViewController alloc] init];
            commentVc.model = _model;
            [self.navigationController pushViewController:commentVc animated:YES];
        }
            break;
        case OrderDoneJugeStyle:
        {//查看评价信息
            AppointPlaceCommentViewController *commentVc = [[AppointPlaceCommentViewController alloc] init];
            commentVc.placeID = (NSString *)_model.ballPlaceInfo.ID;
            [self.navigationController pushViewController:commentVc animated:YES];
        }
            break;
        case OrderDoneCancelStyle:
        {//重新预订
            PlaceSubmitApointViewController *placeVc = [[PlaceSubmitApointViewController alloc] init];
            placeVc.model = _model.serviceInfo;
            placeVc.openTime = _model.ballPlaceInfo.openTime;
            placeVc.endTime = _model.ballPlaceInfo.closeTime;
            placeVc.placeName = _model.ballPlaceInfo.name;
            [self.navigationController pushViewController:placeVc animated:YES];
        }
            break;
        case OrderDoneRefundStyle:
        {//重新预订
            PlaceSubmitApointViewController *placeVc = [[PlaceSubmitApointViewController alloc] init];
            placeVc.model = _model.serviceInfo;
            placeVc.openTime = _model.ballPlaceInfo.openTime;
            placeVc.endTime = _model.ballPlaceInfo.closeTime;
            placeVc.placeName = _model.ballPlaceInfo.name;
            [self.navigationController pushViewController:placeVc animated:YES];
        }
            break;
        default:
            break;
    }


}
/** 状态按钮动作*/
- (void)styleAction:(UIButton *)btn{
    GOLFWeakObj(self);
    switch (_orderStyle) {
        case OrderWaitPayStyle:
        {//取消订单
            //取消订单
            [STL_CommonIdea alertWithTarget:self Title:@"确认取消订单？" message:nil action_0:@"确认取消" action_1:@"暂不取消" block_0:^{
                [ShareBusinessManager.userManager postMyOrderCancelWithParameters:@{@"orderNo":_model.orderInfo.orderNo}
                                                                          success:^(id responObject) {
                                                                              [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
                                                                              [GOLFNotificationCenter postNotificationName:OrderDetailUpdate object:nil];
                                                                              STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
                                                                              successVc.type = 1;
                                                                              successVc.orderNo = weakself.model.orderInfo.orderNo;
                                                                              [weakself.navigationController pushViewController:successVc animated:YES];
                                                                          } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                              [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                          }];
            } block_1:nil];
        }
            break;
        case OrderAvailableStyle:
        {//退款
            NSString *returnRule = [GOLFUserDefault objectForKey:@"ReturnRule"];
            [STL_CommonIdea alertWithTarget:self Title:@"确定退款？" message:returnRule action_0:@"确认退款" action_1:@"暂不退款" block_0:^{
                [weakself applyReturnOrderByOrderInfo:_model.orderInfo];
            } block_1:nil];
        }
            break;
        case OrderWaitSureStyle:
        {
            NSString *returnRule = [GOLFUserDefault objectForKey:@"ReturnRule"];
            [STL_CommonIdea alertWithTarget:self Title:@"确定退款？" message:returnRule action_0:@"确认退款" action_1:@"暂不退款" block_0:^{
                [weakself applyReturnOrderByOrderInfo:_model.orderInfo];
            } block_1:nil];
        }
            break;
        default:
            break;
    }
}
/** 使用*/
- (void)useOrderByOrderInfo:(MyOrderInfoModel *)orderInfo{
    GOLFWeakObj(self);
    [ShareBusinessManager.userManager postMyOrderUseParameters:@{@"orderNo":orderInfo.orderNo,
                                                                 @"serviceTicket":orderInfo.serviceTicket}
                                                       success:^(id responObject) {
                                                           [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
                                                           [GOLFNotificationCenter postNotificationName:OrderDetailUpdate object:nil];
                                                           STL_SuccessViewController *successVc = [[STL_SuccessViewController alloc] init];
                                                           successVc.type = 2;
                                                           successVc.orderNo = orderInfo.orderNo;
                                                           [weakself.navigationController pushViewController:successVc animated:YES];
                                                       } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                           [SVProgressHUD showErrorWithStatus:errorMsg];
                                                       }];
}
/** 申请退款*/
- (void)applyReturnOrderByOrderInfo:(MyOrderInfoModel *)orderInfo{
    [ShareBusinessManager.userManager postMyOrderApplyReturnWithParameters:@{@"orderNo":orderInfo.orderNo} success:^(id responObject) {
        [GOLFNotificationCenter postNotificationName:OrderListUpdate object:nil];
        [SVProgressHUD showSuccessWithStatus:@"已申请退款，请耐心等待客服联系"];
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}


#pragma mark ----------------实例
/** 订单信息模块*/
- (UIView *)orderInfoView{
    if (!_orderInfoView) {
        _orderInfoView = [[UIView alloc] init];
        _orderInfoView.backgroundColor = WHITECOLOR;
        [_orderInfoView addSubview:self.orderNumTitleLb];
        [_orderInfoView addSubview:self.orderTimeTitleLB];
        [_orderInfoView addSubview:self.orderStyleTitleLb];
        [_orderInfoView addSubview:self.orderNumLb];
        [_orderInfoView addSubview:self.orderTimeLb];
        [_orderInfoView addSubview:self.orderStyleLb];
        [_orderInfoView addSubview:self.styleBtn];
        [_orderInfoView addSubview:self.outRefundLb];
    }
    return _orderInfoView;
}

- (UILabel *)orderNumLb{
    if (!_orderNumLb) {
        _orderNumLb = [[UILabel alloc] init];
        _orderNumLb.font = FONT(12);
        _orderNumLb.textColor = BLACKTEXTCOLOR;
        _orderNumLb.text = _model.orderInfo.orderNo;
    }
    return _orderNumLb;

}

- (UILabel *)orderTimeLb{
    if (!_orderTimeLb) {
        _orderTimeLb = [[UILabel alloc] init];
        _orderTimeLb.font = FONT(12);
        _orderTimeLb.textColor = BLACKTEXTCOLOR;
        _orderTimeLb.text = _model.orderInfo.orderTime;
    }
    return _orderTimeLb;
}

- (UILabel *)orderStyleLb{
    if (!_orderStyleLb) {
        _orderStyleLb = [[UILabel alloc] init];
        _orderStyleLb.font = FONT(12);
        _orderStyleLb.textColor = BLACKTEXTCOLOR;
        _orderStyleLb.text = _model.orderInfo.statusName;
    }
    return _orderStyleLb;

}

- (UILabel *)orderNumTitleLb{
    if (!_orderNumTitleLb) {
        _orderNumTitleLb = [[UILabel alloc] init];
        _orderNumTitleLb.font = FONT(12);
        _orderNumTitleLb.textColor = BLACKTEXTCOLOR;
        _orderNumTitleLb.text = @"订单编号：";
    }
    return _orderNumTitleLb;
}

- (UILabel *)orderTimeTitleLB{
    if (!_orderTimeTitleLB) {
        _orderTimeTitleLB = [[UILabel alloc] init];
        _orderTimeTitleLB.font = FONT(12);
        _orderTimeTitleLB.textColor = BLACKTEXTCOLOR;
        _orderTimeTitleLB.text = @"下单时间：";
    }
    return _orderTimeTitleLB;
}

- (UILabel *)orderStyleTitleLb{
    if (!_orderStyleTitleLb) {
        _orderStyleTitleLb = [[UILabel alloc] init];
        _orderStyleTitleLb.font = FONT(12);
        _orderStyleTitleLb.textColor = BLACKTEXTCOLOR;
        _orderStyleTitleLb.text = @"订单状态：";
    }
    return _orderStyleTitleLb;
}

/** 球场预订标题*/
- (UIView *)placeTitleView{
    if (!_placeTitleView) {
        _placeTitleView = [[UIView alloc] init];
        _placeTitleView.backgroundColor = WHITECOLOR;
        [_placeTitleView addSubview:self.placeTitleLb];
    }
    return _placeTitleView;
}

- (UILabel *)placeTitleLb{
    if (!_placeTitleLb) {
        _placeTitleLb = [[UILabel alloc] init];
        _placeTitleLb.font = FONT(12);
        _placeTitleLb.textColor = BLACKTEXTCOLOR;
        _placeTitleLb.text = @"高尔夫球场预订";
    }
    return _placeTitleLb;
}

/** 球场信息*/
- (UIView *)goodsInfoView{
    if (!_goodsInfoView) {
        _goodsInfoView = [[UIView alloc] init];
        _goodsInfoView.backgroundColor = WHITECOLOR;
        [_goodsInfoView sd_addSubviews:@[self.goodsIv, self.nameLb, self.timeTitleLb, self.timeLb,
                                         self.numTitleLb, self.numeLb, self.comboTitleLb, self.comboLb]];
    }
    return _goodsInfoView;
}

- (UILabel *)comboTitleLb{
    if (!_comboTitleLb) {
        _comboTitleLb = [[UILabel alloc] init];
        _comboTitleLb.font = FONT(12);
        _comboTitleLb.textColor = LIGHTTEXTCOLOR;
        _comboTitleLb.text = @"套餐：";
    }
    return _comboTitleLb;
}

- (UILabel *)comboLb{
    if (!_comboLb) {
        _comboLb = [[UILabel alloc] init];
        _comboLb.font = FONT(12);
        _comboLb.textColor = LIGHTTEXTCOLOR;
        _comboLb.text = _model.serviceInfo.name;
    }
    return _comboLb;
}


- (UIImageView *)goodsIv{
    if (!_goodsIv) {
        _goodsIv = [[UIImageView alloc] init];
        [_goodsIv sd_setImageWithURL:FULLIMGURL(_model.serviceInfo.logoUrl) placeholderImage:Placeholder_middle];
    }
    return _goodsIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = _model.ballPlaceInfo.name;
    }
    return _nameLb;
}

- (UILabel *)timeTitleLb{
    if (!_timeTitleLb) {
        _timeTitleLb = [[UILabel alloc] init];
        _timeTitleLb.font = FONT(12);
        _timeTitleLb.textColor = LIGHTTEXTCOLOR;
        _timeTitleLb.text = @"时间：";
    }
    return _timeTitleLb;
    

}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(12);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        _timeLb.text = _model.orderInfo.bookTime;
    }
    return _timeLb;
}

- (UILabel *)numTitleLb{
    if (!_numTitleLb) {
        _numTitleLb = [[UILabel alloc] init];
        _numTitleLb.font = FONT(12);
        _numTitleLb.textColor = LIGHTTEXTCOLOR;
        _numTitleLb.text = @"人数：";
    }
    return _numTitleLb;
}

- (UILabel *)numeLb{
    if (!_numeLb) {
        _numeLb  = [[UILabel alloc] init];
        _numeLb.font = FONT(12);
        _numeLb.textColor = [UIColor redColor];
        _numeLb.text = _model.orderInfo.personNum;
    }
    return _numeLb;
}

/** 用户信息模块*/
- (UIView *)nameView{
    if (!_nameView) {
        _nameView = [[UIView alloc] init];
        _nameView.backgroundColor = WHITECOLOR;
        [_nameView addSubview:self.nameTitleLb];
        [_nameView addSubview:self.connectNameLb];
    }
    return _nameView;
}

- (UILabel *)nameTitleLb{
    if (!_nameTitleLb) {
        _nameTitleLb = [[UILabel alloc] init];
        _nameTitleLb.font = FONT(12);
        _nameTitleLb.textColor = BLACKTEXTCOLOR;
        _nameTitleLb.text = @"联系人";
    }
    return _nameTitleLb;
}

- (UILabel *)connectNameLb{
    if (!_connectNameLb) {
        _connectNameLb = [[UILabel alloc] init];
        _connectNameLb.font = FONT(12);
        _connectNameLb.textColor = BLACKTEXTCOLOR;
        _connectNameLb.text = _model.orderInfo.phoneUser;
    }
    return _connectNameLb;

}

- (UIView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[UIView alloc] init];
        _phoneView.backgroundColor = WHITECOLOR;
        [_phoneView addSubview:self.phoneTitleLb];
        [_phoneView addSubview:self.phoneLb];
    }
    return _phoneView;
}

- (UILabel *)phoneTitleLb{
    if (!_phoneTitleLb) {
        _phoneTitleLb = [[UILabel alloc] init];
        _phoneTitleLb.font = FONT(12);
        _phoneTitleLb.textColor = BLACKTEXTCOLOR;
        _phoneTitleLb.text = @"手机号码";
    }
    return _phoneTitleLb;
}

- (UILabel *)phoneLb{
    if (!_phoneLb) {
        _phoneLb = [[UILabel alloc] init];
        _phoneLb.font = FONT(12);
        _phoneLb.textColor = BLACKTEXTCOLOR;
        _phoneLb.text = _model.orderInfo.phoneNumber;
    }
    return _phoneLb;
}

- (UIView *)adressView{
    if (!_adressView) {
        _adressView = [[UIView alloc] init];
        _adressView.backgroundColor = WHITECOLOR;
        [_adressView addSubview:self.adressTitleLb];
        [_adressView addSubview:self.adressLb];
    }
    return _adressView;
}

- (UILabel *)adressTitleLb{
    if (!_adressTitleLb) {
        _adressTitleLb = [[UILabel alloc] init];
        _adressTitleLb.font = FONT(12);
        _adressTitleLb.textColor = BLACKTEXTCOLOR;
        _adressTitleLb.text = @"备注";
    }
    return _adressTitleLb;
}

- (UILabel *)adressLb{
    if (!_adressLb) {
        _adressLb = [[UILabel alloc] init];
        _adressLb.font = FONT(12);
        _adressLb.textColor = BLACKTEXTCOLOR;
        _adressLb.text = _model.orderInfo.remark;
    }
    return _adressLb;
}

/** 价格模块*/
- (UIView *)orderPriceInfoView{
    if (!_orderPriceInfoView) {
        _orderPriceInfoView = [[UIView alloc] init];
        _orderPriceInfoView.backgroundColor = WHITECOLOR;
        [_orderPriceInfoView addSubview:self.orderPriceTitleLb];
        [_orderPriceInfoView addSubview:self.orderPriceLb];
    }
    return _orderPriceInfoView;
}

- (UILabel *)orderPriceTitleLb{
    if (!_orderPriceTitleLb) {
        _orderPriceTitleLb = [[UILabel alloc] init];
        _orderPriceTitleLb.font = FONT(12);
        _orderPriceTitleLb.textColor = BLACKTEXTCOLOR;
        _orderPriceTitleLb.text = @"订单金额";
    }
    return _orderPriceTitleLb;
}

- (UILabel *)orderPriceLb{
    if (!_orderPriceLb) {
        _orderPriceLb = [[UILabel alloc] init];
        _orderPriceLb.font = FONT(12);
        _orderPriceLb.textColor = OrangeCOLOR;
        _orderPriceLb.text = [NSString stringWithFormat:@"¥%@", _model.orderInfo.totalPrice];
    }
    return _orderPriceLb;

}

/** 底部按钮模块*/
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = WHITECOLOR;
        [_bottomView addSubview:self.bottomBtn];
    }
    return _bottomView;
}

- (UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        [_bottomBtn setBackgroundColor:GLOBALCOLOR];
        [_bottomBtn setTitle:@"未知按钮" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = FONT(18);
        [_bottomBtn addTarget:self action:@selector(bottomAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

- (UIButton *)styleBtn{
    if (!_styleBtn) {
        _styleBtn = [[UIButton alloc] init];
        _styleBtn.titleLabel.font = FONT(12);
        [_styleBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_styleBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateDisabled];
        [_styleBtn setTitle:@"退款" forState:UIControlStateNormal];
        [_styleBtn addTarget:self action:@selector(styleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _styleBtn;
}

- (UILabel *)outRefundLb{
    if (!_outRefundLb) {
        _outRefundLb = [[UILabel alloc] init];
        _outRefundLb.font = FONT(12);
        _outRefundLb.textColor = [UIColor redColor];
        _outRefundLb.text = @"（订单已超时，不能退款。）";
    }
    return _outRefundLb;
}

/** 退款信息模块*/
- (UIView *)refundView{
    if (!_refundView) {
        _refundView = [[UIView alloc] init];
        _refundView.backgroundColor = WHITECOLOR;
        [_refundView sd_addSubviews:@[self.refundTitleLb,self.refundDetailLb, self.refundLb]];
    }
    return _refundView;
}

- (UILabel *)refundTitleLb{
    if (!_refundTitleLb) {
        _refundTitleLb = [[UILabel alloc] init];
        _refundTitleLb.font = FONT(12);
        _refundTitleLb.textColor = BLACKTEXTCOLOR;
        _refundTitleLb.text = @"退款金额：";
    }
    return _refundTitleLb;

}

- (UILabel *)refundLb{
    if (!_refundLb) {
        _refundLb = [[UILabel alloc] init];
        _refundLb.font = FONT(12);
        _refundLb.textColor = [UIColor redColor];
        _refundLb.text = @"¥800";
    }
    return _refundLb;
}

- (UILabel *)refundDetailLb{
    if (!_refundDetailLb) {
        _refundDetailLb = [[UILabel alloc] init];
        _refundDetailLb.textColor = BLACKTEXTCOLOR;
        _refundDetailLb.font = FONT(12);
        _refundDetailLb.text = @"（小鸟钱包0鸟币，支付宝200元）";
    }
    return _refundDetailLb;
}

/** 实付金额*/

//- (UIView *)orderPayPriceInfoView{
//    if (!_orderPayPriceInfoView) {
//        _orderPayPriceInfoView = [[UIView alloc] init];
//        _orderPayPriceInfoView.backgroundColor = WHITECOLOR;
//        [_orderPayPriceInfoView sd_addSubviews:@[self.orderRealPriceTitleLb, self.orderRealPriceLb]];
//    }
//    return _orderPayPriceInfoView;
//}
//
//- (UILabel *)orderRealPriceTitleLb{
//    if (!_orderRealPriceTitleLb) {
//        _orderRealPriceTitleLb = [[UILabel alloc] init];
//        _orderRealPriceTitleLb.font = FONT(12);
//        _orderRealPriceTitleLb.textColor = BLACKTEXTCOLOR;
//        _orderRealPriceTitleLb.text = @"实付金额";
//    }
//    return _orderRealPriceTitleLb;
//
//}
//
//- (UILabel *)orderRealPriceLb{
//    if (!_orderRealPriceLb) {
//        _orderRealPriceLb = [[UILabel alloc] init];
//        _orderRealPriceLb.font = FONT(12);
//        _orderRealPriceLb.textColor = [UIColor redColor];
//        _orderRealPriceLb.text = @"¥0";
//    }
//    return _orderRealPriceLb;
//
//}

@end

