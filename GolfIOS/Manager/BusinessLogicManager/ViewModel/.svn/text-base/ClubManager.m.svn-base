//
//  ClubManager.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ClubManager.h"
#import "ClubProcessor.h"
//#import "NSDictionary+Log.h"
#import "ClubArticleModel.h"
#import "ClubArticleDetailModel.h"
#import "ClubArticleCommentModel.h"
#import "ClubIndexModel.h"
#import "SeverStatus.h"
#import "ClubIntroModel.h"
#import "ClubSysRecommendModel.h"
#import "Club.h"


@interface ClubManager ()

/**prosser*/
@property (nonatomic, strong) ClubProcessor *processor;

@end

@implementation ClubManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _processor = [[ClubProcessor alloc] init];
    }
    return self;
}


#pragma mark - 已推荐公告
- (void)getClubRecommendNoticeListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getClubRecommendNoticeListWithParameters:parameters success:^(id responObject) {
//        NSLog(@"已推荐公告%@",responObject);
        ClubArticleModel *clubArticleModel = [ClubArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(clubArticleModel);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}


#pragma mark - 发布公告或帖子
- (void)postClubArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor postClubArticleWithParameters:parameters success:^(id responObject) {
        NSLog(@"----------------%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
        
    } failure:^(NSError *error) {
       responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];

}

#pragma mark - 已加入俱乐部帖子和公告

- (void)getJoinedClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getJoinedClubArticleListWithParameters:parameters success:^(id responObject) {
        NSLog(@"已加入俱乐部帖子和公告%@",responObject);
        ClubArticleModel *clubArticleModel = [ClubArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(clubArticleModel);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}



#pragma mark - 帖子或公告详情
- (void)getCubArticleDetailWithParameters:(NSDictionary *)parameters Success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getCubArticleDetailWithParameters:parameters success:^(id responObject) {
        
        NSLog(@"帖子或公告详情%@",responObject);
        ClubArticleDetailModel *model = [ClubArticleDetailModel mj_objectWithKeyValues:responObject];
        
        responSuccess(model);
        
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 搜索帖子或公告
- (void)searchClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor searchClubArticleListWithParameters:parameters success:^(id responObject) {
        NSLog(@"搜索帖子和公告%@",responObject);
        ClubArticleModel *clubArticleModel = [ClubArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(clubArticleModel);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 俱乐部首页
- (void)getClubIndexWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getClubIndexWithParameters:parameters success:^(id responObject) {
        
        NSLog(@"俱乐部首页%@",responObject);
        ClubIndexModel *model = [ClubIndexModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
        
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 公告或帖子评论
- (void)getClubArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getClubArticleCommentListWithParameters:parameters success:^(id responObject) {
//        NSLog(@"公告或帖子评论%@",responObject);
        ClubArticleCommentModel *model = [ClubArticleCommentModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
        
        
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}


#pragma mark - 俱乐部帖子或公告列表
- (void)getClubArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getClubArticleListWithParameters:parameters success:^(id responObject) {
        
//        NSLog(@"俱乐部帖子或公告列表%@",responObject);
        ClubArticleModel *clubArticleModel = [ClubArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(clubArticleModel);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 申请加入俱乐部
- (void)getJoinClubWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getJoinClubWithParameters:parameters success:^(id responObject) {
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
        
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 俱乐部简介
- (void)getClubIntroWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    
    [_processor getClubIntroWithParameters:parameters success:^(id responObject) {
        NSLog(@"俱乐部简介%@",responObject);
        ClubIntroModel *model = [ClubIntroModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}


#pragma mark - 推荐的俱乐部
- (void)getSysRecommendedClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getSysRecommendedClubListWithParameters:parameters success:^(id responObject) {
        NSLog(@"推荐的俱乐部%@",responObject);
        ClubSysRecommendModel *model = [ClubSysRecommendModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 我的俱乐部(已加入)
- (void)getMyJoinClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getMyJoinClubListWithParameters:parameters success:^(id responObject) {
        NSLog(@"我的俱乐部(已加入)%@",responObject);
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            NSArray *modelArray = [Club mj_objectArrayWithKeyValuesArray:responObject[@"data"][@"dataList"]];
            
            
            responSuccess(modelArray);
        }else{
            responFailure(0, responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 我的俱乐部(所有)
- (void)getMyAllClubListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getMyAllClubListWithParameters:parameters success:^(id responObject) {
        NSLog(@"我的俱乐部(所有)%@",responObject);
        if ([responObject[@"status"] isEqualToNumber:@1]) {
            NSArray *modelArray = [Club mj_objectArrayWithKeyValuesArray:responObject[@"data"][@"dataList"]];
            
            
            responSuccess(modelArray);
        }else{
            responFailure(0, responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 添加帖子或公告评论
- (void)addClubArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addClubArticleCommentWithParameters:parameters success:^(id responObject) {
        
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 上传图片
- (void)upLoadImageWith:(NSArray *)imgs parameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    weak(self);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"currentAPI"], @"web/upload/uploadPictureFile.do"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<imgs.count; i++) {
            UIImage* tmpimg = imgs[i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString* filename = [NSString stringWithFormat:@"%@.png",str];//;
            NSData* imgdata = UIImageJPEGRepresentation(tmpimg, 0.25);
            [formData appendPartWithFileData:imgdata name:@"file" fileName:filename mimeType:@"image/png"];
            
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"status"] isEqualToNumber:@1]) {
            
            responSuccess(responseObject);
        }else{
            responFailure(0, responseObject[@"showMessage"]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        responFailure(error.code,[weakSelf analyticalHttpErrorDescription:error]);
    }];
}


@end
