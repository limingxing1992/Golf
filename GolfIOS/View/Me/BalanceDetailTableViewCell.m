//
//  BalanceDetailTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/12.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BalanceDetailTableViewCell.h"

@interface BalanceDetailTableViewCell ()

/** 消费方式*/
@property (nonatomic, strong) UILabel *styleLb;

/** 消费标题（只有在预订场地消费方式情况展示 预订球场标题）*/
@property (nonatomic, strong) UILabel *titleLb;

/** 消费时间*/
@property (nonatomic, strong) UILabel *timeLb;

/** 消费金额*/
@property (nonatomic, strong) UILabel *priceLb;


/** +-号*/
@property (nonatomic, strong) UILabel *addSubitLb;



@end

@implementation BalanceDetailTableViewCell

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
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.styleLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.priceLb];
        [self.contentView addSubview:self.addSubitLb];
        [self autoLayoutSubViews];
    }
    return self;
}

- (void)autoLayoutSubViews{
    _styleLb.sd_layout
    .topSpaceToView(self.contentView, 18)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(14);
    [_styleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _titleLb.sd_layout
    .centerYEqualToView(_styleLb)
    .leftSpaceToView(_styleLb, 5)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(14);
    
    _timeLb.sd_layout
    .bottomSpaceToView(self.contentView, 18)
    .leftEqualToView(_styleLb)
    .heightIs(14);
    [_timeLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
    _priceLb.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
    
}

#pragma mark ----------------刷新界面

- (void)setModel:(MyBirdWalletFillRecordModel *)model{
    _model = model;
    
    _styleLb.text = model.flagName;
    _titleLb.text = model.serviceName;
    _timeLb.text = model.createTime;
    if ([_styleLb.text isEqualToString:@"消费"] || [_styleLb.text isEqualToString:@"升级"]) {
        //减号
        _priceLb.text = [NSString stringWithFormat:@"-%@",_model.amount];
        _priceLb.textColor = GLOBALCOLOR;
    }else{
        //加
        _priceLb.text = [NSString stringWithFormat:@"+%@",_model.amount];
        _priceLb.textColor = RGBColor(239, 83, 0);
    }
}


#pragma mark ----------------实例

- (UILabel *)styleLb{
    if (!_styleLb) {
        _styleLb = [[UILabel  alloc] init];
        _styleLb.font = FONT(14);
        _styleLb.textColor = BLACKTEXTCOLOR;
        _styleLb.text = @"会员充值";
    }
    return _styleLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(11);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        _timeLb.text = @"2015-09-11";
    }
    return _timeLb;
}


- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(12);
        _priceLb.textColor = RGBColor(239, 83, 0);
        _priceLb.text = @"-13.00";
    }
    return _priceLb;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"高尔夫球场";
    }
    return _titleLb;
}


@end
