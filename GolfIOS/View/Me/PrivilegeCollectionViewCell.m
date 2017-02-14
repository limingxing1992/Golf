//
//  PrivilegeCollectionViewCell.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "PrivilegeCollectionViewCell.h"


@interface PrivilegeCollectionViewCell ()

/** 图片 改变图片*/
@property (nonatomic, strong) UIImageView *iv;
/** 特权名字*/
@property (nonatomic, strong) UILabel *lb;

@end

@implementation PrivilegeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = WHITECOLOR;
        [self.contentView addSubview:self.iv];
        [self.contentView addSubview:self.lb];
        
        _iv.sd_layout
        .topSpaceToView(self.contentView, 25)
        .centerXEqualToView(self.contentView)
        .heightIs(27)
        .widthEqualToHeight();
        
        _lb.sd_layout
        .bottomSpaceToView(self.contentView, 0)
        .centerXEqualToView(self.contentView)
        .autoHeightRatio(0);
        [_lb setSingleLineAutoResizeWithMaxWidth:frame.size.width];
        [_lb setMaxNumberOfLinesToShow:1];
    }
    return self;
}

#pragma mark ----------------实例化

- (UIImageView *)iv{
    if (!_iv) {
        _iv  = [[UIImageView alloc] init];
        _iv.image = IMAGE(@"classify113");
    }
    return _iv;
}

- (UILabel *)lb{
    if (!_lb) {
        _lb = [[UILabel alloc] init];
        _lb.font = FONT(14);
        _lb.textColor = LIGHTTEXTCOLOR;
        _lb.text = @"身份铭牌";
    }
    return _lb;
}


@end
