//
//  YB_UITextField.m
//  GolfIOS
//
//  Created by yangbin on 16/11/28.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "YB_UITextField.h"

@implementation YB_UITextField

// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width-25, bounds.size.height);
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+15, bounds.origin.y, bounds.size.width-25, bounds.size.height);
    return inset;
}

@end
