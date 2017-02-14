//
//  TSOUserPublishedTopicCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/7.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOUserPublishedTopicCell.h"
#import "YB_ToolBtn.h"
#import "CommunityArticleModel.h"
#import "SDPhotoBrowser.h"

@interface TSOUserPublishedTopicCell ()<SDPhotoBrowserDelegate>

/**日Label*/
@property (nonatomic, strong) UILabel *dayLabel;
/**content*/
@property (nonatomic, strong) UILabel *contentLabel;
/**月*/
@property (nonatomic, strong) UILabel *monthLabel;
/**图片视图*/
@property (nonatomic, strong) UIView *picView;


/**图片数组*/
@property (nonatomic, strong) NSArray *picPathStringsArray;
/**占位图片数组*/
@property (nonatomic, strong) NSArray *imageViewsArray;

/**点赞*/
@property (nonatomic, strong) YB_ToolBtn *loveBtn;
/**评论*/
@property (nonatomic, strong) YB_ToolBtn *commentBtn;
@end


//static  NSInteger const kMaxLines = 3;
#define kPicWidth (SCREEN_WIDTH - 47 - 15 - 5 - 5 - 5) / 3

@implementation TSOUserPublishedTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.dayLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.monthLabel];
    [self.contentView addSubview:self.picView];
    [self.contentView addSubview:self.loveBtn];
    [self.contentView addSubview:self.commentBtn];
    
    self.dayLabel.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0)
    .widthIs(27);
    
    
    self.contentLabel.sd_layout
    .topEqualToView(self.dayLabel)
    .leftSpaceToView(self.dayLabel, 10)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - self.dayLabel.mj_w - 40];
    
    self.monthLabel.sd_layout
    .topSpaceToView(self.dayLabel, 10)
    .centerXEqualToView(self.dayLabel)
    .autoHeightRatio(0);
    [self.monthLabel setSingleLineAutoResizeWithMaxWidth:50];
    
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
    .leftEqualToView(self.contentLabel)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(1);//test
    
    self.loveBtn.sd_layout
    .topSpaceToView(self.picView, 15)
    .leftSpaceToView(self.contentView, 50)
    .widthIs(30)
    .heightIs(22);
    
    self.commentBtn.sd_layout
    .topEqualToView(self.loveBtn)
    .leftSpaceToView(self.loveBtn, 15)
    .widthIs(30)
    .heightIs(22);
    
    [self setupAutoHeightWithBottomView:self.commentBtn bottomMargin:15];
    
    //test
    self.dayLabel.text = @"33";
    self.monthLabel.text = @"15月";
    self.contentLabel.text = @"一边为受挫的队员愤愤不平，有的记者(Reporter)眼睛也稍稍有些潮湿，这是一个怎样令人心痛而无奈的夜啊，整个球场(Court)是此时最好的见证。与其让生命生锈，不如生命发光发热";
    
}

- (void)setModel:(CommunityArticle *)model{
    _model = model;
    NSDate *date = [NSDate dateWithString:model.createTime];
    self.dayLabel.text = [NSString stringWithFormat:@"%zd",[NSDate day:date]];
    self.monthLabel.text = [NSString stringWithFormat:@"%zd月",[NSDate month:date]];
    self.contentLabel.text = model.content;
    [self setImgView:model.imgList];
}

- (void)setImgView:(NSArray *)array{
    _picPathStringsArray = array;
    
    
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.picView.height = 0;
        self.picView.fixedHeight = @(0);
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
        
        
        [imageView sd_setImageWithURL:FULLIMGURL([NSURL URLWithString:obj]) placeholderImage:Placeholder_middle];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);

    }
    
    
    CGFloat rowsCount = [self rowsCount:_picPathStringsArray.count];
    CGFloat height = kPicWidth  * rowsCount + margin *(rowsCount - 1);
    self.picView.sd_resetLayout
    .topSpaceToView(self.contentLabel, 10)
    .leftEqualToView(self.contentLabel)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(height);
    
}

- (long)rowsCount:(long)picCount{
    
    long rowsCount = picCount/3;
    
    if (picCount%3 > 0) {
        rowsCount ++;
    }
    return rowsCount;
}


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

#pragma mark - Setter&Getter

- (UILabel *)dayLabel
{
    if (_dayLabel == nil) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.font = FONT(16);
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        _contentLabel= [[UILabel alloc] init];
        _contentLabel.font = FONT(14);
        _contentLabel.textColor = SHENTEXTCOLOR;
    }
    return _contentLabel;
}

- (UILabel *)monthLabel{
    if (_monthLabel == nil) {
        _monthLabel = [[UILabel alloc] init];
        _monthLabel.font = FONT(10);
        _monthLabel.textColor = SHENTEXTCOLOR;
    }
    return _monthLabel;
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
    }
    return _loveBtn;
}
- (YB_ToolBtn *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [YB_ToolBtn commentButton];
    }
    return _commentBtn;
}

- (NSArray *)picPathStringsArray{
    if (_picPathStringsArray == nil) {
        _picPathStringsArray = [[NSArray alloc] init];
    }
    return _picPathStringsArray;
}

@end
