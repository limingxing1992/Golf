//
//  TSOScroeButton.m
//  GolfIOS
//
//  Created by yangbin on 16/11/11.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "TSOScroeButton.h"

@interface TSOScroeButton ()


@end

@implementation TSOScroeButton



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;

        self.layer.borderColor = GLOBALCOLOR.CGColor;
        [self setTitle:@"1" forState:UIControlStateNormal];
        [self setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        self.titleLabel.font = FONT(70);
        
    }
    return self;
}

- (void)setScore:(NSNumber *)score{
    _score = score;
    NSString *scoreStr = _score.stringValue;
    [self setTitle:scoreStr forState:UIControlStateNormal];
 
}



@end
