//
//  BaseProcessor.m
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "BaseProcessor.h"

@implementation BaseProcessor

- (void)afHTTPSessionManagerToServerInteractionWithInterface:(NSString *)interface
                                                   parameter:(NSDictionary *)parameters
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSError *error))failure
{
    [self afHTTPSessionManagerToServerInteractionWithUrlString:[NSString stringWithFormat:@"%@%@",[GOLFUserDefault objectForKey:@"currentAPI"],interface]
                                                     parameter:parameters
                                                       success:success
                                                       failure:failure];
    
}




- (void)afHTTPSessionManagerToServerInteractionWithUrlString:(NSString *)urlString
                                                   parameter:(NSDictionary *)parameters
                                                     success:(void (^)(id responseObject))success
                                                     failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *ser = [AFJSONResponseSerializer serializer];
    ser.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    [manager setResponseSerializer:ser];
    [manager POST:urlString
       parameters:parameters
         progress:^(NSProgress *uploadProgress){
             //             NSLog(@"uploadProgress:%f",uploadProgress.fractionCompleted);
         }
          success:^(NSURLSessionDataTask *task, id responseObject){
              //              NSLog(@"success:%@",responseObject);
              NSInteger flag = [responseObject[@"status"] integerValue];
              if (flag == 4005) {
                  //登录失效
                  [[UserModel sharedUserModel] setIsLogin:NO];
              }
              success(responseObject);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error){
              //              NSLog(@"failure:%@",error);
              failure(error);
          }];
    
}


@end
