//
//  QJLoanMoneyCell.h
//  JHH
//
//  Created by jinrongweidian on 16/11/14.
//  Copyright © 2016年 金融微店. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJLoanMoneyCell : UITableViewCell

@property (nonatomic, assign) NSInteger loanCount;

@property (weak, nonatomic) IBOutlet UILabel *loanMoneyLabel;

@property (nonatomic, copy) void(^loanMoneyBlock)(NSString *loanMoney);

- (void)setUpLoanMoney:(NSString *)loanMoney;

@end
