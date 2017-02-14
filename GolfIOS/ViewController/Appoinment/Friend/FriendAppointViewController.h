//
//  FriendAppointViewController.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/23.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "STL_BaseViewController.h"

@interface FriendAppointViewController : STL_BaseViewController
//选择邀约人界面

@property (nonatomic, copy) void(^selectFriendBlock)(NSMutableArray *friendAry, NSMutableArray *friendGroupAry);


@property (nonatomic, strong) NSMutableArray *friendGroupAry;//好友分组
@property (nonatomic, strong) NSMutableArray *friendAry;//好友集合

@end
