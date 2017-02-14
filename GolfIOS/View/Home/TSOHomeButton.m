//
//  TSOHomeButton.m
//  GolfIOS
//
//  Created by yangbin on 16/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOHomeButton.h"

@implementation TSOHomeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [self setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.imageView.sd_layout
        .topSpaceToView(self, 11 *KHeight_Scale)
        .centerXEqualToView(self)
        .widthIs(32 * KWidth_Scale)
        .heightIs(32 * KWidth_Scale);
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.imageView, 5.5)
        .centerXEqualToView(self)
        .autoHeightRatio(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:100];
        
        self.titleLabel.font = FONT(14);
    }
    return self;
}

@end
