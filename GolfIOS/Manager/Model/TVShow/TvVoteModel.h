//
//  TvVoteModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/8.
//  Copyright © 2016年 TSou. All rights reserved.


//小鸟投票模型

#import <Foundation/Foundation.h>

@interface TvVoteModel : NSObject
/** 
 
 activityId	活动id	number
 flag	是否已投票	number
 headUrl	头像URL	string
 id	id	number
 name	名称	string
 no	排名	number
 voteCnt	投票数	number	 
 
 
 article	介绍	string
 cellphone	手机号	string
 contact	联系方式	string
	*/

@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *voteCnt;
@property (nonatomic, copy) NSString *article;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *contact;






@end


@interface TvVoteActionModel : NSObject

/** 
 content	活动内容	string
 endTime	结束日期	string	yyyy-MM-dd
 id	id	number
 imageUrl	活动图片url	string
 name	活动名	string
 startTime	开始日期	string	yyyy-MM-dd
 status	状态码	number	0="未开始" ，1="已开始"，2="已结束"，	3="暂停"
 statusName	状态名	string
 */

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, copy) NSString *gradeName;




@end
