//
//  TSOClubTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubTableViewCell.h"
#import "ClubArticle.h"

@interface TSOClubTableViewCell ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**title*/
@property (nonatomic, strong) UILabel *messageTitleLb;
/**俱乐部名称*/
@property (nonatomic, strong) UILabel *clubNameLb;
/**发帖时间*/
@property (nonatomic, strong) UILabel *timeLb;
/**公告或帖子*/
@property (nonatomic, strong) UILabel *tagLb;

@end

@implementation TSOClubTableViewCell

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = Placeholder_middle;
    }
    return _icon;
}
- (UILabel *)messageTitleLb{
    if (_messageTitleLb == nil) {
        _messageTitleLb = [[UILabel alloc] init];
        _messageTitleLb.font = FONT(14);
        _messageTitleLb.textColor = SHENTEXTCOLOR;
    }
    return _messageTitleLb;
}
- (UILabel *)clubNameLb{
    if (_clubNameLb == nil) {
        _clubNameLb = [[UILabel alloc] init];
        _clubNameLb.font = FONT(14);
        _clubNameLb.textColor = LIGHTTEXTCOLOR;
    }
    return _clubNameLb;
}

- (UILabel *)timeLb{
    if (_timeLb == nil) {
        _timeLb = [[UILabel alloc] init];
        _timeLb.font = FONT(14);
        _timeLb.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLb;
}

- (UILabel *)tagLb{
    if (_tagLb == nil) {
        _tagLb = [[UILabel alloc] init];
        _tagLb.font = FONT(12);
        _tagLb.textColor = WHITECOLOR;
        _tagLb.textAlignment = NSTextAlignmentCenter;
        _tagLb.layer.borderWidth = 0.5;
        
    }
    return _tagLb;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.tagLb];
    [self.contentView addSubview:self.messageTitleLb];
    [self.contentView addSubview:self.clubNameLb];
    [self.contentView addSubview:self.timeLb];
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(80)
    .heightIs(80);
    
    self.tagLb.sd_layout
    .topSpaceToView(self.contentView, 12)
    .leftSpaceToView(self.icon, 15)
    .heightIs(15)
    .widthIs(32);
    self.tagLb.sd_cornerRadius = @2;
//    [self.tagLb setSingleLineAutoResizeWithMaxWidth:100];
    
    
    self.messageTitleLb.sd_layout
    .centerYEqualToView(self.tagLb)
    .leftSpaceToView(self.tagLb, 5)
    .autoHeightRatio(0);
    [self.messageTitleLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 42 - 60];
    [self.messageTitleLb setMaxNumberOfLinesToShow:1];
    
    self.clubNameLb.sd_layout
    .leftSpaceToView(self.icon, 15)
    .centerYEqualToView(self.icon)
    .autoHeightRatio(0);
    [self.clubNameLb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 42 -45];
    [self.clubNameLb setMaxNumberOfLinesToShow:1];
    
    self.timeLb.sd_layout
    .bottomEqualToView(self.icon)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.timeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    //test
    self.messageTitleLb.text = @"俱乐部测试测试";
    self.clubNameLb.text = @"未知俱乐部";
    self.timeLb.text = @"1990-12-12";
    self.tagLb.text = @"帖子";
//    self.tagLb.backgroundColor = GLOBALCOLOR;
    
}

- (void)setModel:(ClubArticle *)model{
    _model = model;
    self.messageTitleLb.text = model.title;
    self.clubNameLb.text = model.clubName;
    NSRange timeStrRange = NSMakeRange(0, 10);
    self.timeLb.text = [model.createTime substringWithRange:timeStrRange];
    
    [self.icon sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_middle];
    
    
    if (model.type.integerValue == 10) {
        self.tagLb.text = @"公告";
       
        self.tagLb.layer.borderColor = RGBColor(248,158,96).CGColor;
        self.tagLb.textColor = RGBColor(248,158,96);

    }else if(model.type.integerValue == 20){
        self.tagLb.text = @"帖子";
        self.tagLb.layer.borderColor = GLOBALCOLOR.CGColor;
        self.tagLb.textColor = GLOBALCOLOR;

    }else{
        self.tagLb.sd_resetLayout
        .topSpaceToView(self.contentView, 12)
        .leftSpaceToView(self.icon, 10)
        .heightIs(15)
        .widthIs(0.1);
        self.tagLb.sd_cornerRadius = @2;
        
    }
    
    
}


- (void)setFrame:(CGRect)frame{
    CGFloat height = frame.size.height - 0.5;
    CGFloat width = frame.size.width;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    frame = CGRectMake(x, y, width, height);
    [super setFrame:frame];
}

@end
