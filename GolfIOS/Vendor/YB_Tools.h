//
//  YB_Tools.h
//  GolfIOS
//
//  Created by yangbin on 16/12/14.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YB_Tools : NSObject

/**
 根据相对路径返回绝对路径
 
 @param picUrl 相对路径 可以是NSURL 或者是NSString
 @return 绝对路径
 */
+ (NSURL *)fullPicUrl:(id)picUrl;


/**
 根据相对路径返回绝对路径,用于头像 返回的是经过压缩的图片
 
 @param iconUrl 相对头像路径
 @return 绝对路径
 */
+ (NSURL *)fullIconUrl:(NSURL *)iconUrl;
@end
