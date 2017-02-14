//
//  MyOrderModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyOrderInfoModel;
@class PlaceDetailInfoModel;
@class PlaceComboItemModel;

@interface MyOrderListItemModel : NSObject
/**
 
 不传-全部,10-待付款，20-待确认，30-待使用，40-待评价，50-已完结，300-待退款，350-已退款，400-已取消
 */


@property (nonatomic, strong) PlaceDetailInfoModel *ballPlaceInfo;

@property (nonatomic, strong) PlaceComboItemModel *serviceInfo;

@property (nonatomic, strong) MyOrderInfoModel *orderInfo;

@property (nonatomic, strong) NSArray *payInfoList;



@end


@interface MyOrderInfoModel : NSObject

/**
 
 "orderNo": "20161215112639811545265689",
 "status": 20,
 "statusName": "待确认",
 "bookTime": "2017-04-15 14:27:00",
 "personNum": 3,
 "totalPrice": 135,
 "phoneUser": "夏俊峰",
 "phoneNumber": "15700181175",
 "orderTime": "2016-12-15 11:26:39",
 "remark": "带小孩"
 serviceTicket //服务凭证
 */
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSString *bookTime;
@property (nonatomic, copy) NSString *personNum;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, copy) NSString *phoneUser;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *orderTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *serviceTicket;



@end


@interface MyOrderPayInfoItemModel : NSObject

/** 支付渠道编号*/
@property (nonatomic, assign) NSInteger  channel;
/** 支付渠道名字*/
@property (nonatomic, copy) NSString *channelName;
/** 金额*/
@property (nonatomic, copy) NSString *amount;
/** 支付单号*/
@property (nonatomic, copy) NSString *payNo;
/** 第三方支付单号*/
@property (nonatomic, copy) NSArray *transcationNo;
/** 支付时间*/
@property (nonatomic, copy) NSString *updateTime;

@end

