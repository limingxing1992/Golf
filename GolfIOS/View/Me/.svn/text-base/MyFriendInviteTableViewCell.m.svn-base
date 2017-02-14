//
//  MyFriendInviteTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/7.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFriendInviteTableViewCell.h"

@interface MyFriendInviteTableViewCell ()

/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 同意按钮*/
@property (nonatomic, strong) UIButton *focusBtn;
/** 留言信箱*/
@property (nonatomic, strong) UILabel *messageLb;



@end

@implementation MyFriendInviteTableViewCell

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
        self.contentView.backgroundColor = WHITECOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.headIv];
        [self.contentView addSubview:self.nameLb];
        [self.contentView addSubview:self.focusBtn];
        [self.contentView addSubview:self.messageLb];
        [self autoLayoutSubViews];
    }
    return self;
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
    _nameLb.sd_layout
    .centerYIs(20)
    .leftSpaceToView(_headIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    
    _messageLb.sd_layout
    .centerYIs(40)
    .leftEqualToView(_nameLb)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(12);
    
    _focusBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(45)
    .heightIs(21);
    [_focusBtn setSd_cornerRadiusFromHeightRatio:@0.5];
    
    
    
}

- (void)setModel:(FriendUserModel *)model{
    _model  = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    
    if (model.nickName.length) {
        _nameLb.text = model.nickName;
    }else{
        _nameLb.text = model.userName;
    }
    if (model.validateMessage.length) {
        _messageLb.text = model.validateMessage;
    }
    
    
    _focusBtn.enabled = !model.validateStatus;
    if (!_focusBtn.enabled) {
        _focusBtn.layer.borderWidth = 0;
    }else{
        _focusBtn.layer.borderWidth = 0.5;
    }
    
}

#pragma mark ----------------同意动作

- (void)attentionAction{
    [SVProgressHUD showWithStatus:@"添加中"];
    //同意请求
    [ShareBusinessManager.userManager postMyFriendAllowAddWithParameters:@{@"friendId":_model.userId,
                                                                           @"handleType":@1}
                                                                 success:^(id responObject) {
                                                                     _focusBtn.enabled = NO;
                                                                     _focusBtn.layer.borderWidth = 0;
                                                                     [SVProgressHUD showSuccessWithStatus:@"同意成功"];
                                                                     [GOLFNotificationCenter postNotificationName:@"updateFriendList" object:nil];
                                                                 }
                                                                 failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                     [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                 }];
}


#pragma mark ----------------实例化

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
        _nameLb.font = FONT(12);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"星";
    }
    return _nameLb;
}


- (UIButton *)focusBtn{
    if (!_focusBtn) {
        _focusBtn = [[UIButton alloc] init];
        _focusBtn.titleLabel.font = FONT(12);
        [_focusBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_focusBtn setTitle:@"已添加" forState:UIControlStateDisabled];
        [_focusBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_focusBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateDisabled];
        _focusBtn.layer.borderWidth = 0.5;
        _focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        [_focusBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

- (UILabel *)messageLb{
    if (!_messageLb) {
        _messageLb = [[UILabel alloc] init];
        _messageLb.font = FONT(12);
        _messageLb.textColor = LIGHTTEXTCOLOR;
        _messageLb.text = @"留言信息";
    }
    return _messageLb;
}

@end
