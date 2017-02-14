//
//  FriendUserModel.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "FriendUserModel.h"

@implementation FriendUserModel

- (void)setSort:(NSInteger)sort{
    _sort = sort;
    //从1- 5
    NSInteger levelLd = sort + 147;
    NSString *img = [NSString stringWithFormat:@"classify%ld", levelLd];
    _levelImg = IMAGE(img);
}

@end



@implementation FriendGroupItemModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"groupMemberList":@"FriendUserModel"};
}

@end
