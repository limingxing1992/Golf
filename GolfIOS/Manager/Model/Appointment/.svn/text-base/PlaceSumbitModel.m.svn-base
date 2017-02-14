//
//  PlaceSumbitModel.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/9.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "PlaceSumbitModel.h"

@implementation PlaceSumbitModel

- (BOOL)isCanSubit{
    
    //打球联系方式
    if (!_connectName || !_connectPhone) {
        return NO;
    }
    //打球时间
    if (!_comboId) {
        return NO;
    }
    //打球人数
    if (!_count) {
        return NO;
    }
    
    return YES;
}

@end
