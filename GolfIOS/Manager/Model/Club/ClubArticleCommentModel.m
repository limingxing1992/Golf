//
//  ClubArticleCommentModel.m
//  GolfIOS
//
//  Created by yangbin on 16/12/5.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "ClubArticleCommentModel.h"
#import "SDTimeLineCellModel.h"

@implementation ClubArticleCommentModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"data":@"ClubArticleComment"
             };
}

@end

@implementation ClubArticleComment

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"commentItemsArray":@"commentList",
//             @"msgContent":@"content",
//             @"name":@"nickname"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentItemsArray":@"SDTimeLineCellCommentItemModel"
             
             };
}
@end

