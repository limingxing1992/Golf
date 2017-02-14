//
//  STL_SegementControl.h
//  GolfIOS
//
//  Created by 李明星 on 2016/11/2.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollItem;

@protocol STL_SegementControlDelegate <NSObject>

@optional
- (void)selectByIndex:(NSInteger)index;
-(void)beginScrollerFormPosintion:(NSInteger)position;
-(void)endScrollerFormPosintion:(NSInteger)position;

@end

@interface STL_SegementControl : UIControl

@property (nonatomic,strong) NSArray<ScrollItem       *> * items;
@property (nonatomic,assign) NSInteger         position;//default 0;
@property (nonatomic,assign) CGFloat           inset;// default(0)
@property (nonatomic,assign) CGFloat           cornerRadius;// default(5)
@property (nonatomic,strong) UIColor           *selectionColor; //default [UIColor orangeColor]
@property(nonatomic,assign) id<STL_SegementControlDelegate> delegat;

/** 代码滑动*/
- (void)setIndex:(NSInteger)index;
@end



@interface ScrollItem : NSObject;
@property (nonatomic,copy  ) NSString          * item_Name;
@property (nonatomic,strong) UIColor           * title_norml_Color;
@property (nonatomic,strong) UIColor           * title_selected_Color;
-(id)initWithItem_Name:(NSString *)item_Name
     title_norml_Color:(UIColor *)title_norml_Color
   tile_selected_Color:(UIColor *)tile_selected_Color;
@end
