//
//  ClubDetailViewCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubDetailViewCell.h"

@interface MyClubDetailViewCell ()
/** 图标*/
@property(nonatomic,strong) UIImageView *iconView;
/** 标题*/
@property(nonatomic,strong) UILabel *nameLabel;
/** 创建时间*/
@property(nonatomic,strong) UILabel *createdTimeLabel;
///** 介绍*/
@property(nonatomic,strong) UILabel *introductionLabel;
@end

@implementation MyClubDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = WHITECOLOR;
    
    //添加子控件
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.createdTimeLabel];
    [self.contentView addSubview:self.introductionLabel];
    
}



-(void)setIntroduction:(NSString *)introduction{
    _introduction = introduction;
    if (_introduction != nil) {
        self.introductionLabel.text = _introduction;
        //NSLog(@"cell获取到的数据,%@",_introduction);
        [self.iconView setHidden:YES];
        [self.nameLabel setHidden:YES];
        [self.createdTimeLabel setHidden:YES];
        
        [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        self.introductionLabel.sd_layout
        .topSpaceToView(self.contentView,15)
        .leftSpaceToView(self.contentView,15);
        
        [self setupAutoHeightWithBottomView:self.introductionLabel bottomMargin:13];
        
        [self layoutIfNeeded];
        [self updateLayout];
    }
}


-(void)setHistoryModel:(MyClubHistoryArcticleItemModel *)historyModel{
    _historyModel = historyModel;
    self.nameLabel.text = historyModel.title;
    [self.iconView sd_setImageWithURL:FULLIMGURL(historyModel.logoUrl) placeholderImage:Placeholder_small];
    self.createdTimeLabel.text = historyModel.createTime;
    
    
    //布局
    self.iconView.sd_layout
    .topSpaceToView(self.contentView,12)
    .leftSpaceToView(self.contentView,15)
    .heightIs(75)
    .widthIs(75);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView ,12)
    .leftSpaceToView(self.iconView ,15)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 100];
    [self.nameLabel setMaxNumberOfLinesToShow:3];
    
    self.createdTimeLabel.sd_layout
    .bottomSpaceToView(self.contentView ,18)
    .leftSpaceToView(self.iconView ,15)
    .autoHeightRatio(0);
    [self.createdTimeLabel setMaxNumberOfLinesToShow:1];
    [self.createdTimeLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 100];
    
    [self setupAutoHeightWithBottomView:self.createdTimeLabel bottomMargin:18];

   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 控件懒加载
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
        _nameLabel.text = @"俱乐部新成员招募，快来参加";//需要赋值，先写死
        _nameLabel.font = FONT(14);
        [_nameLabel setTextColor:SHENTEXTCOLOR];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

-(UILabel *)createdTimeLabel{
    if (!_createdTimeLabel) {
        _createdTimeLabel = [[UILabel alloc] init];
        _createdTimeLabel.text = @"2016-11-14";//需要赋值，先写死
        _createdTimeLabel.font = FONT(14);
        [_createdTimeLabel setTextColor:SHENTEXTCOLOR];
        _createdTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _createdTimeLabel;
}
-(UILabel *)introductionLabel{
    if (!_introductionLabel) {
        _introductionLabel = [[UILabel alloc] init];
        _introductionLabel.font = FONT(13);
        _introductionLabel.numberOfLines = 0;
        _introductionLabel.text = @"我睡是多大按时抵达达到大道路口见打电话打得好快打得好快大红大老鼠大声回答客户收到打卡记录等哈看类似的话";
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.textColor = SHENTEXTCOLOR;
        //设置行间距
       // [UILabel changeLineSpaceForLabel:_introductionLabel WithSpace:5];

    }
    return _introductionLabel;
}


@end
