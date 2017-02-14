//
//  MyBirdFillCollectionViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/12.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyBirdFillCollectionViewCell.h"

@interface MyBirdFillCollectionViewCell ()



@end

@implementation MyBirdFillCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = GRAYCOLOR.CGColor;
        self.contentView.layer.cornerRadius = 5;
        [self.contentView addSubview:self.titleLb];
        
        _titleLb.sd_layout
        .centerXEqualToView(self.contentView)
        .centerYEqualToView(self.contentView)
        .widthRatioToView(self.contentView, 1)
        .autoHeightRatio(0);
        
    }
    return self;
}

- (void)setModel:(MyBirdWalletFillRuleModel *)model{
    _model = model;
}


#pragma mark ----------------实例

- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = FONT(16);
        _titleLb.textColor = BLACKTEXTCOLOR;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

@end
