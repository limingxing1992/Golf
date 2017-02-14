//
//  AppointmentPlaceManager.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/30.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "AppointmentPlaceManager.h"
#import "AppointmentPlaceProcessor.h"

@interface AppointmentPlaceManager ()

@property (nonatomic, strong) AppointmentPlaceProcessor *processor;

@end

@implementation AppointmentPlaceManager

- (instancetype)init{
    self = [super init];
    if (self) {
        _processor = [[AppointmentPlaceProcessor alloc] init];
    }
    return self;
}

- (void)postAppointmentPlaceListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentPlaceListWithParameters:parameters success:^(id responObject) {
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            NSMutableArray *data = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in responObject[@"data"][@"dataList"]) {
                
                PlaceItemModel *model = [PlaceItemModel mj_objectWithKeyValues:dict];
                [data addObject:model];
            }
            responSuccess(data);
        }else{
            responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
    }];
}

- (void)postAppointmentPlaceIntroduceWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentPlaceIntroduceWithParameter:parameters success:^(id responObject) {
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            responSuccess(responObject[@"data"]);
        }else{
            responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
    }];
}

- (void)postAppointmentPlaceDetailWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentPlaceDetailWithParameter:parameters success:^(id responObject) {
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            PlaceDetailModel *model = [PlaceDetailModel mj_objectWithKeyValues:responObject[@"data"]];
            responSuccess(model);
        }else{
            responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(0, [weakself analyticalHttpErrorDescription:error]);
    }];
}

- (void)postAppointmentPlaceSubmitWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentPlaceSubmitWithParameter:parameters
                                                success:^(id responObject) {
                                                    if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                        responSuccess(responObject[@"data"][@"orderNo"]);
                                                    }else{
                                                        responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                    }

                                                } failure:^(NSError *error) {
                                                    responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                }];
}

- (void)postAppointmentPlaceCommentListWithParameter:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postAppointmentPlaceCommentListWithParameter:parameters
                                                     success:^(id responObject) {
                                                         if ([responObject[@"status"] isEqualToNumber:@1]) {
                                                             NSDictionary *dict = responObject[@"data"];
                                                             PlaceCommentModel *model = [PlaceCommentModel mj_objectWithKeyValues:dict];
                                                             responSuccess(model);
                                                         }else{
                                                             responFailure([responObject[@"status"] integerValue],responObject[@"showMessage"]);
                                                         }

                                                     } failure:^(NSError *error) {
                                                         responFailure(0, [weakself analyticalHttpErrorDescription:error]);
                                                     }];
}
@end
