//
//  MyLevelModel.m
//  GolfIOS
//
//  Created by 李明星 on 2016/12/13.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "MyLevelModel.h"

@implementation MyLevelModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"gradeList":@"MyLevelUpItemModel"};
}

@end

@implementation MyLevelInfoModel

@end

@implementation MyLevelUpItemModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _sort = 1;
    }
    return self;
}

- (void)setSort:(NSInteger)sort{
    _sort = sort;
    [self updateLevelImg];
}

- (void)updateLevelImg{
    //从1- 5
    NSInteger levelLd = _sort + 118;
    NSString *img = [NSString stringWithFormat:@"classify%ld", levelLd];
    _indicatorIv = IMAGE(img);
}

@end
