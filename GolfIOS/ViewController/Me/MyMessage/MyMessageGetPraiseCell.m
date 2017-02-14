//
//  MyMessageGetPraiseCell.m
//  GolfIOS
//
//  Created by wyao on 16/12/9.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageGetPraiseCell.h"
@interface MyMessageGetPraiseCell ()
/**头像*/
@property (nonatomic, strong) UIImageView *icon;
/**名字*/
@property (nonatomic, strong) UILabel *nameLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**内容*/
@property (nonatomic, strong) UILabel *contentLabel;
/**图片视图*/
@property (nonatomic, strong) UIView *bgView;

/**我的头像*/
@property (nonatomic, strong) UIImageView *myIcon;
/**我的名字*/
@property (nonatomic, strong) UILabel *myNameLabel;
/**我的文章*/
@property (nonatomic, strong) UILabel *myContentLabel;

@end

@implementation MyMessageGetPraiseCell
static  NSInteger const kMaxLines = 3;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.contentView.backgroundColor = WHITECOLOR;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.bgView];
    
    //我的视图
    [self.bgView addSubview:self.myIcon];
    [self.bgView addSubview:self.myNameLabel];
    [self.bgView addSubview:self.myContentLabel];

    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 13)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(38)
    .heightIs(38);
    self.icon.sd_cornerRadius = @19;
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView , 18)
    .leftSpaceToView(self.icon,10)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.nameLabel, 8)
    .leftSpaceToView(self.icon, 10)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.timeLabel, 13)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    [self.contentLabel setMaxNumberOfLinesToShow:kMaxLines];
    
    self.bgView.sd_layout
    .topSpaceToView(self.contentLabel,13)
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15);
    self.bgView.sd_cornerRadius = @3;
    
    self.myIcon.sd_layout
    .topSpaceToView(self.bgView,0)
    .leftSpaceToView(self.bgView,0)
    .heightIs(58)
    .widthIs(58);
    self.myIcon.sd_cornerRadius = @3;
    
    self.myNameLabel.sd_layout
    .topSpaceToView(self.bgView, 10)
    .leftSpaceToView(self.myIcon ,10)
    .autoHeightRatio(0);
    [self.myNameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    self.myContentLabel.sd_layout
    .topSpaceToView(self.myNameLabel,10)
    .leftSpaceToView(self.myIcon,10)
    .autoHeightRatio(0);
    [self.myContentLabel setSingleLineAutoResizeWithMaxWidth:270];
    [self.myContentLabel setMaxNumberOfLinesToShow:1];
    [self.bgView setupAutoHeightWithBottomView:self.myContentLabel bottomMargin:13];
    

    [self setupAutoHeightWithBottomView:self.bgView bottomMargin:13];
    //test
    self.nameLabel.text = @"不请自来的逗逼";
    self.timeLabel.text = @"2016-10-11 11：00";
    self.contentLabel.text = @"新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！";
    self.myNameLabel.text = @"风中有座雨做的云";
    self.myContentLabel.text = @"不转不是中国人系列之世界最美的十句话之你为什么这么穷啊";
    
}
#pragma mark - 懒加载视图

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
        _nameLabel.font = FONT(15);
        _nameLabel.textColor = BLACKTEXTCOLOR;
        _nameLabel.userInteractionEnabled = YES;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(10);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(15);
        _contentLabel.textColor = BLACKTEXTCOLOR;
    }
    return _contentLabel;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = BACKGROUNDCOLOR;
    }
    return _bgView;
}

- (UIImageView *)myIcon{
    if (_myIcon == nil) {
        _myIcon = [[UIImageView alloc] init];
        _myIcon.backgroundColor = [UIColor orangeColor];
    }
    return _myIcon;
}
- (UILabel *)myNameLabel{
    if (_myNameLabel == nil) {
        _myNameLabel = [[UILabel alloc] init];
        _myNameLabel.font = FONT(15);
        _myNameLabel.textColor = GLOBALCOLOR;
        _myNameLabel.userInteractionEnabled = NO;
    }
    return _myNameLabel;
}
- (UILabel *)myContentLabel{
    if (_myContentLabel == nil) {
        _myContentLabel = [[UILabel alloc] init];
        _myContentLabel.font = FONT(15);
        _myContentLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _myContentLabel;
}

@end
