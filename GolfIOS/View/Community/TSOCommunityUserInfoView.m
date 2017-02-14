//
//  TSOCommunityUserInfoView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOCommunityUserInfoView.h"
#import "CommunityUserDeailModel.h"
#import "CommunityPersonalUserDeailModel.h"

@interface TSOCommunityUserInfoView ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**name*/
@property (nonatomic, strong) UILabel *nameLabel;
/**关注*/
@property (nonatomic, strong) UILabel *focusNumLabel;
/**粉丝*/
@property (nonatomic, strong) UILabel *fansNumLabel;
/***/
@property (nonatomic, strong) YB_FocusButton *focusBtn;

/**搜藏*/
@property (nonatomic, strong) UILabel *collectLabel;

@end

@implementation TSOCommunityUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.focusNumLabel];
    [self addSubview:self.fansNumLabel];
    [self addSubview:self.focusBtn];
    [self addSubview:self.collectLabel];
    
    
    CGFloat space = (SCREEN_WIDTH - 230) * 0.5;
    self.icon.sd_layout
    .topSpaceToView(self, 15)
    .leftSpaceToView(self, 15)
    .widthIs(43)
    .heightIs(43);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self, 17)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.focusNumLabel.sd_layout
    .bottomEqualToView(self.icon)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.focusNumLabel setSingleLineAutoResizeWithMaxWidth:150];
 
    self.fansNumLabel.sd_layout
    .leftSpaceToView(self.focusNumLabel, space)
    .bottomEqualToView(self.focusNumLabel)
    .autoHeightRatio(0);
    [self.fansNumLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.focusBtn.sd_layout
    .rightSpaceToView(self, 15)
    .centerYEqualToView(self)
    .widthIs(53)
    .heightIs(24);
    
    
    
    self.collectLabel.sd_layout
    .leftSpaceToView(self.fansNumLabel, space)
    .bottomEqualToView(self.fansNumLabel)
    .autoHeightRatio(0);
    
    
    [self.collectLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    
}

- (void)focusNumLabelAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.focusNumLabel addGestureRecognizer:tap];
}

- (void)fansNumLabelAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.fansNumLabel addGestureRecognizer:tap];
}

- (void)focusBtnAddTarget:(id)target action:(SEL)action{
    [self.focusBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

//搜藏
- (void)collectLabelAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self.collectLabel addGestureRecognizer:tap];
}


- (void)setModel:(CommunityUserDeail *)model{
    _model = model;
    
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.headUrl) placeholderImage:Placeholder_small];
    self.nameLabel.text = _model.nickname;
    
    NSString *focusStr = [NSString stringWithFormat:@"TA的关注  %@",_model.followNum];
    
    NSMutableAttributedString *attrfocusStr = [[NSMutableAttributedString alloc] initWithString:focusStr];
    [attrfocusStr addAttribute:NSForegroundColorAttributeName
                         value:LIGHTTEXTCOLOR
                         range:[focusStr rangeOfString:@"TA的关注"]];
    
    self.focusNumLabel.attributedText = attrfocusStr;
    
    NSString *fansStr = [NSString stringWithFormat:@"粉丝  %@",_model.fansNum];
    
    NSMutableAttributedString *attrfansStr = [[NSMutableAttributedString alloc] initWithString:fansStr];
    [attrfansStr addAttribute:NSForegroundColorAttributeName
                        value:LIGHTTEXTCOLOR
                        range:[fansStr rangeOfString:@"粉丝"]];
    
    self.fansNumLabel.attributedText = attrfansStr;
    
    if (_model.isfollow) {
        [self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    }
    
}

- (void)setMyModel:(CommunityPersonalUserDeail *)myModel{
    _myModel = myModel;
    self.collectLabel.hidden = NO;
    self.focusBtn.hidden = YES;
    
    [self.icon sd_setImageWithURL:FULLIMGURL(_myModel.headUrl) placeholderImage:Placeholder_small];
    self.nameLabel.text = _myModel.nickname;
    
    NSString *focusStr = [NSString stringWithFormat:@"我的关注  %@",_myModel.followNum];
    
    NSMutableAttributedString *attrfocusStr = [[NSMutableAttributedString alloc] initWithString:focusStr];
    [attrfocusStr addAttribute:NSForegroundColorAttributeName
                         value:LIGHTTEXTCOLOR
                         range:[focusStr rangeOfString:@"我的关注"]];
    
    self.focusNumLabel.attributedText = attrfocusStr;
    NSString *fansStr = [NSString stringWithFormat:@"粉丝  %@",_myModel.fansNum];
    NSMutableAttributedString *attrfansStr = [[NSMutableAttributedString alloc] initWithString:fansStr];
    [attrfansStr addAttribute:NSForegroundColorAttributeName
                        value:LIGHTTEXTCOLOR
                        range:[fansStr rangeOfString:@"粉丝"]];
    self.fansNumLabel.attributedText = attrfansStr;
    
    
    NSString *collectionStr = [NSString stringWithFormat:@"收藏  %@",_myModel.collectNum];
    NSMutableAttributedString *attrCollection = [[NSMutableAttributedString alloc] initWithString:collectionStr];
    [attrCollection addAttribute:NSForegroundColorAttributeName
                        value:LIGHTTEXTCOLOR
                        range:[collectionStr rangeOfString:@"收藏"]];
    self.collectLabel.attributedText = attrCollection;

    
}

#pragma mark - Setter&Getter

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(14);
        _nameLabel.textColor = BLACKTEXTCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)focusNumLabel{
    if (_focusNumLabel == nil) {
        _focusNumLabel = [[UILabel alloc] init];
        _focusNumLabel.font = FONT(12);
        _focusNumLabel.textColor = BLACKTEXTCOLOR;
        _focusNumLabel.userInteractionEnabled = YES;
    }
    return _focusNumLabel;
}

- (UILabel *)fansNumLabel{
    if (_fansNumLabel == nil) {
        _fansNumLabel = [[UILabel alloc] init];
        _fansNumLabel.font = FONT(12);
        _fansNumLabel.textColor = BLACKTEXTCOLOR;
        _fansNumLabel.userInteractionEnabled = YES;
        
    }
    return _fansNumLabel;
}


- (UILabel *)collectLabel{
    if (_collectLabel == nil) {
        _collectLabel = [[UILabel alloc] init];
        _collectLabel.font = FONT(12);
        _collectLabel.textColor = BLACKTEXTCOLOR;
        _collectLabel.hidden = YES;
        _collectLabel.userInteractionEnabled = YES;
    }
    return _collectLabel;
}

- (YB_FocusButton *)focusBtn{
    if (_focusBtn == nil) {
        _focusBtn = [[YB_FocusButton alloc] init];
        [_focusBtn sizeToFit];
    }
    return _focusBtn;
}

@end
