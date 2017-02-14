//
//  MyClubViewCell.m
//  GolfIOS
//
//  Created by mac mini on 16/11/14.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "MyClubViewCell.h"

@interface MyClubViewCell ()
/** 活动图片*/
@property (nonatomic, weak) UIImageView* iconView;
/** 活动介绍*/
@property (nonatomic, weak) UILabel* nameLabel;
/** 按钮*/
@property (nonatomic, weak) UIButton* cellButton;
/** 俱乐部id*/
@property (nonatomic, copy) NSString *clubId;


@end

@implementation MyClubViewCell

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

-(void)setPageColumn:(NSUInteger)pageColumn{
    _pageColumn = pageColumn;

    
    if (_pageColumn == 0) {
        [self.cellButton setTitle:@"退出" forState:UIControlStateNormal];//加入的俱乐部
    }else{
        [self.cellButton setTitle:@"解散" forState:UIControlStateNormal];//创建的俱乐部
    }
}


-(void)setModel:(MyClubItemModel *)model{
    _model = model;
    self.nameLabel.text = model.clubName;
    [self.iconView sd_setImageWithURL:FULLIMGURL(model.logoUrl) placeholderImage:Placeholder_small];
    self.clubId = model.clubId;
    
}

//初始化UI
-(void)setUI{
    
    //图片
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = Placeholder_small;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //介绍
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = FONT(13);
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //按钮
    UIButton *cellButton = [[UIButton alloc] init];
    [cellButton setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
    cellButton.titleLabel.font = FONT(10);
    cellButton.layer.borderColor = GLOBALCOLOR.CGColor;
    [cellButton.layer setMasksToBounds:YES];
    [cellButton.layer setCornerRadius:11];
    [cellButton.layer setBorderWidth:0.5];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0.000,0.537,0.506,1});
    [cellButton.layer setBorderColor:colorref];
    [self.contentView addSubview:cellButton];
    
    [cellButton addTarget:self action:@selector(cellButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cellButton = cellButton;
    
    
    
    //约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(13);
        make.left.offset(15);
        make.bottom.offset(-13);
        make.width.offset(43);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.centerY.equalTo(self.iconView);
    }];
    [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconView);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.offset(22);
        make.width.offset(47);
    }];
    
}


#pragma markk - 点击事件
-(void)cellButtonClick{
    
    NSInteger VcTag = (_pageColumn == 0) ? 0 : 1;
    if ([self.delegate respondsToSelector:@selector(MyClubViewCell:btnDidClickWithClubId:btnTag:)]) {
        [self.delegate MyClubViewCell:self btnDidClickWithClubId:self.clubId btnTag:VcTag];
    }

}

@end
