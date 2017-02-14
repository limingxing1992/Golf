//
//  AppointPlaceTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "AppointPlaceTableViewCell.h"

@interface AppointPlaceTableViewCell ()
/** 球场头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 球场标题*/
@property (nonatomic, strong) UILabel *titleLb;
/** 球场风格*/
@property (nonatomic, strong) UILabel *styleLb;
/** 球场距离*/
@property (nonatomic, strong) UILabel *distanceLb;
/** 球场地址*/
@property (nonatomic, strong) UILabel *addressLb;
/** 球场均价*/
@property (nonatomic, strong) UILabel *priceLb;

@end

@implementation AppointPlaceTableViewCell

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
        self.contentView.backgroundColor  = WHITECOLOR;
        [self.contentView sd_addSubviews:@[self.headIv,
                                           self.titleLb,
                                           self.styleLb,
                                           self.distanceLb,
                                           self.addressLb,
                                           self.priceLb]];
        [self autoLayoutsubviews];//开启自动布局
    }
    return self;
}
/** 自动布局*/
- (void)autoLayoutsubviews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 12)
    .bottomSpaceToView(self.contentView, 12)
    .leftSpaceToView(self.contentView, 15)
    .widthEqualToHeight();
    
    _titleLb.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(_headIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _styleLb.sd_layout
    .centerYEqualToView(_headIv)
    .leftEqualToView(_titleLb)
    .autoHeightRatio(0);
    [_styleLb setSingleLineAutoResizeWithMaxWidth:200];
    
    _addressLb.sd_layout
    .bottomEqualToView(_headIv)
    .leftSpaceToView(_headIv, 80)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    
    _distanceLb.sd_layout
    .centerYEqualToView(_addressLb)
    .leftEqualToView(_titleLb)
    .rightSpaceToView(_addressLb,5)
    .heightIs(12);
    
    _priceLb.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [_priceLb setSingleLineAutoResizeWithMaxWidth:200];
}

- (void)hidePriceLabel{
    _priceLb.hidden = YES;
}

#pragma mark ----------------数据

- (void)setModel:(PlaceItemModel *)model{
    [_headIv sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_middle];
    _titleLb.text = model.name;
    _styleLb.text = model.typeName;
    _distanceLb.text = model.distance;
    _priceLb.text = [NSString stringWithFormat:@"¥%@",model.price];
    _addressLb.text = model.address;
}


#pragma mark ----------------实例化

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = IMAGE(@"placeholder130");
    }
    return _headIv;
}

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(14);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.text = @"未知球场";
    }
    return _titleLb;
}

- (UILabel *)styleLb{
    if (!_styleLb) {
        _styleLb = [[UILabel alloc] init];
        _styleLb.font = FONT(12);
        _styleLb.textColor = LIGHTTEXTCOLOR;
        _styleLb.text = @"未知风格";
    }
    return _styleLb;
}

- (UILabel *)distanceLb{
    if (!_distanceLb) {
        _distanceLb  = [[UILabel alloc] init];
        _distanceLb.font = FONT(12);
        _distanceLb.textColor = LIGHTTEXTCOLOR;
        _distanceLb.text = @"00.00km";
    }
    return _distanceLb;
}

- (UILabel *)addressLb{
    if (!_addressLb) {
        _addressLb = [[UILabel alloc] init];
        _addressLb.font = FONT(12);
        _addressLb.textColor = LIGHTTEXTCOLOR;
        _addressLb.text = @"未知地址";
    }
    return _addressLb;
}

- (UILabel *)priceLb{
    if (!_priceLb) {
        _priceLb = [[UILabel alloc] init];
        _priceLb.font = FONT(13);
        _priceLb.textColor = OrangeCOLOR;
        _priceLb.text = @"¥0";
    }
    return _priceLb;
}
@end
