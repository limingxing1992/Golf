//
//  CommunityPersonalUserDeailModel.h
//  GolfIOS
//
//  Created by Rock on 2016/12/4.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@class CommunityPersonalUserDeail;

@interface CommunityPersonalUserDeailModel : BaseObject

/**data*/
@property (nonatomic, strong) CommunityPersonalUserDeail *data;

@end


@interface CommunityPersonalUserDeail : NSObject
/**收藏数*/
@property (nonatomic, strong) NSNumber *collectNum;
/**粉丝数*/
@property (nonatomic, strong) NSString *fansNum;
/**关注数*/
@property (nonatomic, strong) NSNumber *followNum;
/**头像*/
@property (nonatomic, strong) NSURL *headUrl;
/**id*/
@property (nonatomic, strong) NSNumber *ID;
/**昵称*/
@property (nonatomic, strong) NSString *nickname;
@end
