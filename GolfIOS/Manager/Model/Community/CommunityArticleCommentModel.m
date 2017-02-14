//
//  CommunityArticleCommentModel.m
//  GolfIOS
//
//  Created by Rock on 2016/12/4.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "CommunityArticleCommentModel.h"
#import "SDTimeLineCellModel.h"

@implementation CommunityArticleCommentModel




@end


@implementation CommunityArticleCommentDataModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"dataList":@"CommunityArticleComment"
             
             };
}



@end

@implementation CommunityArticleComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"commentItemsArray":@"commentList",
             
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentItemsArray":@"SDTimeLineCellCommentItemModel"
             
             };
}



@end
