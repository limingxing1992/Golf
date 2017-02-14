//
//  TSOHomeInvitationTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeInvitationTableViewCell.h"
#import "HomeInfoModel.h"
@interface TSOHomeInvitationTableViewCell ()

/**顶部分割线*/
@property (nonatomic, strong) UIView *lineView;
/**头像*/
@property (nonatomic, strong) UIImageView *icon;
/**name*/
@property (nonatomic, strong) UILabel *nameLabel;
/**邀约详情*/
@property (nonatomic, strong) UILabel *invitationMessageLable;
///**邀约时间*/
//@property (nonatomic, strong) UILabel *timeLabel;
/**邀约时间图标*/
//@property (nonatomic, strong) UIImageView *timeIcon;
/**地址*/
@property (nonatomic, strong) UILabel *addressLabel;
/**地址图标*/
@property (nonatomic, strong) UIImageView *addressIcon;

@end

@implementation TSOHomeInvitationTableViewCell

#pragma mark - Setter&Getter

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
        _lineView.backgroundColor = GRAYCOLOR;
    }
    return _lineView;
}

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = Placeholder_small;
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(12);
        _nameLabel.textColor = BLACKTEXTCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)invitationMessageLable{
    if (_invitationMessageLable == nil) {
        _invitationMessageLable = [[UILabel alloc] init];
        _invitationMessageLable.font = FONT(12);
        _invitationMessageLable.textColor = BLACKTEXTCOLOR;
    }
    return _invitationMessageLable;
}

//- (UIImageView *)timeIcon{
//    if (_timeIcon == nil) {
//        _timeIcon = [[UIImageView alloc] init];
//        _timeIcon.image = IMAGE(@"classify9");
//    
//    }
//    return _timeIcon;
//}

//- (UILabel *)timeLabel{
//    if (_timeLabel == nil) {
//        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.font = FONT(14);
//        _timeLabel.textColor = LIGHTTEXTCOLOR;
//    }
//    return _timeLabel;
//}

- (UIImageView *)addressIcon{
    if (_addressIcon == nil) {
        _addressIcon = [[UIImageView alloc] init];
        _addressIcon.image = IMAGE(@"classify13");
    }
    return _addressIcon;
}

- (UILabel *)addressLabel{
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = FONT(12);
        _addressLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _addressLabel;
}


#pragma mark - LifeCycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.invitationMessageLable];
//    [self.contentView addSubview:self.timeIcon];
//    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.addressIcon];
    

    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(43)
    .heightIs(43);
    self.icon.sd_cornerRadius = @3;
    
    self.nameLabel.sd_layout
    .topEqualToView(self.icon)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.invitationMessageLable.sd_layout
    .topSpaceToView(self.contentView, 42)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.invitationMessageLable setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 43 - 30 - 15];
    [self.invitationMessageLable setMaxNumberOfLinesToShow:1];
    
//    self.timeIcon.sd_layout
//    .topSpaceToView(self.icon, 15)
//    .leftSpaceToView(self.contentView, 15)
//    .widthIs(16)
//    .heightIs(16);
    
//    self.timeLabel.sd_layout
//    .leftSpaceToView(self.timeIcon, 8)
//    .centerYEqualToView(self.timeIcon)
//    .autoHeightRatio(0);
//    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.addressIcon.sd_layout
    .topSpaceToView(self.icon ,15)
    .leftSpaceToView(self.icon, 15)
    .widthIs(12)
    .heightIs(16);
    
    self.addressLabel.sd_layout
    .leftSpaceToView(self.addressIcon, 8)
    .centerYEqualToView(self.addressIcon)
    .autoHeightRatio(0);
    [self.addressLabel setSingleLineAutoResizeWithMaxWidth:300];
    
}

- (void)setModel:(HomeInviteMeCellModel *)model{
    _model = model;
    
    self.nameLabel.text = _model.nickname;
    self.invitationMessageLable.text = _model.content;
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.headUrl) placeholderImage:Placeholder_small];
    self.addressLabel.text = _model.name;
}
@end
