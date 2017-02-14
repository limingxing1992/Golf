//
//  MyMessageSysMsgCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageSysMsgCell.h"

@interface MyMessageSysMsgCell ()
/** 昵称*/
@property (nonatomic, strong) UILabel* nameLabel;
/** 创建时间*/
@property (nonatomic, strong) UILabel* timeLabel;
/** 内容*/
@property (nonatomic, strong) UILabel* MsgLabel;
/** 判断是否已读*/
@property (nonatomic, assign)   BOOL flag;
@end

@implementation MyMessageSysMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

//初始化UI
-(void)setUI{
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.MsgLabel];
    
    
    //约束
    
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView,15)
    .leftSpaceToView(self.contentView,15)
     .autoHeightRatio(0);
    [self.nameLabel setMaxNumberOfLinesToShow:1];
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.nameLabel,6)
    .leftSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    [self.timeLabel setMaxNumberOfLinesToShow:1];
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];

    self.MsgLabel.sd_layout
    .topSpaceToView(self.timeLabel,15)
    .leftSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    [self.MsgLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    [self setupAutoHeightWithBottomView:self.MsgLabel bottomMargin:18];
    
}

-(void)setSysModel:(MyMessageSysModel *)sysModel{
    _sysModel = sysModel;
    self.timeLabel.text = sysModel.pushTime;
    self.MsgLabel.text = sysModel.content;
    
    [self resetContent];
}


//自适应计算间距
- (void)resetContent{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.MsgLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 30;  //最大的行高
    paragraphStyle.lineSpacing = 8;  //行自定义行高度
    //[paragraphStyle setFirstLineHeadIndent:5];//首行缩进 根据用户昵称宽度在加5个像素
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.MsgLabel.text.length)];
    self.MsgLabel.attributedText = attributedString;
    [self.MsgLabel sizeToFit];
}


#pragma mark - 懒加载控件

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = SHENTEXTCOLOR;
        _nameLabel.font = FONT(15);
        _nameLabel.text = @"系统消息";
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = LIGHTTEXTCOLOR;
        _timeLabel.font = FONT(11);
        _timeLabel.text = @"45分钟前";
    }
    return _timeLabel;
}
-(UILabel *)MsgLabel{
    if (!_MsgLabel) {
        _MsgLabel = [[UILabel alloc] init];
        _MsgLabel.textColor = SHENTEXTCOLOR;
        _MsgLabel.font = FONT(15);
        _MsgLabel.text = @"这是一条测试数据的内容";
        _MsgLabel.numberOfLines = 0;
//        [_MsgLabel sizeToFit];
    }
    return _MsgLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
