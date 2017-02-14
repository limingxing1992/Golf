//
//  YB_Tools.m
//  GolfIOS
//
//  Created by yangbin on 16/12/14.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "YB_Tools.h"

@implementation YB_Tools

+ (NSURL *)fullPicUrl:(id)picUrl{
//    OSS外网域名: tsoudingdan.oss-cn-hangzhou.aliyuncs.com
//    OSS内网域名:tsoudingdan.oss-cn-hangzhou-internal.aliyuncs.com

    if (picUrl) {
        NSURL *head = [NSURL URLWithString:@"https://tsoudingdan.oss-cn-hangzhou.aliyuncs.com"];
        NSURL *url;
        if ([picUrl isKindOfClass:[NSURL class]]) {
            url = [head URLByAppendingPathComponent:[picUrl absoluteString]];
        }else{
            
            NSString *string = (NSString *)picUrl;
            if (string.length > 0) {
                if ([[string substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"http"]) {
                    return [NSURL URLWithString:string];
                }else{
                    
                    NSString *encodedString = (NSString *)
                    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                              (CFStringRef)string,
                                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                              NULL,kCFStringEncodingUTF8));
//                    picUrl = [picUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSURL *imgUrl = [NSURL URLWithString:encodedString];
                    url = [head URLByAppendingPathComponent:[imgUrl absoluteString]];
                    
                    return url;
                } 
            }else{
                NSURL *imgUrl = [NSURL URLWithString:picUrl];
                url = [head URLByAppendingPathComponent:[imgUrl absoluteString]];
                return url;
            }
        }
        
        return url;
    }else{
        return picUrl;
    }
//    return picUrl;
}


+ (NSURL *)fullIconUrl:(NSURL *)iconUrl{
    
    NSURL *head = [NSURL URLWithString:@"https://tsoudingdan.oss-cn-hangzhou.aliyuncs.com"];
    
    NSURL *url = [head URLByAppendingPathComponent:[iconUrl absoluteString]];
    
    NSString *urlStr = [[url absoluteString] stringByAppendingString:@"?x-oss-process=image/resize,h_100"];;

    return [NSURL URLWithString:urlStr];
    
}




@end
