//
//  TSOClubInfoView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubInfoView.h"
#import "ClubArticleDetailModel.h"
#import "ClubArticle.h"

@interface TSOClubInfoView ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**uilabel*/
@property (nonatomic, strong) UILabel *nameLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**帖子or公告*/
@property (nonatomic, strong) UILabel *tipLable;

/**titleLabel*/
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TSOClubInfoView




- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.tipLable];
    [self addSubview:self.titleLabel];
    
    self.icon.sd_layout
    .topSpaceToView(self, 15)
    .leftSpaceToView(self, 15)
    .heightIs(27)
    .widthIs(27);
    self.icon.sd_cornerRadius = @3;
    
    self.nameLabel.sd_layout
    .topEqualToView(self.icon)
    .leftSpaceToView(self.icon, 10)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.timeLabel.sd_layout
    .bottomEqualToView(self.icon)
    .leftSpaceToView(self.icon, 10)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.tipLable.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.tipLable setSingleLineAutoResizeWithMaxWidth:100];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.tipLable, 15)
    .centerYEqualToView(self.tipLable)
    .autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:200];


}

- (void)nameLabelAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [_nameLabel addGestureRecognizer:tap];
}

- (void)iconImageAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [_icon addGestureRecognizer:tap];
}

- (void)setModel:(ClubArticleDetailModel *)model{
    _model = model;
    
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.data.logoUrl) placeholderImage:Placeholder_small];
    self.nameLabel.text = _model.data.clubName;
    self.timeLabel.text = [NSDate timeLineStringWithString:_model.data.createTime];
    self.titleLabel.text = _model.data.title;
    
    if (_model.data.type.integerValue == 10) {
        self.tipLable.text = @" 公告 ";
    }else{
        self.tipLable.text = @" 帖子 ";
        self.tipLable.textColor = GLOBALCOLOR;
        self.tipLable.layer.borderColor = GLOBALCOLOR.CGColor;
    }
}


//MARK: - Setter&Getter

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
        _icon.userInteractionEnabled = YES;
   
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(13);
        _nameLabel.textColor = BLACKTEXTCOLOR;
        _nameLabel.userInteractionEnabled = YES;
    }
    return _nameLabel;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(10);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
        
    }
    return _timeLabel;
}

- (UILabel *)tipLable{
    if (_tipLable == nil) {
        _tipLable = [[UILabel alloc] init];
        _tipLable.layer.borderColor = OrangeCOLOR.CGColor;
        _tipLable.layer.borderWidth = 0.5;
        _tipLable.layer.cornerRadius = 3;
        _tipLable.font = FONT(12);
        _tipLable.textColor = OrangeCOLOR;
    }
    return _tipLable;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = BLACKTEXTCOLOR;
        _titleLabel.font = FONT(16);
        
    }
    return _titleLabel;
}

@end
