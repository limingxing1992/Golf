//
//  MyInviteMeCellOperationMenu.m
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyInviteMeCellOperationMenu.h"

@implementation MyInviteMeCellOperationMenu

{

    UIButton *_commentButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = GLOBALCOLOR;
    
        _commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"classify188"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    
    
    
    
    [self sd_addSubviews:@[ _commentButton]];
    
    CGFloat margin = 5;
    

    
    _commentButton.sd_layout
    .leftSpaceToView(self, margin)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .rightSpaceToView(self, margin);
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}



- (void)commentButtonClicked
{
    if (self.commentButtonClickedOperation) {
        self.commentButtonClickedOperation();
    }
    self.show = NO;
}

- (void)setShow:(BOOL)show
{
    _show = show;
    
    [UIView animateWithDuration:0.2 animations:^{
        if (!show) {
            [self clearAutoWidthSettings];
            self.sd_layout
            .widthIs(0);
        } else {
            self.fixedWidth = nil;
//            [self setupAutoWidthWithRightView:_commentButton rightMargin:5];
            self.sd_layout.widthIs(90);
        }
        [self updateLayoutWithCellContentView:self.superview];
    }];
}



@end
