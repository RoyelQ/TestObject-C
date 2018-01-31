//
//  QJKeyBoard.h
//  JHHQB
//
//  Created by jinrongweidian on 17/3/27.
//  Copyright © 2017年 我爱微点. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QJKeyBoard;

@protocol QJKeyBoardDelegate <NSObject>
@optional

- (void)keyboard:(QJKeyBoard *)keyboard didClickButton:(UIButton *)textBtn withFieldString:(NSMutableString *)string;

@end

@interface QJKeyBoard : UIInputView <QJKeyBoardDelegate, UIInputViewAudioFeedback>

@property (nonatomic, strong) NSMutableString *string;

@property (weak, nonatomic) id <QJKeyBoardDelegate> delegate;

@end



