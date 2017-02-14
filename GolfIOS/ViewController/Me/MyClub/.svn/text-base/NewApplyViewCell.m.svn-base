//
//  NewApplyViewCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "NewApplyViewCell.h"

@interface NewApplyViewCell ()
/** 头像*/
@property(nonatomic,strong) UIImageView *iconView;
/** 等级视图*/
@property(nonatomic,strong) UIImageView *levelView;
/** 昵称*/
@property(nonatomic,strong) UILabel *nameLabel;
/** 差点*/
@property (nonatomic, copy) UILabel *handicapLabel;
/** 杆数*/
@property (nonatomic, copy) UILabel *toalBarLabel;
/** 性别*/
@property(nonatomic,strong) UILabel *sexLabel;
@end


@implementation NewApplyViewCell

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

-(void)setCellModel:(MyClubNewJoinListModel *)cellModel{
    _cellModel = cellModel;
    
    //设置数据
    //头像
    [self.iconView sd_setImageWithURL:FULLIMGURL(cellModel.headUrl) placeholderImage:Placeholder_small];
    //用户昵称
    self.nameLabel.text = !cellModel.nickname ? @"未知昵称" : cellModel.nickname;;
    //用户等级图标
    NSString *gradeName = [NSString stringWithFormat:@"%@",cellModel.gradeName];
    UIImage *gradeImage;
    if ([gradeName isEqualToString:@"男爵"]) {
         gradeImage = [UIImage imageNamed:@"classify148"];
    }else if([gradeName isEqualToString:@"子爵"]){
        gradeImage = [UIImage imageNamed:@"classify149"];
    }else if([gradeName isEqualToString:@"伯爵"]){
        gradeImage = [UIImage imageNamed:@"classify150"];
    }else if([gradeName isEqualToString:@"侯爵"]){
        gradeImage = [UIImage imageNamed:@"classify151"];
    }else if([gradeName isEqualToString:@"公爵"]){
        gradeImage = [UIImage imageNamed:@"classify152"];
    }else{
        gradeImage = [UIImage imageNamed:@"classify148"];
    }
    self.levelView.image = gradeImage;
    
    //用户性别 sex字段 性别：0-保密，1-男，2-女 @mock=0
    if ([cellModel.sex isEqualToString:@"0"]) {
        self.sexLabel.text = @"性别：保密";
    }else if([cellModel.sex isEqualToString:@"1"]){
        self.sexLabel.text = @"性别：男";
    }else if([cellModel.sex isEqualToString:@"2"]){
        self.sexLabel.text = @"性别：女";
    }else{
        self.sexLabel.text = @"性别：保密";
    }
    
    //差点
    self.handicapLabel.text = !cellModel.handicap ? @"差点：0" : cellModel.handicap;
    //杆数
    self.toalBarLabel.text = !cellModel.toalBar? @"杆数：0" : cellModel.toalBar;
    
    
}

//初始化view
-(void)setUI{
    
    self.contentView.backgroundColor = WHITECOLOR;
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.levelView];
    [self.contentView addSubview:self.toalBarLabel];
    [self.contentView addSubview:self.sexLabel];
    [self.contentView addSubview:self.handicapLabel];
    
    
    
    //布局
    self.iconView.sd_layout
    .topSpaceToView(self.contentView,13)
    .leftSpaceToView(self.contentView,15)
    .widthIs(43)
    .heightIs(43);
    self.iconView.sd_cornerRadius = @3;
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(self.iconView,6)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.levelView.sd_layout
    .topSpaceToView(self.contentView,20)
    .leftSpaceToView(self.nameLabel,6)
    .widthIs(38)
    .heightIs(10);
    
    self.toalBarLabel.sd_layout
    .topSpaceToView(self.nameLabel,7)
    .leftSpaceToView(self.iconView,6)
    .autoHeightRatio(0);
    [self.toalBarLabel setSingleLineAutoResizeWithMaxWidth:50];
    [self.toalBarLabel setMaxNumberOfLinesToShow:1];
    
    self.handicapLabel.sd_layout
    .topSpaceToView(self.nameLabel,7)
    .leftSpaceToView(self.toalBarLabel,6);
    [self.handicapLabel setMaxNumberOfLinesToShow:1];
    [self.handicapLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    self.sexLabel.sd_layout
    .topSpaceToView(self.nameLabel,7)
    .leftSpaceToView(self.handicapLabel,6)
    .rightSpaceToView(self.contentView,50)
    .autoHeightRatio(0);
    [self.sexLabel setMaxNumberOfLinesToShow:1];
    [self.handicapLabel setSingleLineAutoResizeWithMaxWidth:50];

    [self setupAutoHeightWithBottomView:self.sexLabel bottomMargin:15];
}

#pragma mark - 懒加载
-(UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"classify4"];
    }
    return _iconView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"小红红";//需要赋值，先写死
        _nameLabel.font = FONT(12);
        [_nameLabel setTextColor:[UIColor darkGrayColor]];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
-(UIImageView *)levelView{
    if (!_levelView) {
        _levelView = [[UIImageView alloc] init];
        _levelView.image = [UIImage imageNamed:@"classify148"];
    }
    return _levelView;
}

-(UILabel *)handicapLabel{
    if (!_handicapLabel) {
        _handicapLabel = [[UILabel alloc] init];
        _handicapLabel.text = @"差点：72";//需要赋值，先写死
        _handicapLabel.font = FONT(12);
        [_handicapLabel setTextColor:LIGHTTEXTCOLOR];
        _handicapLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _handicapLabel;
}

-(UILabel *)toalBarLabel{
    if (!_toalBarLabel) {
        _toalBarLabel = [[UILabel alloc] init];
        _toalBarLabel.text = @"杆数：5";//需要赋值，先写死
        _toalBarLabel.font = FONT(12);
        [_toalBarLabel setTextColor:LIGHTTEXTCOLOR];
        _toalBarLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _toalBarLabel;
}

-(UILabel *)sexLabel{
    if (!_sexLabel) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"性别：男";//需要赋值，先写死
        _sexLabel.font = FONT(12);
        [_sexLabel setTextColor:LIGHTTEXTCOLOR];
        _sexLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sexLabel;
}

@end
