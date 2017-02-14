//
//  MyMessageHomeCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageHomeCell.h"

@interface MyMessageHomeCell ()
/**
 *点击事件回调的block
 */
@property(nonatomic,copy) void(^clickBlock)();
/**
 * 头像
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
 * 关注了我
 */
@property (nonatomic, strong) UILabel* focusLabel;
/**
 * 按钮
 */
@property (nonatomic, strong) UIButton* cellButton;
/**
 * 判断是否关注
 */
@property (nonatomic, assign)   BOOL Focusflag;
@end

@implementation MyMessageHomeCell

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
    // NSLog(@"初始化cell的UI");
    
    
    //图片
    [self.contentView addSubview:self.iconView];
    //昵称
    [self.contentView addSubview:self.nameLabel];
    //时间
    [self.contentView addSubview:self.timeLabel];
    //关注我
    [self.contentView addSubview:self.focusLabel];
    //按钮
    [self.contentView addSubview:self.cellButton];
    
    //点击事件
    [_cellButton handelWithBlock:^{
        
        _Focusflag = !_Focusflag;
        if (_Focusflag) {
            _cellButton =  [_cellButton buttonWithTitle:@"已关注" TitleColor:LIGHTTEXTCOLOR TitleFont:FONT(10) BorderColor:LIGHTTEXTCOLOR CornerRadius:12];
                NSLog(@"已关注");
        }else{
          _cellButton = [_cellButton buttonWithTitle:@"关注TA" TitleColor:GLOBALCOLOR TitleFont:FONT(10) BorderColor:GLOBALCOLOR CornerRadius:12];
            NSLog(@"关注TA");
        }
    }];
    
    
    
    //约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(12);
        make.height.width.offset(43);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(8);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    [self.focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
    }];
    
    [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-12);
        make.height.offset(23);
        make.width.offset(58);
    }];
    
}


-(void)cellButtonClick:(UIButton*)sender{
    NSLog(@"点击了按键");
    if (self.clickBlock != nil) {
        self.clickBlock();
    }
}

#pragma mark - 懒加载控件
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"classify19"];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = SHENTEXTCOLOR;
        _nameLabel.font = FONT(14);
        _nameLabel.text = @"火山少女biubiu";
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = SHENTEXTCOLOR;
        _timeLabel.font = FONT(12);
        _timeLabel.text = @"2016-10-11 11:00";
    }
    return _timeLabel;
}
-(UILabel *)focusLabel{
    if (!_focusLabel) {
        _focusLabel = [[UILabel alloc] init];
        _focusLabel.textColor = LIGHTTEXTCOLOR;
        _focusLabel.font = FONT(14);
        _focusLabel.text = @"关注了我";
    }
    return _focusLabel;
}
-(UIButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[UIButton alloc] init];
        [_cellButton buttonWithTitle:@"关注TA" TitleColor:GLOBALCOLOR TitleFont:FONT(10) BorderColor:GLOBALCOLOR CornerRadius:11];
    }
    return _cellButton;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
