//
//  MyMessageSendPraiseCell.h
//  GolfIOS
//
//  Created by wyao on 16/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyMessageSendPraiseCell,CommunityArticle;

@protocol MyMessageSendPraiseCellDelegate <NSObject>
@optional
- (void)MyMessageSendPraiseCellDelegate:(MyMessageSendPraiseCell *)cell nameLabelDidClick:(NSString *)name;

@end


@interface MyMessageSendPraiseCell : UITableViewCell

/**model*/
@property (nonatomic, strong) CommunityArticle *model;

/**delegate*/
@property (nonatomic, assign) id<MyMessageSendPraiseCellDelegate> delegate;



@end
