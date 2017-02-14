//
//  TSOClubHeadView.m
//  GolfIOS
//
//  Created by yangbin on 16/11/9.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOClubHeadView.h"
#import "ClubIndexModel.h"

@interface TSOClubHeadView ()

/**icon*/
@property (nonatomic, strong) UIImageView *icon;
/**俱乐部名称*/
@property (nonatomic, strong) UILabel *nameLabel;
/**组员*/
@property (nonatomic, strong) UILabel *groupLabel;
/**小头像列表容器视图*/
@property (nonatomic, strong) UIView *imgListView;
/**组员数量*/
@property (nonatomic, strong) UILabel *countLabel;
/**申请加入*/
@property (nonatomic, strong) YB_FocusButton *applyBtn;

@end

@implementation TSOClubHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    [self addSubview:self.icon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.groupLabel];
    [self addSubview:self.imgListView];
    [self addSubview:self.countLabel];
    [self addSubview:self.applyBtn];
    
    self.icon.sd_layout
    .topSpaceToView(self, 18)
    .leftSpaceToView(self, 15)
    .widthIs(30)
    .heightIs(30);
   
    self.nameLabel.sd_layout
    .leftSpaceToView(self.icon, 10)
    .centerYEqualToView(self.icon)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH - 60];
    
    self.groupLabel.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self.icon, 22)
    .autoHeightRatio(0);
    [self.groupLabel setSingleLineAutoResizeWithMaxWidth:50];
    
    self.imgListView.sd_layout
    .leftSpaceToView(self.groupLabel, 10)
    .centerYEqualToView(self.groupLabel)
    .widthIs(0.1)
    .heightIs(20);//test
    
    self.countLabel.sd_layout
    .leftSpaceToView(self.imgListView, 10)
    .centerYEqualToView(self.groupLabel)
    .autoHeightRatio(0);
    [self.countLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.applyBtn.sd_layout
    .rightSpaceToView(self, 15)
    .centerYEqualToView(self.groupLabel)
    .heightIs(24)
    .widthIs(75);
    
    
   
}

- (void)nameLabelAddTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [_nameLabel addGestureRecognizer:tap];
}

- (void)applyBtnAddTarget:(id)target action:(SEL)action{
 
    [self.applyBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(ClubIndexModel *)model{
    _model = model;
    
    [self.icon sd_setImageWithURL:FULLIMGURL(_model.data.logoUrl) placeholderImage:Placeholder_small];
    self.nameLabel.text = _model.data.clubName;
    self.countLabel.text = [NSString stringWithFormat:@"%@人",_model.data. totalNum];
    [self setGroupMember];
//    0已申请 1已加入 2已拒绝 3未申请
    switch (_model.data.isjoin.integerValue) {
        case 0:
            [self.applyBtn setTitle:@"已申请" forState:UIControlStateNormal];
            break;
        case 1:
            [self.applyBtn setTitle:@"已加入" forState:UIControlStateNormal];
            break;
        default:
            [self.applyBtn setTitle:@"申请加入" forState:UIControlStateNormal];
            break;
    }
}

- (void)setGroupMember{
    NSArray *memberImgArr = self.model.data.userHeadUrlList;
    if (memberImgArr.count > 0) {
        
        int i = 0;
        for (NSURL *imgUrl in memberImgArr) {
            
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.layer.borderColor = WHITECOLOR.CGColor;
            imgView.layer.borderWidth = 1;
            imgView.layer.cornerRadius = 10;
            imgView.layer.masksToBounds = YES;
            [imgView sd_setImageWithURL:FULLIMGURL(imgUrl) placeholderImage:Placeholder_small];
            [self.imgListView addSubview:imgView];
            imgView.size = CGSizeMake(20, 20);
            imgView.frame = CGRectMake(i * 25, 0, 20, 20);
            i ++;
        }
        
        
        self.imgListView.sd_resetLayout
        .leftSpaceToView(self.groupLabel, 10)
        .centerYEqualToView(self.groupLabel)
        .widthIs(20 * memberImgArr.count + (5 * (memberImgArr.count - 1)))
        .heightIs(20);
    }
    
    
}

- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor orangeColor];
        _icon.layer.masksToBounds = YES;
        _icon.layer.borderColor = WHITECOLOR.CGColor;
        _icon.layer.borderWidth = 1;
        _icon.layer.cornerRadius = 4;
    }
    return _icon;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT(14);
        _nameLabel.textColor = WHITECOLOR;
        _nameLabel.userInteractionEnabled = YES;
    }
    return _nameLabel;
}

- (UILabel *)groupLabel{
    if (_groupLabel == nil) {
        _groupLabel = [[UILabel alloc] init];
        _groupLabel.font = FONT(14);
        _groupLabel.textColor = WHITECOLOR;
        _groupLabel.text = @"组员";
    }
    return _groupLabel;
}

- (UIView *)imgListView{
    if (_imgListView == nil) {
        _imgListView = [[UIView alloc] init];
        
    }
    return _imgListView;
}

- (UILabel *)countLabel{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = FONT(14);
        _countLabel.textColor = WHITECOLOR;
    }
    return _countLabel;
}

- (YB_FocusButton *)applyBtn{
    if (_applyBtn == nil) {
        _applyBtn = [[YB_FocusButton alloc] init];
        _applyBtn.layer.borderColor = WHITECOLOR.CGColor;
        [_applyBtn setTitle:@"申请加入" forState:UIControlStateNormal];
        [_applyBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    }
    return _applyBtn;
}

@end
