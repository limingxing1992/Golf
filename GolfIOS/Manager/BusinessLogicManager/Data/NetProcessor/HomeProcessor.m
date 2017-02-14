//
//  HomeProcessor.m
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "HomeProcessor.h"
//首页
static NSString *const kGetIndexInfo = @"app/index/getIndexInfo.do";
@implementation HomeProcessor


- (void)getIndexInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure{
    [self afHTTPSessionManagerToServerInteractionWithInterface:kGetIndexInfo parameter:parameters success:success failure:failure];
}

@end
