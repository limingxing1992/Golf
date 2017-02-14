//
//  AppointmentFriendResultTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2017/1/3.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import "AppointmentFriendResultTableViewCell.h"

@interface AppointmentFriendResultTableViewCell ()

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;

/** 底部线条*/
@property (nonatomic, strong) UIView *lineView;

/** 底部*/
@property (nonatomic, strong) UIView *backView;

@end

@implementation AppointmentFriendResultTableViewCell

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
        self.contentView.backgroundColor = GRAYCOLOR;
        [self.contentView addSubview:self.backView];
        self.backView.sd_layout
        .topSpaceToView(self.contentView, 10)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .bottomSpaceToView(self.contentView, 0);
        [self.backView addSubview:self.nameLb];
        [self.backView addSubview:self.headIv];
        [self.backView addSubview:self.lineView];
        
        
        self.headIv.sd_layout
        .centerYEqualToView(self.backView)
        .leftSpaceToView(self.backView, 15)
        .heightIs(37.5)
        .widthEqualToHeight();
        [self.headIv setSd_cornerRadiusFromWidthRatio:@0.5];
        
        self.lineView.sd_layout
        .bottomSpaceToView(self.backView, 0.5)
        .leftEqualToView(self.headIv)
        .rightSpaceToView(self.backView, 0)
        .heightIs(0.5);
        
        self.nameLb.sd_layout
        .centerYEqualToView(self.backView)
        .leftSpaceToView(self.headIv, 7)
        .rightSpaceToView(self.backView, 100)
        .heightIs(12);
    }
    return self;
}


#pragma mark ----------------数据

- (void)setModel:(FriendUserModel *)model{
    _model = model;
    if ([model.nickName length]) {
        _nameLb.text = model.nickName;
    }else{
        _nameLb.text = model.userName;
    }
    
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
}


#pragma mark ----------------实例化

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = FONT(12);
        _nameLb.text = @"---";
    }
    return _nameLb;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = WHITECOLOR;
    }
    return _backView;
}

@end
