//
//  OrderTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell ()
/** 订单信息模块*/
@property (nonatomic, strong) UIView *orderInfoView;
/** 编号*/
@property (nonatomic, strong) UILabel *orderNumLb;
/** 状态*/
@property (nonatomic, strong) UILabel *orderStyleLb;

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

/** 订单价格信息模块*/
@property (nonatomic, strong) UIView *orderPriceInfoView;
/** 价格标题*/
@property (nonatomic, strong) UILabel *priceTitleLb;
/** 价格*/
@property (nonatomic, strong) UILabel *priceLb;
/** 右1按钮*/
@property (nonatomic, strong) UIButton *rightBtn_0;
/** 右2按钮*/
@property (nonatomic, strong) UIButton *rightBtn_1;


@end

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = BACKGROUNDCOLOR;
        [self.contentView sd_addSubviews:@[self.orderInfoView, self.goodsInfoView, self.orderPriceInfoView]];
        _orderInfoView.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(45);
        
        _goodsInfoView.sd_layout
        .topSpaceToView(_orderInfoView, 0.5)
        .leftEqualToView(_orderInfoView)
        .rightEqualToView(_orderInfoView)
        .heightIs(90);
        
        _orderPriceInfoView.sd_layout
        .topSpaceToView(_goodsInfoView, 0.5)
        .leftEqualToView(_goodsInfoView)
        .rightEqualToView(_goodsInfoView)
        .bottomSpaceToView(self.contentView, 0);
        
        [self autoLayoutOrderInfoSubViews];
        [self autoLayoutGoodsInfoSubViews];
        [self autoLayoutPriceInfoSubViews];
    }
    return self;

}

/** 订单信息自动布局*/
- (void)autoLayoutOrderInfoSubViews{
    _orderNumLb.sd_layout
    .centerYEqualToView(_orderInfoView)
    .leftSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    [_orderNumLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _orderStyleLb.sd_layout
    .centerYEqualToView(_orderNumLb)
    .rightSpaceToView(_orderInfoView, 15)
    .autoHeightRatio(0);
    [_orderStyleLb setSingleLineAutoResizeWithMaxWidth:200];
}
/** 场地信息自动布局*/
- (void)autoLayoutGoodsInfoSubViews{
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
/** 价格信息自动布局*/
- (void)autoLayoutPriceInfoSubViews{
    _priceTitleLb.sd_layout
    .centerYEqualToView(_orderPriceInfoView)
    .leftSpaceToView(_orderPriceInfoView, 15)
    .autoHeightRatio(0);
    [_priceTitleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _priceLb.sd_layout
    .centerYEqualToView(_priceTitleLb)
    .leftSpaceToView(_priceTitleLb, 0)
    .autoHeightRatio(0);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _rightBtn_0.sd_layout
    .centerYEqualToView(_priceTitleLb)
    .rightSpaceToView(_orderPriceInfoView, 15)
    .heightIs(25);
    [_rightBtn_0 setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    [_rightBtn_0 setSd_cornerRadius:@3];
    _rightBtn_1.sd_layout
    .centerYEqualToView(_priceTitleLb)
    .rightSpaceToView(_rightBtn_0, 5)
    .heightIs(25);
    [_rightBtn_1 setupAutoSizeWithHorizontalPadding:10 buttonHeight:25];
    [_rightBtn_1 setSd_cornerRadius:@3];

}

#pragma mark ----------------数据

/** 根据订单style改变信息*/
- (void)changeStyleUIByStyle:(NSInteger)style{
    _rightBtn_0.sd_layout
    .heightIs(25);
    _rightBtn_1.sd_layout
    .heightIs(25);
    switch (style) {
        case 10:
        {//待付款
            [_rightBtn_0 setTitle:@"去付款" forState:UIControlStateNormal];
            [_rightBtn_1 setTitle:@"取消订单" forState:UIControlStateNormal];
        }
            break;
        case 20:
        {//待确认
            [_rightBtn_0 setTitle:@"申请退款" forState:UIControlStateNormal];
            _rightBtn_1.sd_layout
            .heightIs(0);
        }
            break;
        case 30:
        {//待使用
            [_rightBtn_0 setTitle:@"确认使用" forState:UIControlStateNormal];
            [_rightBtn_1 setTitle:@"申请退款" forState:UIControlStateNormal];
        }
            break;
        case 40:
        {//待评价
            [_rightBtn_0 setTitle:@"去评价" forState:UIControlStateNormal];
            [_rightBtn_1 setTitle:@"重新预订" forState:UIControlStateNormal];
        }
            break;
        case 50:
        {//已完结
            [_rightBtn_0 setTitle:@"重新预订" forState:UIControlStateNormal];
            _rightBtn_1.sd_layout
            .heightIs(0);
        }
            break;
        case 300:
        {//待退款
            _rightBtn_0.sd_layout
            .heightIs(0);
            _rightBtn_1.sd_layout
            .heightIs(0);
        }
            break;
        case 350:
        {//已退款
            [_rightBtn_0 setTitle:@"重新预订" forState:UIControlStateNormal];
            _rightBtn_1.sd_layout
            .heightIs(0);
        }
            break;
        case 400:
        {//已取消
            [_rightBtn_0 setTitle:@"重新预订" forState:UIControlStateNormal];
            _rightBtn_1.sd_layout
            .heightIs(0);
        }
            break;

        default:
            break;
    }
    
}
/** 接受数据*/
- (void)setModel:(MyOrderListItemModel *)model{
    _model = model;
    _orderNumLb.text = [NSString stringWithFormat:@"订单号：%@", model.orderInfo.orderNo];
    _orderStyleLb.text = model.orderInfo.statusName;
    [_goodsIv sd_setImageWithURL:FULLIMGURL(model.serviceInfo.logoUrl) placeholderImage:Placeholder_middle];
    _nameLb.text = model.ballPlaceInfo.name;
    _comboLb.text = model.serviceInfo.name;
    _timeLb.text = model.orderInfo.bookTime;
    _numeLb.text = model.orderInfo.personNum;
    _priceLb.text = [NSString stringWithFormat:@"¥%@", model.orderInfo.totalPrice];
    [self changeStyleUIByStyle:model.orderInfo.status];
}

#pragma mark ----------------按钮动作
/** 根据传入的index 判断当前按钮触发什么动作*/
- (void)right_0_Action:(UIButton *)btn{
    if (_block_0) {
        _block_0(_model);
    }
}

- (void)right_1_Action:(UIButton *)btn{
    if (_block_1) {
        _block_1(_model);
    }
}

#pragma mark ----------------实例

- (UIView *)orderInfoView{
    if (!_orderInfoView) {
        _orderInfoView = [[UIView alloc] init];
        _orderInfoView.backgroundColor = WHITECOLOR;
        [_orderInfoView addSubview:self.orderNumLb];
        [_orderInfoView addSubview:self.orderStyleLb];
    }
    return _orderInfoView;
}

- (UIView *)goodsInfoView{
    if (!_goodsInfoView) {
        _goodsInfoView = [[UIView alloc] init];
        _goodsInfoView.backgroundColor = WHITECOLOR;
        [_goodsInfoView sd_addSubviews:@[self.goodsIv, self.nameLb, self.comboTitleLb, self.comboLb, self.timeTitleLb, self.timeLb,
                                         self.numTitleLb, self.numeLb]];
    }
    return _goodsInfoView;
}

- (UIView *)orderPriceInfoView{
    if (!_orderPriceInfoView) {
        _orderPriceInfoView = [[UIView alloc] init];
        _orderPriceInfoView.backgroundColor = WHITECOLOR;
        [_orderPriceInfoView sd_addSubviews:@[self.priceTitleLb, self.priceLb, self.rightBtn_0, self.rightBtn_1]];
    }
    return _orderPriceInfoView;

}

- (UILabel *)orderNumLb{
    if (!_orderNumLb) {
        _orderNumLb = [[UILabel alloc] init];
        _orderNumLb.font = FONT(12);
        _orderNumLb.textColor = BLACKTEXTCOLOR;
        _orderNumLb.text = @"订单号： 000000";
    }
    return _orderNumLb;
}

- (UILabel *)orderStyleLb{
    if (!_orderStyleLb) {
        _orderStyleLb = [[UILabel alloc] init];
        _orderStyleLb.font = FONT(12);
        _orderStyleLb.textColor = GLOBALCOLOR;
        _orderStyleLb.text = @"未知状态";
    }
    return _orderStyleLb;
}

- (UIImageView *)goodsIv{
    if (!_goodsIv) {
        _goodsIv = [[UIImageView alloc] init];
        _goodsIv.backgroundColor = [UIColor redColor];
    }
    return _goodsIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"未知场地";
    }
    return _nameLb;
}

- (UILabel *)comboTitleLb{
    if (!_comboTitleLb) {
        _comboTitleLb = [[UILabel  alloc] init];
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
        _comboLb.text = @"地方萨芬的";
    }
    return _comboLb;
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
        _timeLb.text = @"00/0/0000, 00:00~00:00";
    }
    return _timeLb;
}

- (UILabel *)numTitleLb{
    if (!_numTitleLb) {
        _numTitleLb = [[UILabel alloc] init];
        _numTitleLb.font = FONT(12);
        _numTitleLb.textColor = LIGHTTEXTCOLOR;
        _numTitleLb.text = @"数量：";
    }
    return _numTitleLb;
}

- (UILabel *)numeLb{
    if (!_numeLb) {
        _numeLb  = [[UILabel alloc] init];
        _numeLb.font = FONT(12);
        _numeLb.textColor = [UIColor redColor];
        _numeLb.text = @"未知";
    }
    return _numeLb;
}

- (UILabel *)priceTitleLb{
    if (!_priceTitleLb) {
        _priceTitleLb = [[UILabel alloc] init];
        _priceTitleLb.font = FONT(12);
        _priceTitleLb.textColor = BLACKTEXTCOLOR;
        _priceTitleLb.text = @"订单金额 ";
    }
    return _priceTitleLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(14);
        _priceLb.textColor = [UIColor redColor];
        _priceLb.text = @"¥ 00.00";
    }
    return _priceLb;
}

- (UIButton *)rightBtn_0{
    if (!_rightBtn_0) {
        _rightBtn_0 = [[UIButton alloc] init];
        [_rightBtn_0 setTitle:@"未知按钮" forState:UIControlStateNormal];
        [_rightBtn_0 setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        _rightBtn_0.titleLabel.font = FONT(12);
        _rightBtn_0.layer.borderWidth = 0.5;
        _rightBtn_0.layer.borderColor = GLOBALCOLOR.CGColor;
        [_rightBtn_0 addTarget:self action:@selector(right_0_Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn_0;

}

- (UIButton *)rightBtn_1{
    if (!_rightBtn_1) {
        _rightBtn_1 = [[UIButton alloc] init];
        [_rightBtn_1 setTitle:@"未知按钮" forState:UIControlStateNormal];
        [_rightBtn_1 setTitleColor:SHENTEXTCOLOR forState:UIControlStateNormal];
        _rightBtn_1.titleLabel.font = FONT(12);
        _rightBtn_1.layer.borderWidth = 0.5;
        _rightBtn_1.layer.borderColor = SHENTEXTCOLOR.CGColor;
        [_rightBtn_1 addTarget:self action:@selector(right_1_Action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn_1;

}


@end
