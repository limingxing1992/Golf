//
//  MyLevelModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MyLevelInfoModel;
@class MyLevelUpItemModel;

/** 我的荣誉模型*/
@interface MyLevelModel : NSObject
/** 升级列表*/
@property (nonatomic, strong) NSArray *gradeList;
/** 用户信息*/
@property (nonatomic, strong) MyLevelInfoModel *userData;
/** html语句*/
@property (nonatomic, copy) NSString *service;

@end

/** 用户信息*/
@interface MyLevelInfoModel : NSObject

/** 
 cash	金额	number
 id		number
 name	等级名称	string
 sort	排序	number
 */
@property (nonatomic, copy) NSString *cash;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sort;

@end

/** 升级列表*/
@interface MyLevelUpItemModel : NSObject

/** 
 cash	金额	number
 id	id	number
 name	等级名称	string
 sort	排序	number
 */
@property (nonatomic, copy) NSString *cash;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger sort;
/** 当前等级对应升级图标*/
@property (nonatomic, strong) UIImage *indicatorIv;



@end
