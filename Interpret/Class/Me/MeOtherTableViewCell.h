//
//  MeOtherTableViewCell.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeOtherTableViewCell : UITableViewCell

+ (id)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

- (void)setData: (NSIndexPath *)indexPath;



@end
