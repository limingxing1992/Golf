//
//  PlaceItemModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/1.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@interface PlaceItemModel : NSObject
//球场模型
/**
 address	地址	string
 distance	距离	string
 id	球场id	number
 logoUrl	球场图片	string
 name	球场名称	string
 price	最低价格	number
 type	类型	number
 typeName	类型名称	string
 
 collectId	收藏Id	number

 */
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSNumber *ID;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSString *typeName;

@property (nonatomic, copy) NSString *collectId;


@end
