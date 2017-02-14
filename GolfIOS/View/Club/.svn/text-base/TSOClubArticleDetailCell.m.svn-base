//
//  TSOClubArticleDetailCell.m
//  GolfIOS
//
//  Created by yangbin on 16/12/23.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOClubArticleDetailCell.h"
#import "SDPhotoBrowser.h"
#import "ClubArticle.h"

@interface TSOClubArticleDetailCell ()
<SDPhotoBrowserDelegate>
/**contentLabel*/
@property (nonatomic, strong) UILabel *contentLabel;
/**图片视图*/
@property (nonatomic, strong) UIView *picView;
/**图片数组*/
@property (nonatomic, strong) NSArray *picPathStringsArray;

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation TSOClubArticleDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.picView];

    self.contentLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
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
    
    [self setupAutoHeightWithBottomView:self.picView bottomMargin:15];
    
}

- (void)setModel:(ClubArticle *)model{
    _model = model;

    self.contentLabel.text = model.contentDetail;

    [self setImgView:model.imgList];
    
   
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
    
    CGFloat itemW = SCREEN_WIDTH - 30;
    CGFloat itemH = itemW * 0.618;
    

    for (NSInteger idx = 0; idx < _picPathStringsArray.count; idx ++) {
     
        NSString *obj = _picPathStringsArray[idx];
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        
        [imageView sd_setImageWithURL:FULLIMGURL([NSURL URLWithString:obj]) placeholderImage:Placeholder_middle];
        //        NSLog(@"%@-------------",FULLIMGURL([NSURL URLWithString:obj]));
        imageView.frame = CGRectMake(0, idx *(itemH + 15) , itemW, itemH);
    }
    
    CGFloat height = _picPathStringsArray.count * itemH + (_picPathStringsArray.count - 1) *15;
    self.picView.sd_resetLayout
    .topSpaceToView(self.contentLabel, 10)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .heightIs(height);
    
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

//MARK: - Setter&Getter

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = SHENTEXTCOLOR;
        _contentLabel.font = FONT(12);
    }
    return _contentLabel;
}


- (UIView *)picView{
    if (_picView == nil) {
        _picView = [[UIView alloc] init];
    }
    return _picView;
}

- (NSArray *)picPathStringsArray{
    if (_picPathStringsArray == nil) {
        _picPathStringsArray = [[NSArray alloc] init];
    }
    return _picPathStringsArray;
}




@end
