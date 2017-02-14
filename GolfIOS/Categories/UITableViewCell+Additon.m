//
//  UITableViewCell+Additon.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UITableViewCell+Additon.h"

@implementation UITableViewCell (Additon)
-(UITableViewCell *)setCell:(UITableViewCell*)cell textFont:(UIFont*)font textColor:(UIColor*)color  detailtextFont:(UIFont*)detailFont  detailTextColor:(UIColor*)detailTextColor accessoryViewImage:(NSString*)imageName {
    //消除选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = font;
    cell.textLabel.textColor = color;
    cell.accessoryView = [[UIImageView alloc] initWithImage:IMAGE(imageName)];
    cell.detailTextLabel.textColor = detailTextColor;
    cell.detailTextLabel.font = detailFont;
    
    return cell;
}
@end
