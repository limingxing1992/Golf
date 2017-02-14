//
//  HomeProcessor.h
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseProcessor.h"

@interface HomeProcessor : BaseProcessor

/** 首页 */
- (void)getIndexInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)success failure:(ERRORBlock)failure;

@end
