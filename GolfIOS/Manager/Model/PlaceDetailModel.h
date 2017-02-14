//
//  PlaceDetailModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/1.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@class PlaceDetailInfoModel;
@class PlaceComboItemModel;

@interface PlaceDetailModel : NSObject

/** 球场基本信息*/
@property (nonatomic, strong) PlaceDetailInfoModel *ballPlaceInfo;
/** 收藏状态*/
@property (nonatomic, assign) BOOL collectStatus;
/** 套餐列表*/
@property (nonatomic, strong) NSArray *comboList;
/** 评论数量*/
@property (nonatomic, copy) NSString *commentNum;
/** banner图*/
@property (nonatomic, strong) NSArray *imgList;


@end
//球场信息模型
@interface PlaceDetailInfoModel : NSObject
/**
 
 address	地址	string
 closeTime	营业结束时间	string
 id	球场id	number
 latitude	纬度	string
 longitude	经度	string
 mdf		string
 name	球场名称	string
 openTime	营业开始时间	string
 servicePhone	服务电话	string
 */

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *mdf;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *servicePhone;
@property (nonatomic, copy) NSString *closeTime;
@property (nonatomic, copy) NSString *openTime;



@end
/** 套餐模型*/
@interface PlaceComboItemModel : NSObject
/**
content	服务内容	string
id	套餐id	number
logoUrl	套餐图片	string
mdf		string
name	套餐名称	string
notice	服务条例	string
price	价格	number
serviceHour	服务时长	string
type	类型	number
typeName	类型名称	string
 minMember 最少人数、、
*/
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *mdf;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *notice;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *serviceHour;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, assign) NSInteger minMember;





@end

