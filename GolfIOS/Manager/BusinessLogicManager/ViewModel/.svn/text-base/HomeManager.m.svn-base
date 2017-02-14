//
//  HomeManager.m
//  GolfIOS
//
//  Created by yangbin on 16/12/20.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "HomeManager.h"
#import "HomeProcessor.h"
#import "HomeInfoModel.h"

@interface HomeManager ()

/**HomeProcessor*/
@property (nonatomic, strong) HomeProcessor *processor;

@end

@implementation HomeManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _processor = [[HomeProcessor alloc] init];
    }
    return self;
}



//MARK: - 首页

- (void)getIndexInfoWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getIndexInfoWithParameters:parameters success:^(id responObject) {
        NSLog(@"首页%@",responObject);
        HomeInfoModel *model = [HomeInfoModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
        
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

@end
