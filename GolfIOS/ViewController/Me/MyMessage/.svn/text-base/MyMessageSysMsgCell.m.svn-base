//
//  MyMessageSysMsgCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageSysMsgCell.h"

@interface MyMessageSysMsgCell ()

/**
 * 红点
 */
@property (nonatomic, strong) UIImageView* iconView;

/**
 * 昵称
 */
@property (nonatomic, strong) UILabel* nameLabel;
/**
 * 创建时间
 */
@property (nonatomic, strong) UILabel* timeLabel;
/**
 * 内容
 */
@property (nonatomic, strong) UILabel* MsgLabel;
/**
 * 判断是否已读
 */
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
    
    //图片
    [self.contentView addSubview:self.iconView];
    //昵称
    [self.contentView addSubview:self.nameLabel];
    //时间
    [self.contentView addSubview:self.timeLabel];
    //关注我
    [self.contentView addSubview:self.MsgLabel];
    
    
    //约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(18);
        make.left.offset(15);
        make.height.width.offset(6);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
    }];
    
    [self.MsgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(17);
        make.left.equalTo(self.nameLabel);
        make.right.offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
    }];
    
}



#pragma mark - 懒加载控件
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"classify43"];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = SHENTEXTCOLOR;
        _nameLabel.font = FONT(15);
        _nameLabel.text = @"交易消息";
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
        _MsgLabel.text = @"就会告诉大家更多不大会介绍的国家圣诞节行风对轻微的到长沙大答复按时到敬爱个地方刷卡登记卡活动分公司本地拉起更多亮点查了早上收到过拉起更多乐趣啊按时到北京安山东干大手大脚咖喱介绍的过来大家好大家速度感就会告诉大家更多不大会介绍的国家圣诞节行风对轻微的到长沙大答复按时到敬爱个地方刷卡登记卡活动分公司本地拉起更多亮点查了早上收到过拉起更多乐趣啊按时到北京安山东干大手大脚咖喱介绍的过来大家好大家速度感";
        _MsgLabel.numberOfLines = 0;
        _MsgLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //自动折行设置
        [_MsgLabel sizeToFit];
    }
    return _MsgLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
