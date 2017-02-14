//
//  TSOHomeCommunityTableViewCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeCommunityTableViewCell.h"
#import "YB_ToolBtn.h"
#import "SDPhotoBrowser.h"
#import "CommunityArticleModel.h"
#import "SeverStatus.h"

@interface TSOHomeCommunityTableViewCell ()
<SDPhotoBrowserDelegate>

/**分割线*/
@property (nonatomic, strong) UIView *lineView;
/**头像*/
@property (nonatomic, strong) UIImageView *icon;
/**名字*/
@property (nonatomic, strong) UILabel *nameLabel;
/**时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**关注*/
@property (nonatomic, strong) YB_FocusButton *focusBtn;
/**内容*/
@property (nonatomic, strong) UILabel *contentLabel;
/**图片视图*/
@property (nonatomic, strong) UIView *picView;
/**点赞按钮*/
@property (nonatomic, strong) YB_ToolBtn *loveBtn;
/**评论按钮*/
@property (nonatomic, strong) YB_ToolBtn *commentBtn;
/**等级图标*/
@property (nonatomic, strong) UIImageView *grandImgView;

/**图片数组*/
@property (nonatomic, strong) NSArray *picPathStringsArray;

@property (nonatomic, strong) NSArray *imageViewsArray;

@end


@implementation TSOHomeCommunityTableViewCell

static  NSInteger const kMaxLines = 3;
#define kPicWidth (SCREEN_WIDTH - 34) / 3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.focusBtn];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.picView];
    [self.contentView addSubview:self.loveBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.grandImgView];
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(42)
    .heightIs(42);
    self.icon.sd_cornerRadius = @3;
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView , 18)
    .leftSpaceToView(self.icon ,15)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 190];
    [self.nameLabel setMaxNumberOfLinesToShow:1];
    
    self.grandImgView.sd_layout
    .leftSpaceToView(self.nameLabel, 5)
    .centerYEqualToView(self.nameLabel)
    .widthIs(40)
    .heightIs(12);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.contentView, 38)
    .leftSpaceToView(self.icon, 15)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.focusBtn.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.icon)
    .widthIs(53)
    .heightIs(24);
    self.focusBtn.sd_cornerRadius = @12;
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.icon, 10)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    [self.contentLabel setMaxNumberOfLinesToShow:kMaxLines];

    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self.picView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    self.imageViewsArray = [temp copy];
    
    
    self.picView.sd_layout
    .topSpaceToView(self.contentLabel, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(0.1);
 
    self.loveBtn.sd_layout
    .topSpaceToView(self.picView, 10)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(50)
    .heightIs(20);
    
    self.commentBtn.sd_layout
    .topSpaceToView(self.picView, 10)
    .leftSpaceToView(self.loveBtn, 15)
    .widthIs(50)
    .heightIs(20);
    
    [self setupAutoHeightWithBottomView:self.commentBtn bottomMargin:15];
    
//    //test
//    self.nameLabel.text = @"老鹰球";
//    self.timeLabel.text = @"13242分钟前";
//    self.contentLabel.text = @"新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！";
//    [self.loveBtn setTitle:@"22" forState:UIControlStateNormal];
//    [self.commentBtn setTitle:@"22" forState:UIControlStateNormal];
}

- (void)setModel:(CommunityArticle *)model{
    _model = model;
    
    [self.icon sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    
    self.nameLabel.text = model.nickname;
    self.timeLabel.text = [NSDate timeLineStringWithString:model.createTime];
    self.contentLabel.text = model.content;
    [self.loveBtn setTitle:model.likedNum forState:UIControlStateNormal];
    self.loveBtn.selected = model.islike;
    self.loveBtn.tag = self.tag;
    [self.commentBtn setTitle:model.commentNum.stringValue forState:UIControlStateNormal];
    self.commentBtn.selected = model.iscomment;
    [self setImgView:model.imgList];
    
    
    self.grandImgView.image = GetLevelImg(model.sort.integerValue);

    if (model.isfollow) {
        [self.focusBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }else{
        [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    }

    //如果是本人隐藏关注按钮
    if ([model.userId.stringValue isEqualToString:[UserModel sharedUserModel].ID]) {
        self.focusBtn.hidden = YES;
    }else{
        self.focusBtn.hidden = NO;
    }
    
}

- (void)hideFocusBtn{
    self.focusBtn.hidden = YES;
}

- (void)setImgView:(NSArray *)array{
    _picPathStringsArray = array;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.picView.sd_resetLayout
        .topSpaceToView(self.contentLabel, 10)
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .heightIs(0.1);
        return;
    }
    
    CGFloat itemW = kPicWidth;
    CGFloat itemH = kPicWidth;
    
    long perRowItemCount = 3;
    CGFloat margin = 5;

    for (NSInteger idx = 0; idx < _picPathStringsArray.count; idx ++) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        NSString *obj = _picPathStringsArray[idx];
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        
        [imageView sd_setImageWithURL:FULLIMGURL([NSURL URLWithString:obj]) placeholderImage:Placeholder_middle];
//        NSLog(@"%@-------------",FULLIMGURL([NSURL URLWithString:obj]));
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }
    
    CGFloat rowsCount = [self rowsCount:_picPathStringsArray.count];
    CGFloat height = kPicWidth  * rowsCount + margin *(rowsCount - 1);
    self.picView.sd_resetLayout
    .topSpaceToView(self.contentLabel, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(height);

    
}

#pragma mark - function

- (long)rowsCount:(long)picCount{
    long rowsCount = picCount/3;
    if (picCount%3 > 0) {
        rowsCount ++;
    }
    return rowsCount;
}

#pragma mark - action

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.picView;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
    
}

- (void)commentBtnClick:(UIButton *)button{
//    button.selected = !button.selected;

    
}
- (void)loveBtnClick:(UIButton *)button{
    
    if (IsLogin) {
        [ShareBusinessManager.communityManager addCommunityLikeWithParameters:@{@"articleId":self.model.ID} success:^(id responObject) {
            button.selected = !button.selected;
            NSString *string = [NSString stringWithFormat:@"%@",responObject];
            
            NSLog(@"%@+++++++++++++%@",string,[responObject class]);
            [button setTitle:string forState:UIControlStateNormal];

        } failure:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }];
    }else{
        [STL_CommonIdea alertWithTarget:self Title:@"未登录" message:@"请登录后刷新"  action_0:nil action_1:@"知道了" block_0:^{
            
        } block_1:^{
            
        }];
    }
}

- (void)focusBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(tSOHomeCommunityTableViewCell:focusBtnDidClick:)]) {
        [self.delegate tSOHomeCommunityTableViewCell:self focusBtnDidClick:self.model.userId.stringValue];
    }
}

- (void)nameLabelDidClick{
    
    if ([self.delegate respondsToSelector:@selector(tSOHomeCommunityTableViewCell:nameLabelDidClick:)]) {
        [self.delegate tSOHomeCommunityTableViewCell:self nameLabelDidClick:self.nameLabel.text];
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.picView.subviews[index];
    return imageView.image;
}

#pragma mark - Sertter&Getter
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = GRAYCOLOR;
        _lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
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
        _nameLabel.font = FONT(15);
        _nameLabel.textColor = BLACKTEXTCOLOR;
        _nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameLabelDidClick)];
        [_nameLabel addGestureRecognizer:tap];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(14);
        _timeLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT(14);
        _contentLabel.textColor = BLACKTEXTCOLOR;
    }
    return _contentLabel;
}

- (YB_FocusButton *)focusBtn{
    if (_focusBtn == nil) {
        _focusBtn = [[YB_FocusButton alloc] init];
        [_focusBtn addTarget:self action:@selector(focusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

- (UIView *)picView{
    if (_picView == nil) {
        _picView = [[UIView alloc] init];
    }
    return _picView;
}

- (YB_ToolBtn *)loveBtn{
    if (_loveBtn == nil) {
        _loveBtn = [YB_ToolBtn loveButton];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loveBtn;
}

- (UIButton *)commentBtn{
    if (_commentBtn == nil){
        _commentBtn = [YB_ToolBtn commentButton];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}


- (NSArray *)picPathStringsArray{
    if (_picPathStringsArray == nil) {
        _picPathStringsArray = [[NSArray alloc] init];
    }
    return _picPathStringsArray;
}

- (UIImageView *)grandImgView{
    if (_grandImgView == nil) {
        _grandImgView = [[UIImageView alloc] init];
    }
    return _grandImgView;
}



@end
