//
//  SDTimeLineCellModel.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/2/25.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import "SDTimeLineCellModel.h"

#import <UIKit/UIKit.h>

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation SDTimeLineCellModel
{
    CGFloat _lastContentWidth;
}

@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _msgContent;
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"commentItemsArray":@"commentList",
             @"msgContent":@"content",
             @"name":@"nickname"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentItemsArray":@"SDTimeLineCellCommentItemModel"
             };
}


@end


@implementation SDTimeLineCellLikeItemModel




@end

@implementation SDTimeLineCellCommentItemModel
//@property (nonatomic, copy) NSString *commentString;
//
//@property (nonatomic, copy) NSString *firstUserName;
//@property (nonatomic, copy) NSString *firstUserId;
//
//@property (nonatomic, copy) NSString *secondUserName;
//@property (nonatomic, copy) NSString *secondUserId;
//
//@property (nonatomic, copy) NSAttributedString *attributedContent;


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"commentString":@"content",
             @"firstUserName":@"nickname",
             @"secondUserName":@"replyNickname"
             
             };
}
@end
