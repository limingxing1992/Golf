//
//  Club.h
//  GolfIOS
//
//  Created by yangbin on 16/12/8.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Club : NSObject

/**俱乐部名称*/
@property (nonatomic, strong) NSString *clubName;
/**俱乐部id*/
@property (nonatomic, strong) NSNumber *clubId;
/**俱乐部Logo*/
@property (nonatomic, strong) NSURL *logoUrl;
/**是否被选中*/
@property (nonatomic, assign) BOOL isSelected;

@end
