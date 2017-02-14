//
//  CommonUncaughtExceptionHandler.m
//  ZZLIOS
//
//  Created by 张永亮 on 15-1-3.
//  Copyright (c) 2015年 zzz. All rights reserved.
//

#import "CommonUncaughtExceptionHandler.h"

@implementation CommonUncaughtExceptionHandler

#pragma mark 错误报告
void UncaughtExceptionHandler(NSException *exception)
{
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto:1103475465@qq.com ?subject=%@ Bug Report &body=Thanks for your coorperation!<br><br><br>"
                        "AppName:%@<br>"\
                        "Version:%@<br>"\
                        "Build:%@<br>"\
                        "Details:<br>%@<br>--------------------------<br>%@<br>---------------------<br>%@",
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
                        name,reason,[arr componentsJoinedByString:@"<br>"]];
    NSLog(@"exception:%@",urlStr);
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

+ (void)setDefaultHandler
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}

@end
