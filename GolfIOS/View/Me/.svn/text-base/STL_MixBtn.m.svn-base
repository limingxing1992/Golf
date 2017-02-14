//
//  STL_MixBtn.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_MixBtn.h"

@interface STL_MixBtn ()
/** 图标*/
@property (nonatomic, strong) UIImageView *iv;


@end

@implementation STL_MixBtn

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title{
    self = [super init];
    if (self) {
        [self addSubview:self.iv];
        [self addSubview:self.lb];
        
        self.iv.sd_layout
        .topSpaceToView(self, 0)
        .centerXEqualToView(self)
        .widthIs(image.size.width)
        .heightIs(image.size.height);
        
        self.lb.sd_layout
        .topSpaceToView(_iv, 3)
        .autoHeightRatio(0)
        .leftSpaceToView(self, 10);
        [self.lb setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH];
        self.iv.image = image;
        self.lb.text = title;
        
        [self setupAutoWidthWithRightView:self.lb rightMargin:10];//btn宽度根据文字自适应
        [self setupAutoHeightWithBottomView:self.lb bottomMargin:0];//btn高度自适应
    }
    return self;
}



#pragma mark ----------------实例

- (UIImageView *)iv{
    if (!_iv) {
        _iv = [[UIImageView alloc] init];
    }
    return _iv;
}

- (UILabel *)lb{
    if (!_lb) {
        _lb = [[UILabel alloc] init];
        _lb.font = FONT(12);
        _lb.textAlignment = NSTextAlignmentCenter;
        _lb.text = @"未知";
        _lb.textColor = BLACKTEXTCOLOR;
    }
    return _lb;
}


@end
