//
//  TSOPersonalScoreHeadCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOPersonalScoreHeadCell.h"

@interface TSOPersonalScoreHeadCell ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**name*/
@property (nonatomic, strong) UILabel *nameLabel;
/**平均杆*/
@property (nonatomic, strong) UILabel *averageLabel;
///**lineView*/
//@property (nonatomic, strong) UIView *lineView;
///**场次*/
//@property (nonatomic, strong) UILabel *roundTitleLabel;
///**场次*/
//@property (nonatomic, strong) UILabel *roundLabel;
///**抓鸟*/
//@property (nonatomic, strong) UILabel *birdTitleLabel;
///**zhuaniao*/
//@property (nonatomic, strong) UILabel *birdLabel;

@end

@implementation TSOPersonalScoreHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.averageLabel];
//    [self.contentView addSubview:self.lineView];
//    [self.contentView addSubview:self.roundTitleLabel];
//    [self.contentView addSubview:self.roundLabel];
//    [self.contentView addSubview:self.birdTitleLabel];
//    [self.contentView addSubview:self.birdLabel];
    
    self.icon.sd_layout
    .topSpaceToView(self.contentView, 20)
    .leftSpaceToView(self.contentView,15)
    .widthIs(42)
    .heightIs(42);
    self.icon.sd_cornerRadius = @21;
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.icon, 10)
    .topEqualToView(self.icon)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.averageLabel.sd_layout
    .leftSpaceToView(self.icon, 10)
    .bottomEqualToView(self.icon)
    .autoHeightRatio(0);
    [self.averageLabel setSingleLineAutoResizeWithMaxWidth:200];
    
//    self.lineView.sd_layout
//    .topSpaceToView(self.icon, 10)
//    .leftEqualToView(self.contentView)
//    .rightEqualToView(self.contentView)
//    .heightIs(0.5);
//    
//    self.roundLabel.sd_layout
//    .topSpaceToView(self.lineView, 15)
//    .centerXIs(SCREEN_WIDTH * 0.25)
//    .autoHeightRatio(0);
//    [self.roundLabel setSingleLineAutoResizeWithMaxWidth:100];
//    
//    self.roundTitleLabel.sd_layout
//    .topSpaceToView(self.roundLabel, 10)
//    .centerXEqualToView(self.roundLabel)
//    .autoHeightRatio(0);
//    [self.roundTitleLabel setSingleLineAutoResizeWithMaxWidth:100];
//    
//    self.birdLabel.sd_layout
//    .topSpaceToView(self.lineView, 15)
//    .centerXIs(SCREEN_WIDTH * 0.75)
//    .autoHeightRatio(0);
//    [self.birdLabel setSingleLineAutoResizeWithMaxWidth:100];
//    
//    self.birdTitleLabel.sd_layout
//    .topSpaceToView(self.birdLabel, 10)
//    .centerXEqualToView(self.birdLabel)
//    .autoHeightRatio(0);
//    [self.birdTitleLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    [self setupAutoHeightWithBottomView:self.averageLabel bottomMargin:20];

    [self.icon sd_setImageWithURL:FULLIMGURL([UserModel sharedUserModel].headUrl) placeholderImage:Placeholder_small];
    self.nameLabel.text = [UserModel sharedUserModel].nickName;
    if (self.averageStr) {
        self.averageLabel.text = [NSString stringWithFormat:@"%@杆 最佳成绩",self.averageStr];
    }else{
        self.averageLabel.text = @"暂无记录";
    }
    
//    self.averageLabel.text = @"83杆 最大杆数";
//    self.roundLabel.text = @"3";
//    self.birdLabel.text = @"23";
    
}

#pragma mark - Setter&Getter

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(14);
        _nameLabel.textColor = BLACKCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)averageLabel{
    if (_averageLabel == nil) {
        _averageLabel = [[UILabel alloc] init];
        _averageLabel.font = FONT(14);
        _averageLabel.textColor = SHENTEXTCOLOR;
    }
    return _averageLabel;
}

//- (UIView *)lineView{
//    if (_lineView == nil) {
//        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor = BACKGROUNDCOLOR;
//        _lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
//    }
//    return _lineView;
//}
//- (UILabel *)roundLabel{
//    if (_roundLabel == nil) {
//        _roundLabel = [[UILabel alloc] init];
//        _roundLabel.font = FONT(10);
//        _roundLabel.textColor = GLOBALCOLOR;
//    }
//    return _roundLabel;
//}
//
//- (UILabel *)roundTitleLabel{
//    if (_roundTitleLabel == nil) {
//        _roundTitleLabel = [[UILabel alloc] init];
//        _roundTitleLabel.font = FONT(10);
//        _roundTitleLabel.textColor = SHENTEXTCOLOR;
//        _roundTitleLabel.text = @"场次（次）";
//    }
//    return _roundTitleLabel;
//}
//
//- (UILabel *)birdLabel{
//    if (_birdLabel == nil) {
//        _birdLabel = [[UILabel alloc] init];
//        _birdLabel.font = FONT(10);
//        _birdLabel.textColor = GLOBALCOLOR;
//    }
//    return _birdLabel;
//    
//}
//
//- (UILabel *)birdTitleLabel{
//    if (_birdTitleLabel == nil) {
//        _birdTitleLabel = [[UILabel alloc] init];
//        _birdTitleLabel.font = FONT(10);
//        _birdTitleLabel.textColor = SHENTEXTCOLOR;
//        _birdTitleLabel.text = @"抓鸟（次）";
//    }
//    return _birdTitleLabel;
//}



@end
