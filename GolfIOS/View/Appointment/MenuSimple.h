//
//  MenuSimple.h
//  MenuSimple
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 李明星. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSimpleDelegate <NSObject>
/** 切换排序*/
- (void)changeSortStyleWithIndex:(NSInteger)index style:(BOOL)isUp;

@end

@interface MenuSimple : UIView

@property (nonatomic, assign) id<MenuSimpleDelegate> delegate;


@end
