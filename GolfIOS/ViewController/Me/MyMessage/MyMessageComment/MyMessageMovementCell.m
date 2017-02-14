//
//  MyMessageGetPraiseCell.m
//  GolfIOS
//
//  Created by wyao on 16/12/9.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageMovementCell.h"
@interface MyMessageMovementCell ()
/**头像*/
@property (nonatomic, strong) UIImageView *icon;
/** 昵称*/
@property (nonatomic, strong) UILabel *nickNameLabel;
/**创建时间*/
@property (nonatomic, strong) UILabel *createdTimeLabel;
/** 社区内容、公告内容、帖子内容*/
@property (nonatomic, strong) UILabel *typeContentLabel;


/*********帖子内容*******/
/**图片视图*/
@property (nonatomic, strong) UIView *bgView;
/**我的头像*/
@property (nonatomic, strong) UIImageView *myIcon;
/**我的名字*/
@property (nonatomic, strong) UILabel *myNameLabel;
/**我的文章*/
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MyMessageMovementCell
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
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.createdTimeLabel];
    [self.contentView addSubview:self.typeContentLabel];
    

    //我的视图
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.myIcon];
    [self.bgView addSubview:self.myNameLabel];
    [self.bgView addSubview:self.contentLabel];

    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 13)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(38)
    .heightIs(38);
    self.icon.sd_cornerRadius = @19;
    
    self.nickNameLabel.sd_layout
    .topSpaceToView(self.contentView , 18)
    .leftSpaceToView(self.icon,10)
    .autoHeightRatio(0);
    [self.nickNameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    self.createdTimeLabel.sd_layout
    .topSpaceToView(self.nickNameLabel, 8)
    .leftSpaceToView(self.icon, 10)
    .autoHeightRatio(0);
    [self.createdTimeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    self.typeContentLabel.sd_layout
    .topSpaceToView(self.createdTimeLabel, 13)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [self.typeContentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    [self.typeContentLabel setMaxNumberOfLinesToShow:kMaxLines];
    
    self.bgView.sd_layout
    .topSpaceToView(self.typeContentLabel,12)
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15)
    .heightIs(58 +13);
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
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.myNameLabel,10)
    .leftSpaceToView(self.myIcon,10)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:270];
    [self.contentLabel setMaxNumberOfLinesToShow:1];

    [self setupAutoHeightWithBottomView:self.bgView bottomMargin:13];
    
}

-(void)setMovementModel:(MyMessageItemModel *)MovementModel{
    _MovementModel = MovementModel;
    if (!MovementModel.type) {
        return;
    }
    
    //昵称
    self.nickNameLabel.text = !MovementModel.nickName ? @"未知名称" : MovementModel.nickName;
    //创建时间
    self.createdTimeLabel.text = !MovementModel.createTime ? @"未知时间" : MovementModel.createTime;
    //头像
    [self.icon sd_setImageWithURL:FULLIMGURL(MovementModel.headUrl) placeholderImage:Placeholder_small];
    
    //内容和标题的判断
    
    [self.bgView setHidden:NO];
    
    CGFloat height = 58+13;
    switch (MovementModel.type) {
        case 10://俱乐部帖子评论
            self.typeContentLabel.text = @"评论了这篇帖子";
            self.contentLabel.text = (!MovementModel.title || [MovementModel.title isEqualToString:@""]) ? @"暂无标题" : MovementModel.title;
            break;
        case 20://社区评论
            self.typeContentLabel.text = @"评论了这篇帖子";
            self.contentLabel.text = (!MovementModel.content || [MovementModel.content isEqualToString:@""])? @"暂无内容" : MovementModel.content;
            break;
        case 30://社区点赞
            self.typeContentLabel.text = @"赞了这篇帖子";
            self.contentLabel.text = (!MovementModel.content || [MovementModel.content isEqualToString:@""])? @"暂无内容" : MovementModel.content;
            break;
        case 40://关注我
            self.typeContentLabel.text = @"关注了我";
            height = 0.1;
        default:
            break;
    }
    
    self.bgView.sd_resetLayout
    .topSpaceToView(self.typeContentLabel,12)
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15)
    .heightIs(height);
}

#pragma mark - 懒加载视图
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
        _icon.image = Placeholder_small;
    }
    return _icon;
}

- (UILabel *)nickNameLabel{
    if (_nickNameLabel == nil) {
        _nickNameLabel= [[UILabel alloc] init];
        _nickNameLabel.font = FONT(15);
        _nickNameLabel.textColor = BLACKTEXTCOLOR;
        _nickNameLabel.userInteractionEnabled = YES;
    }
    return _nickNameLabel;
}

- (UILabel *)createdTimeLabel{
    if (_createdTimeLabel == nil) {
        _createdTimeLabel = [[UILabel alloc] init];
        _createdTimeLabel.font = FONT(10);
        _createdTimeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _createdTimeLabel;
}

- (UILabel *)typeContentLabel{
    if (_typeContentLabel == nil) {
        _typeContentLabel = [[UILabel alloc] init];
        _typeContentLabel.font = FONT(15);
        _typeContentLabel.textColor = BLACKTEXTCOLOR;
    }
    return _typeContentLabel;
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
        [_myIcon sd_setImageWithURL:FULLIMGURL([UserModel sharedUserModel].headUrl) placeholderImage:Placeholder_small];
    }
    return _myIcon;
}
- (UILabel *)myNameLabel{
    if (_myNameLabel == nil) {
        _myNameLabel = [[UILabel alloc] init];
        _myNameLabel.font = FONT(15);
        _myNameLabel.textColor = GLOBALCOLOR;
        _myNameLabel.userInteractionEnabled = NO;
        _myNameLabel.text = [UserModel sharedUserModel].nickName;
    }
    return _myNameLabel;
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(15);
        _contentLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _contentLabel;
}

@end
