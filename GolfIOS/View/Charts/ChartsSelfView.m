//
//  ChartsSelfView.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "ChartsSelfView.h"

@interface ChartsSelfView ()
/** 我*/
@property (nonatomic, strong) UILabel *meLb;
/** 头像*/
@property (nonatomic, strong) UIImageView *headIv;
/** 名次*/
@property (nonatomic, strong) UILabel *placeLb;
/** 名单位*/
@property (nonatomic, strong) UILabel *mingLb;
/** 分数*/
@property (nonatomic, strong) UILabel *scoreLb;
/** 标签*/
@property (nonatomic, strong) UIImageView *tagIv;


@end

@implementation ChartsSelfView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBColor(98, 185, 110);
        [self sd_addSubviews:@[self.meLb,
                               self.headIv,
                               self.placeLb,
                               self.mingLb,
                               self.scoreLb,
                               self.tagIv]];
        [self autoLayoutSubViews];//自动布局
    }
    return self;
}

- (void)autoLayoutSubViews{
    _meLb.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 10)
    .autoHeightRatio(0);
    [_meLb setSingleLineAutoResizeWithMaxWidth:100];
    
    _headIv.sd_layout
    .centerYEqualToView(_meLb)
    .leftSpaceToView(_meLb, 10)
    .heightIs(45)
    .widthEqualToHeight();
    [_headIv setSd_cornerRadiusFromWidthRatio:@0.5];
    
    _placeLb.sd_layout
    .centerYEqualToView(_headIv)
    .leftSpaceToView(_headIv, 15)
    .autoHeightRatio(0);
    [_placeLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _mingLb.sd_layout
    .bottomEqualToView(_placeLb)
    .leftSpaceToView(_placeLb,2)
    .autoHeightRatio(0);
    [_mingLb setSingleLineAutoResizeWithMaxWidth:100];
    
    _scoreLb.sd_layout
    .rightSpaceToView(self, 35)
    .centerYEqualToView(_headIv)
    .autoHeightRatio(0);
    [_scoreLb setSingleLineAutoResizeWithMaxWidth:300];
    
    _tagIv.sd_layout
    .leftSpaceToView(_scoreLb, 5)
    .bottomEqualToView(_scoreLb)
    .widthIs(25)
    .heightIs(15);
    
}

#pragma mark ----------------数据

- (void)setModel:(ChartsUserModel *)model{
    [_headIv sd_setImageWithURL:FULLIMGURL(model.headUrl) placeholderImage:Placeholder_middle];
    _placeLb.text = model.no;
    _scoreLb.text = model.score;
    if (model.score.length) {
        _scoreLb.text = model.score;
        _tagIv.image = IMAGE(@"classify-7");
    }else if (model.hot.length){
        _scoreLb.text = model.hot;
        _tagIv.image = IMAGE(@"classify-hot");
    }

}


#pragma mark ----------------实例

- (UILabel *)meLb{
    if (!_meLb) {
        _meLb = [[UILabel alloc] init];
        _meLb.font = FONT(14);
        _meLb.textColor = WHITECOLOR;
        _meLb.text = @"我";
    }
    return _meLb;
}

- (UIImageView *)headIv{
    if (!_headIv) {
        _headIv = [[UIImageView alloc] init];
        _headIv.layer.borderColor = WHITECOLOR.CGColor;
        _headIv.layer.borderWidth = 3;
        _headIv.image = Placeholder_middle;
    }
    return _headIv;
}

- (UILabel *)placeLb{
    if (!_placeLb ) {
        _placeLb = [[UILabel alloc] init];
        _placeLb.font = FONT(25);
        _placeLb.textColor = WHITECOLOR;
        _placeLb.text = @"12";
    }
    return _placeLb;
}

- (UILabel *)mingLb{
    if (!_mingLb) {
        _mingLb = [[UILabel alloc] init];
        _mingLb.font = FONT(14);
        _mingLb.textColor = WHITECOLOR;
        _mingLb.text = @"名";
    }
    return _mingLb;
}

- (UILabel *)scoreLb{
    if (!_scoreLb) {
        _scoreLb = [[UILabel alloc] init];
        _scoreLb.font = FONT(20);
        _scoreLb.textColor = WHITECOLOR;
        _scoreLb.text = @"000";
    }
    return _scoreLb;
}

- (UIImageView *)tagIv{
    if (!_tagIv) {
        _tagIv = [[UIImageView alloc] init];
        _tagIv.image = IMAGE(@"classify-7");
    }
    return _tagIv;
}

@end
