//
//  MyPointsModel.h
//  GolfIOS
//
//  Created by 李明星 on 2017/1/6.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPointsModel : NSObject

/** 
 content	兑换服务内容	string
 createTime	服务创建时间	string
 id		number
 notice	兑换须知	string
 score	兑换所需积分	number
 serviceName	服务名称	string
   logoUrl	图片地址
 */

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *serviceName;
@property (nonatomic, copy) NSString *logoUrl;


@end
