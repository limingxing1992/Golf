//
//  TSOPersonalScoreCell.m
//  GolfIOS
//
//  Created by yangbin on 16/11/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOPersonalScoreCell.h"
#import "ScoreRecordModel.h"
#import "NSDate+YB_Extension.h"
@interface TSOPersonalScoreCell ()

/**总分*/
@property (nonatomic, strong) UILabel *scoreLabel;
/**球场名称*/
@property (nonatomic, strong) UILabel *courseName;
/**比赛时间*/
@property (nonatomic, strong) UILabel *timeLabel;
/**状态信息*/
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation TSOPersonalScoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.contentView addSubview:self.scoreLabel];
    [self.contentView addSubview:self.courseName];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    
    self.scoreLabel.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 15)
    .heightIs(40)
    .widthIs(40);
    self.scoreLabel.sd_cornerRadius = @5;
    
    self.courseName.sd_layout
    .leftSpaceToView(self.scoreLabel, 10)
    .topEqualToView(self.scoreLabel)
    .autoHeightRatio(0);
    [self.courseName setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH -  90];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.scoreLabel, 10)
    .bottomEqualToView(self.scoreLabel)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.statusLabel.sd_layout
    .rightSpaceToView(self.contentView, 15)
    .centerYEqualToView(self.contentView)
    .autoHeightRatio(0);
    
    [self.statusLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    [self setupAutoHeightWithBottomView:self.timeLabel bottomMargin:15];
    
}

- (void)setModel:(ScoreRecord *)model{
    self.scoreLabel.text = model.totalBar;
    self.courseName.text = model.ballPlaceName;
    self.timeLabel.text = [NSDate timeLineStringWithString:model.createTime];
    self.statusLabel.text = model.statusName;
}

#pragma mark - Setter&Getter

- (UILabel *)scoreLabel{
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = FONT(22);
        _scoreLabel.textColor = BLACKCOLOR;
        _scoreLabel.backgroundColor = BACKGROUNDCOLOR;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _scoreLabel;
}

- (UILabel *)courseName{
    if (_courseName == nil) {
        _courseName = [[UILabel alloc] init];
        _courseName.font = FONT(14);
        _courseName.textColor = BLACKCOLOR;
        
    }
    return _courseName;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT(12);
        _timeLabel.textColor = SHENTEXTCOLOR;
    }
    return _timeLabel;
}

- (UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = LIGHTTEXTCOLOR;
        _statusLabel.font = FONT(12);
    }
    return _statusLabel;
}

@end
