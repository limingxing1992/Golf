//
//  FriendUserModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 好友个人信息模型*/
@interface FriendUserModel : NSObject
/** 
 
 headUrl	头像	string
 name	用户的真实姓名	string
 nickName	用户的昵称	string
 sex	性别	number
 sexName	性别备注	string
 userId	用户Id	number
 userName	用户账号（手机号）	string
 
 //好友申请模型
 validateMessage	验证消息	string	@mock=$order('','','')
 validateStatus	验证状态	number	@mock=$order(1,0,0)
 validateStatusName	验证状态备注	string	@mock=$order('验证通过','待验证','待验证')
 
 //我的关注模型
 flag	是否已关注	number	关注状态：1-已关注，0-未关注@mock=$order(1,1)
 gradeId	等级Id	number	@mock=$order(2,2)
 gradeName	等级名称	string	@mock=$order('侯爵','侯爵')
 headUrl	头像	string	@mock=$order('http://img1.2345.com/duoteimg/qqTxImg/2013/12/ns/18-024824_754.jpg','http://v1.qzone.cc/avatar/201406/29/18/15/53afe73912959815.jpg%21200x200.jpg')
 name	姓名	string	@mock=$order('张永亮','万东')
 nickName	昵称	string	@mock=$order('张永亮','杨星')
 sex	性别	number	性别状态：1-男，2-女@mock=$order(0,0)
 sexName	性别备注	string	@mock=$order('保密','保密')
 sort	等级标识	number	等级状态：1-男爵，2-子爵，3-伯爵，4-侯爵，5-公爵@mock=$order(3,3)
 userId	用户Id	number	@mock=$order(17,16)
 userName	账号	string	@mock=$order('15715790842','15715790841')
  */

@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *sexName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *validateMessage;
@property (nonatomic, assign) BOOL validateStatus; //1== 通过 0==待同意
@property (nonatomic, copy) NSString *validateStatusName;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, strong) NSString *gradeId;
@property (nonatomic, strong) NSString *gradeName;
@property (nonatomic, strong) UIImage *levelImg;//当前等级图标



/** 是否在当前分组内*/
@property (nonatomic, assign) BOOL isGroupItem;

/** 是否已被选择（用于以一键约球）*/
@property (nonatomic, assign) BOOL isSelected;




@end


/** 好友分组模型*/
@interface FriendGroupItemModel : NSObject
/** 
 
 groupCount	每个分组的人数	number	@mock=$order(1,2,1,1)
 groupMemberList	分组成员	array<object>
 groupName	分组名称	string	@mock=$order('家人','同事','同学','牌友')
 id		number	@mock=$order(1,2,3,4)
 */
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, assign) NSInteger groupCount;
@property (nonatomic, strong) NSMutableArray *groupMemberList;

//一键约球里是否已被选中
@property (nonatomic, assign) BOOL isSelect;



@end
