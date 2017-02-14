//
//  TSOMyClubButton.m
//  GolfIOS
//
//  Created by wyao on 16/12/16.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOMyClubButton.h"

@implementation TSOMyClubButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [self setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.imageView.sd_layout
        .topSpaceToView(self, 13)
        .leftSpaceToView(self,15)
        .widthIs(40)
        .heightIs(40);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self.imageView, 10)
        .centerYEqualToView(self.imageView)
        .autoHeightRatio(0);
        [self.titleLabel setSingleLineAutoResizeWithMaxWidth:80];

        
        self.titleLabel.font = FONT(14);
    }
    return self;
}



@end
