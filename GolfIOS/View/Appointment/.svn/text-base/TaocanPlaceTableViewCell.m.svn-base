//
//  TaocanPlaceTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TaocanPlaceTableViewCell.h"

@interface TaocanPlaceTableViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 套餐标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLb;
/** 内容*/
@property (nonatomic, strong) UILabel *contenLb;



@end

@implementation TaocanPlaceTableViewCell

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
        [self.contentView sd_addSubviews:@[self.headIv,
                                           self.titleLb,
                                           self.timeLb,
                                           self.contenLb,
                                           self.priceLb,
                                           self.apointBtn]];
        [self autoLayoutSubViews];//布局
    }
    return self;
}

/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 11)
    .bottomSpaceToView(self.contentView, 11)
    .widthEqualToHeight();
    
    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 13)
    .leftSpaceToView(_headIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(14);
    
    _timeLb.sd_layout
    .centerYEqualToView(self.contentView)
    .leftEqualToView(_titleLb)
    .heightIs(12);
    [_timeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _contenLb.sd_layout
    .bottomSpaceToView(self.contentView, 13)
    .leftEqualToView(_titleLb)
    .rightEqualToView(_titleLb)
    .heightIs(12);
    
    _apointBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(22);
    [_apointBtn setupAutoSizeWithHorizontalPadding:10 buttonHeight:22];
    [_apointBtn setSd_cornerRadius:@3];
    
    _priceLb.sd_layout
    .centerYEqualToView(_apointBtn)
    .rightSpaceToView(_apointBtn, 5)
    .heightIs(12);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:200];
    
}

#pragma mark ----------------数据

- (void)setModel:(PlaceComboItemModel *)model{
    _model = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_middle];
    _priceLb.text = [NSString stringWithFormat:@"¥%@",model.price];
    _titleLb.text = model.name;
    _timeLb.text = [NSString stringWithFormat:@"服务时间：%@小时",model.serviceHour];
    if (model.serviceHour.integerValue == 0) {
        _timeLb.text = [NSString stringWithFormat:@"服务时间：不限"];
    }
    
    
    _contenLb.text = [NSString stringWithFormat:@"服务内容：%@",model.content];
}


#pragma mark ----------------预订

- (void)appointmentAction{
    
    if (_block) {
        _block();
    }
}


#pragma mark ----------------实例

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"未知套餐";
    }
    return _titleLb;
}

- (UILabel *)timeLb{
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(12);
        _timeLb.textColor = LIGHTTEXTCOLOR;
        _timeLb.text = @"00:00 - 00:00";
    }
    return _timeLb;
}

- (UILabel *)contenLb{
    if (!_contenLb) {
        _contenLb = [[UILabel alloc] init];
        _contenLb.font = FONT(12);
        _contenLb.textColor = LIGHTTEXTCOLOR;
        _contenLb.text = @"未知内容";
    }
    return _contenLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(12);
        _priceLb.textColor = OrangeCOLOR;
        _priceLb.text = @"¥0";
    }
    return _priceLb;
}

- (UIButton *)apointBtn{
    if (!_apointBtn) {
        _apointBtn = [[UIButton alloc] init];
        [_apointBtn setBackgroundColor:OrangeCOLOR];
        [_apointBtn setTitle:@"预订" forState:UIControlStateNormal];
        [_apointBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _apointBtn.titleLabel.font = FONT(12);
        [_apointBtn addTarget:self action:@selector(appointmentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _apointBtn;
}

@end
