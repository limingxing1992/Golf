//
//  YB_ScoreButton.m
//  GolfIOS
//
//  Created by yangbin on 16/11/29.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "YB_ScoreButton.h"
#import "UIImage+Image.h"

@implementation YB_ScoreButton

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 5.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 27.0/255.0, 158.0/255.0, 106.0/255.0, 1.0);
//    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    //开始一个起始路径
    CGContextBeginPath(context);
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextAddArc(context, rect.size.width * 0.5, rect.size.width * 0.5, rect.size.width * 0.5 - 8, 0, M_PI * 2, 1);
    //连接上面定义的坐标点
    CGContextStrokePath(context);

}




@end
