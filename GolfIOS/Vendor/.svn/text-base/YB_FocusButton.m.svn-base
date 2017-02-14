//
//  YB_FocusButton.m
//  GolfIOS
//
//  Created by yangbin on 16/11/4.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "YB_FocusButton.h"

@implementation YB_FocusButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = GLOBALCOLOR.CGColor;
        self.layer.borderWidth = 0.5;
        [self setTitle:@"关注" forState:UIControlStateNormal];
        [self setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        self.titleLabel.font = FONT(12);
        

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height * 0.5;
}

@end
