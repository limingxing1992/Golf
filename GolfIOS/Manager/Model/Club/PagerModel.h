//
//  PagerModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/2.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PagerModel : NSObject

/**当前页*/
@property (nonatomic, strong) NSNumber *currentPage;
/**pageSize*/
@property (nonatomic, strong) NSNumber *pageSize;
/**startRow*/
@property (nonatomic, strong) NSNumber *startRow;
/**totalPage*/
@property (nonatomic, strong) NSNumber *totalPage;
/**totalRecord*/
@property (nonatomic, strong) NSNumber *totalRecord;

@end
