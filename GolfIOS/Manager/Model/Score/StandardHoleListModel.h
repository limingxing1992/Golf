//
//  StandardHoleLIstModel.h
//  GolfIOS
//
//  Created by yangbin on 16/12/27.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "BaseObject.h"
//标准杆数组模型
@interface StandardHoleListModel : BaseObject

/**data*/
@property (nonatomic, strong) NSArray *data;

@end

//标准杆
@interface StandardHole : NSObject;

/**洞编号*/
@property (nonatomic, strong) NSString *holeNumber;
/**洞id*/
@property (nonatomic, strong) NSNumber *ID;
/**标准杆数*/
@property (nonatomic, strong) NSNumber *par;

@end
