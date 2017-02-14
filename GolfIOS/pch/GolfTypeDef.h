//
//  GolfTypeDef.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/1.
//  Copyright © 2016年 zzz. All rights reserved.
//

#ifndef GolfTypeDef_h
#define GolfTypeDef_h

typedef void(^NILBlock)(void);//空block
typedef void(^INdexBlock)(NSInteger index);//参数类型为常亮
typedef void(^OBJBlock)(id responObject);//参数为id类型的block
typedef void(^ERRORBlock)(NSError *error);//参数为error的block
typedef void (^ERRORCODEBlock)(NSInteger errCode,NSString *errorMsg);//参数为解析后error的block


typedef NS_ENUM(NSInteger, OrderStyle) {
    OrderWaitPayStyle = 10,      //待付款   （可取消订单，可支付）
    OrderWaitSureStyle = 20,     //待确认 (已付款，可以申请退款)
    OrderAvailableStyle = 30,    //可使用  (可退款)
    OrderDoneCancelStyle = 400,    //已取消    (可重新预订)
    OrderUnAvailableStyle =40,  //已使用    (可评价)
    OrderRefundingStyle = 300 ,    //退款中    (无操作)
    OrderDoneRefundStyle = 350,    //已退款    (可重新预订)
    OrderDoneJugeStyle = 50     //已评价   （查看评价信息）
};

#define OrderListUpdate @"orderListUpdate"

#define OrderDetailUpdate @"orderDetailUpdate"

#define FriendSelectInfo @"friendSelectInfo"

#define UserInfoUpdate @"userinfoupdate"

#define PayResult @"payResult"

#define LoginSuccess @"loginSuccess"

#endif /* GolfTypeDef_h */
