//
//  MyMessageCommentCell.m
//  GolfIOS
//
//  Created by wyao on 16/11/18.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyMessageCommentCell.h"
#import "MyMessageCommentCellModel.h"

@interface MyMessageCommentCell ()


/** 评论者的头像*/
@property (nonatomic, strong) UIImageView* iconView;
/** 评论者的昵称*/
@property (nonatomic, strong) UILabel* nameLabel;
/** 创建时间 */
@property (nonatomic, strong) UILabel* timeLabel;
/** 评论者的内容*/
@property (nonatomic, strong) UILabel* contentLabel;


/*******收到的评论*********/
/** 回复按钮*/
@property (nonatomic, strong) UIButton* cellButton;

/*******发送的评论*********/
/** 回复的背景视图*/
@property (nonatomic, strong) UIView *bgView;
/** 我的名字*/
@property (nonatomic, strong) UILabel *myNameLabel;
/** 我的文章*/
@property (nonatomic, strong) UILabel *myContentLabel;


@end

@implementation MyMessageCommentCell

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
    //默认
    _flag = false;
    //图片
    [self.contentView addSubview:self.iconView];
    //昵称
    [self.contentView addSubview:self.nameLabel];
    //时间
    [self.contentView addSubview:self.timeLabel];
    //评论内容
    [self.contentView addSubview:self.contentLabel];


    //约束
    self.iconView.sd_layout
    .topSpaceToView(self.contentView, 13)
    .leftSpaceToView(self.contentView, 15)
    .widthIs(38)
    .heightIs(38);
    self.iconView.sd_cornerRadius = @19;
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView , 18)
    .leftSpaceToView(self.iconView,10)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.nameLabel, 8)
    .leftSpaceToView(self.iconView, 10)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    
    self.contentLabel.sd_layout
    .topSpaceToView(self.timeLabel, 13)
    .leftSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    [self.contentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    [self.contentLabel setMaxNumberOfLinesToShow:3];
    
}

/**
 设置数据，区分接收和发送

 @param cellModel 传入的model
 */
-(void)setCellModel:(MyMessageCommentCellModel *)cellModel{
    _cellModel = cellModel;
    
    NSString *text;
    NSString *commentString;
    
    if (_flag == false) {
        [self setGetCommentView];
         text = @"评论我的帖子：";
         commentString  = @"这个帖子不错，回复可以观看";
        //设置评论内容
        [self setContentLabelWithtext:text commentString:commentString WithColor:BLACKTEXTCOLOR];
    }else{
        [self setSendCommentView];
        //处理发出的评论的对方的label
        text = [NSString stringWithFormat:@"%@:",@"风吹蛋蛋凉"];
        commentString  = @"不转不是中国人系列之世界最美的十句话之你为什么这么穷啊不转不是中国人系列之世界最美的十句话之你为什么这么穷啊不转不是中国人系列之世界最美的十句话之你为什么这么穷啊";
        //设置评论内容
        [self setContentLabelWithtext:text commentString:commentString WithColor:GLOBALCOLOR];
    }
    
    [self layoutIfNeeded];
    [self updateLayout];
    
    //test
    
    //自己的label内容
    self.nameLabel.text = @"不请自来的逗逼";
    self.timeLabel.text = @"2016-10-11 11：00";
    self.contentLabel.text = @"新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！新天地高尔夫球不错，值得一去！";
}

/**
 设置回复label

 @param text 回复者的名字
 @param commentString 内容
 */
-(void)setContentLabelWithtext:(NSString*)text  commentString:(NSString*)commentString  WithColor:(UIColor*)color{
    
        NSString* contentString = [text stringByAppendingString:[NSString stringWithFormat:@"%@",commentString]];
        [self.myContentLabel attribute:contentString changeString:text color:color font:FONT(15)];

}

/**
 设置收到的评论的视图
 */
-(void)setGetCommentView{
    //按钮
    [self.contentView addSubview:self.cellButton];
    //评论内容
    [self.contentView addSubview:self.myContentLabel];
    
    //点击事件
    [_cellButton handelWithBlock:^{
        
        NSLog(@"回复按钮点击");
    }];
    
    //布局
    self.cellButton.sd_layout
    .topSpaceToView(self.contentView,13)
    .rightSpaceToView(self.contentView,15)
    .heightIs(24)
    .widthIs(42);
    
    self.myContentLabel.sd_layout
    .topSpaceToView(self.contentLabel,13)
    .leftSpaceToView(self.contentView,15)
    .autoHeightRatio(0);
    [self.myContentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    [self setupAutoHeightWithBottomView:self.myContentLabel bottomMargin:13];

}

/**
 收到的评论视图
 */
-(void)setSendCommentView{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.myNameLabel];
    [self.bgView addSubview:self.myContentLabel];
    
    
    self.bgView.sd_layout
    .topSpaceToView(self.contentLabel,13)
    .leftSpaceToView(self.contentView,15)
    .rightSpaceToView(self.contentView,15);
    self.bgView.sd_cornerRadius = @3;
    
    
    self.myContentLabel.sd_layout
    .topSpaceToView(self.bgView,13)
    .leftSpaceToView(self.bgView,0)
    .autoHeightRatio(0);
    [self.myContentLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 30];
    
    [self.bgView setupAutoHeightWithBottomView:self.myContentLabel bottomMargin:13];
    
    
    [self setupAutoHeightWithBottomView:self.bgView bottomMargin:13];

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
        _nameLabel.font = FONT(15);
        _nameLabel.text = @"风吹蛋蛋凉~~~~";
    }
    return _nameLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = LIGHTTEXTCOLOR;
        _timeLabel.font = FONT(12);
        _timeLabel.text = @"45分钟前";
    }
    return _timeLabel;
}
-(UIButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[UIButton alloc] init];
        [_cellButton buttonWithTitle:@"回复" TitleColor:LIGHTTEXTCOLOR TitleFont:FONT(10) BorderColor:LIGHTTEXTCOLOR CornerRadius:12];
    }
    return _cellButton;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = SHENTEXTCOLOR;
        _contentLabel.font = FONT(15);
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //自动折行设置
        [_contentLabel sizeToFit];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
