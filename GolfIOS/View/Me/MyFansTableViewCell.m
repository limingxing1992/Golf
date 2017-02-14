//
//  MyFansTableViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyFansTableViewCell.h"

@interface MyFansTableViewCell ()
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLb;
/** 等级图标*/
@property (nonatomic, strong) UIImageView *indicatorIv;
/** 关注按钮*/
@property (nonatomic, strong) UIButton *focusBtn;





@end

@implementation MyFansTableViewCell

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
        [self.contentView addSubview:self.indicatorIv];
        [self.contentView addSubview:self.focusBtn];
        [self autoLayoutSubViews];
    }
    return self;
}
/** 自动布局*/
- (void)autoLayoutSubViews{
    _headIv.sd_layout
    .topSpaceToView(self.contentView, 15)
    .bottomSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthEqualToHeight();
    
    _nameLb.sd_layout
    .topSpaceToView(self.contentView, 16)
    .leftSpaceToView(_headIv, 10)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    _indicatorIv.sd_layout
    .bottomSpaceToView(self.contentView, 17)
    .leftEqualToView(_nameLb)
    .heightIs(10.5)
    .widthIs(37.5);
    
    _focusBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(56.5)
    .heightIs(21);
    [_focusBtn setSd_cornerRadiusFromHeightRatio:@0.5];

}


#pragma mark ----------------数据

- (void)setModel:(FriendUserModel *)model{
    _model  = model;
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    NSString *text;
    if (model.nickName) {
        text = model.nickName;
    }else{
        text = model.userName;
    }
    _nameLb.text = text;
    
    _indicatorIv.image = model.levelImg;
    
    [_focusBtn setSelected:model.flag];
    if (model.flag) {
        _focusBtn.layer.borderColor = GRAYCOLOR.CGColor;
    }else{
        _focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
    }

}



#pragma mark ----------------关注

- (void)attentionAction{
    
    GOLFWeakObj(self);
    
    if (_focusBtn.isSelected) {
        //取关操作
        _focusBtn.selected = NO;
        _focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        [ShareBusinessManager.userManager postMyAttentionRemoveWithParameters:@{@"userId":_model.userId}
                                                                      success:^(id responObject) {
                                                                          //取关成功不做任何操作
                                                                      } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                          //取关失败
                                                                          weakself.focusBtn.layer.borderColor = GRAYCOLOR.CGColor;
                                                                          weakself.focusBtn.selected = YES;
                                                                          [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                      }];
        
        
        
    }else{
        //关注操作
        _focusBtn.selected = YES;
        _focusBtn.layer.borderColor = GRAYCOLOR.CGColor;
        [ShareBusinessManager.userManager postMyAttentionAddWithParameters:@{@"userId":_model.userId}
                                                                   success:^(id responObject) {
                                                                       //关注成功不做任何操作
                                                                   } failure:^(NSInteger errCode, NSString *errorMsg) {
                                                                       //关注失败
                                                                       weakself.focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
                                                                       weakself.focusBtn.selected = NO;
                                                                       [SVProgressHUD showErrorWithStatus:errorMsg];
                                                                   }];
    }

//    if (_focusBtn.isSelected) {
//        //取消关注
//        _focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
//    }else{
//        _focusBtn.layer.borderColor = GRAYCOLOR.CGColor;
//    }
//    _focusBtn.selected = !_focusBtn.isSelected;
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
        _nameLb.font = FONT(14);
        _nameLb.textColor = BLACKTEXTCOLOR;
        _nameLb.text = @"星";
    }
    return _nameLb;
}

- (UIImageView *)indicatorIv{
    if (!_indicatorIv) {
        _indicatorIv = [[UIImageView alloc] init];
        _indicatorIv.image = IMAGE(@"classify148");
    }
    return _indicatorIv;
}

- (UIButton *)focusBtn{
    if (!_focusBtn) {
        _focusBtn = [[UIButton alloc] init];
        _focusBtn.titleLabel.font = FONT(12);
        [_focusBtn setTitle:@"关注TA" forState:UIControlStateNormal];
        [_focusBtn setTitle:@"互关" forState:UIControlStateSelected];
        [_focusBtn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        [_focusBtn setTitleColor:LIGHTTEXTCOLOR forState:UIControlStateSelected];
        _focusBtn.layer.borderWidth = 0.5;
        _focusBtn.layer.borderColor = GLOBALCOLOR.CGColor;
        [_focusBtn addTarget:self action:@selector(attentionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

@end
