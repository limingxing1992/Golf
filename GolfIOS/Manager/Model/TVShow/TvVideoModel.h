//
//  TvVideoModel.h
//  GolfIOS
//
//  Created by 李明星 on 2017/1/5.
//  Copyright © 2017年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TvVideoModel : NSObject
/** 
 
 createTime	创建时间	string
 grade	查看等级
 gradeName	查看等级名称	string
 id	视频id	number
 name	视频名称	string
 pictureUrl	视频封面URL	string
 status	视频状态	number	取值：[未上传=0，已上传=1]
 statusName	视频状态名称	string	状态，取值：[未上传=0，已上传=1]
 videoUrl	视频URL	string
 voteCnt	投票数	number
 
 "id": 4,
 "name": "2016杭州高尔夫大赛",
 "status": 1,
 "statusName": "已上传",
 "videoUrl": "golf/movie/video.mp4",
 "pictureUrl": "golf/combo/7be2807f2df24287a28e7c8ac72bed4e.jpg",
 "voteCnt": 0,
 "createTime": "2016-12-27 17:39:28",
 "grade": 3,
 "gradeName": "伯爵",
 "sort": 3


 */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger statusName;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, assign) NSInteger voteCnt;
@property (nonatomic, assign) NSInteger sort;



@end
