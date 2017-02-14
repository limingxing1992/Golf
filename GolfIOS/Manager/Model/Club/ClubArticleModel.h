//
//  ClubArticleModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"

@class ClubArticleDataModel,PagerModel;

@interface ClubArticleModel : BaseObject

/**data*/
@property (nonatomic, strong) ClubArticleDataModel *data;

@end


@interface ClubArticleDataModel : NSObject

/**dataList*/
@property (nonatomic, strong) NSMutableArray *dataList;
/**pager*/
@property (nonatomic, strong) PagerModel *pager;

@end


