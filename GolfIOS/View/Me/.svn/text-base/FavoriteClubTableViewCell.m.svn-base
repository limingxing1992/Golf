//
//  FavoriteClubTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FavoriteClubTableViewCell.h"

@interface FavoriteClubTableViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/**  名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 简介*/
@property (nonatomic, strong) UILabel *introduceLb;




@end

@implementation FavoriteClubTableViewCell

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
        [self.contentView addSubview:self.headIv];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.introduceLb];
        [self autoLayoutSubViews];
    }
    return self;
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 15)
    .widthEqualToHeight();
    
    _nameLb.sd_layout
    .topSpaceToView(self.contentView, 25)
    .leftSpaceToView(_headIv, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _introduceLb.sd_layout
    .bottomSpaceToView(self.contentView, 25)
    .leftEqualToView(_nameLb)
    .rightEqualToView(_nameLb)
    .autoHeightRatio(0);
}

#pragma mark ----------------实例

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.backgroundColor = [UIColor redColor];
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(16);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"未知";
    }
    return _nameLb;
}

- (UILabel *)introduceLb{
    if (!_introduceLb) {
        _introduceLb = [[UILabel alloc] init];
        _introduceLb.font = FONT(14);
        _introduceLb.textColor = LIGHTTEXTCOLOR;
        _introduceLb.text = @"俱乐部简介：---------";
    }
    return _introduceLb;
}

@end
