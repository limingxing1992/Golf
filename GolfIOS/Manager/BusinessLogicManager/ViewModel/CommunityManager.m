//
//  CommunityManager.m
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "CommunityManager.h"
#import "CommunityProcessor.h"
//#import "NSDictionary+Log.h"
#import "CommunityArticleModel.h"
#import "CommunityArticleCommentModel.h"
#import "CommunityUserDeailModel.h"
#import "CommunityPersonalUserDeailModel.h"
#import "CommunityMyCommentModel.h"
#import "SeverStatus.h"

@interface CommunityManager ()
/**processor*/
@property (nonatomic, strong) CommunityProcessor *processor;

@end

@implementation CommunityManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _processor = [[CommunityProcessor alloc] init];
    }
    return self;
}



#pragma mark - 社区帖子列表
- (void)getCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getCommunityArticleListWithParameters:(NSDictionary *)parameters success:^(id responObject) {
        NSLog(@"社区帖子列表%@",responObject);
        CommunityArticleModel *model = [CommunityArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 社区帖子评论列表
- (void)getCommunityArticleCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    
    [_processor getCommunityArticleCommentListWithParameters:parameters success:^(id responObject) {
        NSLog(@"社区帖子评论列表%@",responObject);
        CommunityArticleCommentModel *model = [CommunityArticleCommentModel mj_objectWithKeyValues:responObject];
        
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 用户信息
- (void)getcommunityUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getcommunityUserDeailWithParameters:parameters success:^(id responObject) {
//        NSLog(@"用户信息%@",responObject);
        CommunityUserDeailModel *model = [CommunityUserDeailModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 我的关注
- (void)getMyAttentionWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    
    [_processor getMyAttentionWithParameters:(NSDictionary *)parameters success:^(id responObject) {
//        NSLog(@"我的关注%@",responObject);
        CommunityArticleModel *model = [CommunityArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 个人空间信息
- (void)getCommunityPersonalUserDeailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    
    [_processor getCommunityPersonalUserDeailWithParameters:parameters success:^(id responObject) {
//        NSLog(@"个人空间信息%@",responObject);
        CommunityPersonalUserDeailModel *model = [CommunityPersonalUserDeailModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 用户社区帖子列表
- (void)getUserCommunityArticleListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getUserCommunityArticleListWithParameters:parameters success:^(id responObject) {
//        NSLog(@"用户社区帖子列表%@",responObject);
        CommunityArticleModel *model = [CommunityArticleModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
    
}

#pragma mark - 社区我的评价
- (void)getMyCommentListWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getMyCommentListWithParameters:parameters success:^(id responObject) {
//        NSLog(@"社区我的评价%@",responObject);
        CommunityMyCommentModel *model = [CommunityMyCommentModel mj_objectWithKeyValues:responObject];
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 社区发帖
- (void)addCommunityArticleWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addCommunityArticleWithParameters:parameters success:^(id responObject) {
//        NSLog(@"社区发帖=====%@",responObject);
        SeverStatus *model = [SeverStatus mj_objectWithKeyValues:responObject];
        
        responSuccess(model);
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 添加社区帖子评论
- (void)addCommunityArticleCommentWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addCommunityArticleCommentWithParameters:parameters success:^(id responObject) {
//        NSLog(@"添加社区帖子评论=====%@",responObject);
        if ([responObject[@"status"] isEqualToNumber:@1] ) {
            responSuccess(responObject);
        }else{
            responFailure(0,responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}



#pragma mark - 帖子详情
- (void)getCommunityArticleDetailWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor getCommunityArticleDetailWithParameters:parameters success:^(id responObject) {
        NSLog(@"帖子详情=====%@",responObject);
        if ([responObject[@"status"] isEqualToNumber:@1] ) {
            CommunityArticle *model = [CommunityArticle mj_objectWithKeyValues:responObject[@"data"]];
            responSuccess(model);
        }else{
            responFailure(0,responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

#pragma mark - 点赞/取消点赞
- (void)addCommunityLikeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    GOLFWeakObj(self);
    [_processor addCommunityLikeWithParameters:parameters success:^(id responObject) {
        NSLog(@"点赞/取消点赞=====%@",responObject);
        if ([responObject[@"status"] isEqualToNumber:@1] ) {
            responSuccess(responObject[@"data"][@"likeNum"]);//返回目前有多少赞
        }else{
            responFailure(0,responObject[@"showMessage"]);
        }
    } failure:^(NSError *error) {
        responFailure(error.code,[weakself analyticalHttpErrorDescription:error]);
    }];
}

@end
