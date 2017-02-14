//
//  STL_TextField.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_TextField.h"

@implementation STL_TextField


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = FONT(14);
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.textColor = BLACKTEXTCOLOR;
        self.backgroundColor = WHITECOLOR;
        self.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:CGRectMake(15, 0, rect.size.width - 30, rect.size.height)];
}

- (void)drawPlaceholderInRect:(CGRect)rect{
    [super drawPlaceholderInRect:CGRectMake(15, 0, rect.size.width - 30, rect.size.height)];
}



@end
