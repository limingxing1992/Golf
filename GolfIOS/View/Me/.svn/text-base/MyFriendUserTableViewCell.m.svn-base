//
//  MyFriendUserTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendUserTableViewCell.h"

@interface MyFriendUserTableViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 昵称*/
@property (nonatomic, strong) UILabel *nameLb;

/** 底部线条*/
@property (nonatomic, strong) UIView *lineView;


@end

@implementation MyFriendUserTableViewCell

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
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.headIv];
        [self.contentView addSubview:self.lineView];
        
        self.headIv.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 15)
        .heightIs(37.5)
        .widthEqualToHeight();
        [self.headIv setSd_cornerRadiusFromWidthRatio:@0.5];
        
        self.lineView.sd_layout
        .bottomSpaceToView(self.contentView, 0.5)
        .leftEqualToView(self.headIv)
        .rightSpaceToView(self.contentView, 0)
        .heightIs(0.5);
        
        self.nameLb.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.headIv, 7)
        .rightSpaceToView(self.contentView, 100)
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


@end
