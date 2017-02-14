//
//  TSOAddPlayerButton.m
//  GolfIOS
//
//  Created by yangbin on 16/12/26.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "TSOAddPlayerButton.h"

@implementation TSOAddPlayerButton

//-(void)layoutSubviews {
//    [super layoutSubviews];
//    
//    // Center image
//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width/2;
//    center.y = self.imageView.frame.size.height/2;
//    self.imageView.center = center;
//    
//    self.imageView.layer.cornerRadius = self.imageView.size.width/2;
//    self.imageView.layer.masksToBounds = YES;
//    
//    //Center text
//    CGRect newFrame = [self titleLabel].frame;
//    newFrame.origin.x = 0;
//    newFrame.origin.y = self.imageView.frame.size.height + 5;
//    newFrame.size.width = self.frame.size.width;
//    
//    self.titleLabel.frame = newFrame;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//}
//
//- (CGRect)imageRectForContentRect:(CGRect)bounds{
//    
//    return CGRectMake(0.0, 0.0, self.frame.size.width * 0.7, self.frame.size.width * 0.7);
//    
//}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [self setTitleColor:GLOBALCOLOR forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    
    self.imageView.sd_layout
    .topSpaceToView(self, 10)
    .centerXEqualToView(self)
    .widthIs(self.frame.size.width * 0.8)
    .heightIs(self.frame.size.width * 0.8);
    self.imageView.sd_cornerRadius = [NSNumber numberWithFloat:self.frame.size.width* 0.8 * 0.5];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.imageView, 5)
    .centerXEqualToView(self)
    .autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:self.frame.size.width * 1.2];
//    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:self.frame.size.width];
    [self.titleLabel setMaxNumberOfLinesToShow:1];
    
    self.titleLabel.font = FONT(14);
}

@end
