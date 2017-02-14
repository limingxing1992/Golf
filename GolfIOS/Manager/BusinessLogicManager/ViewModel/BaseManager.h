//
//  BaseManager.h
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseManager : NSObject

/*********************************************************************
 函数名称 : analyticalHttpErrorDescription:
 函数描述 : 解析http 200之外的错误日志信息
 输入参数 :
 输出参数 :
 返回值 :
 作者   : 张永亮
 *********************************************************************/
- (NSString *)analyticalHttpErrorDescription:(NSError *)error;

@end
