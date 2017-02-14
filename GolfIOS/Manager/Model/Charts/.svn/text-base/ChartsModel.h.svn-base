//
//  ChartsModel.h
//  GolfIOS
//
//  Created by 李明星 on 2016/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ChartsUserModel;

@interface ChartsModel : NSObject

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) ChartsUserModel *userData;


@end


@interface ChartsItemModel : NSObject

/**
 headUrl	头像URL	string	@mock=$order('http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg','http://v1.qzone.cc/avatar/201407/01/12/53/53b23ebb14c27312.jpg%21200x200.jpg','http://v1.qzone.cc/avatar/201503/15/13/08/550513b64bcbf041.jpg%21200x200.jpg','http://img1.2345.com/duoteimg/qqTxImg/2013/12/ns/18-024824_754.jpg','http://v1.qzone.cc/avatar/201406/29/18/15/53afe73912959815.jpg%21200x200.jpg')
 id	id	number	@mock=$order(27,2,31,30,29,28,26,25,23,22,21,19,18,17,16)
 name	昵称	string	@mock=$order('12313','德友','G64093','J57016','X74481','123','A','1231','123123','姚文','杨斌','周凡','徐杭杰','张永亮','杨星')
 no	名次	number	@mock=$order(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
 score	积分数	number	@mock=$order(20,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
 hot	热度	number	@mock=$order(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
 ranKStatus	排名名称		3=明日之星
 */

@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *hot;
@property (nonatomic, assign) NSInteger ranKStatus;




@end


@interface ChartsUserModel : NSObject

/** 
 
 headUrl	头像URL	string	@mock=http://tupian.enterdesk.com/2014/mxy/11/2/1/12.jpg
 hot	热度	number	@mock=0
 id	id	number	@mock=27
 name	昵称	string	@mock=12313
 no	名次	number	@mock=6
 score	积分数	number	@mock=20
 */
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *hot;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *score;


@end
