//
//  MeOtherTableViewCell.m
//  NewTest
//
//  Created by 乔杰 on 2018/1/19.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "MeOtherTableViewCell.h"

@interface MeOtherTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIImageView *morwInfoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation MeOtherTableViewCell

+ (NSString *)cellIdentifier{
    
    static NSString *cellId = @"MeOtherTableViewCell";
    
    return cellId;
}

+ (id)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self cellIdentifier]];
    
    MeOtherTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:[MeOtherTableViewCell cellIdentifier] forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MeOtherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifier]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setupSubViews];
    
    return cell;
}

- (void)setupSubViews {
    
    self.iconImageView = [[UIImageView alloc] init];
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = Main_text_color;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
  
    self.morwInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_more"]];
//    self.morwInfoImageView.hidden = YES;
    [self addSubview: self.morwInfoImageView];
    
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.hidden = YES;
    self.descriptionLabel.textColor = Main_text_color_gray;
    self.detailTextLabel.textAlignment = NSTextAlignmentRight;
    self.descriptionLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.descriptionLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = Seperator_line_color;
    [self addSubview: self.lineView];
}


- (void)layoutSubviews {
    
    self.iconImageView.frame = CGRectMake(10, (VIEW_HEIGHT(self) - AdaptX(20)/2.0), AdaptX(20), AdaptX(20));

    self.morwInfoImageView.frame = CGRectMake(VIEW_WIDTH(self) - AdaptX(16), (VIEW_HEIGHT(self) - AdaptX(16))/2.0, AdaptX(8), AdaptX(16));

    self.titleLabel.frame = CGRectMake(VIEW_RIGHT(self.iconImageView) + 5, (VIEW_HEIGHT(self) - AdaptX(30))/2.0, AdaptX(100), AdaptX(30));
    
    self.descriptionLabel.frame = CGRectMake(VIEW_LEFT(self.morwInfoImageView) - 5, (VIEW_HEIGHT(self) - AdaptX(20))/2.0, AdaptX(160), AdaptX(20));

    self.lineView.frame = CGRectMake(10, VIEW_HEIGHT(self) - 0.5, VIEW_WIDTH(self) - 10, 0.5);
}


- (void)setData: (NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        self.titleLabel.text = @"主题管理";
    }else if (indexPath.row == 1) {
        
        self.titleLabel.text = @"密码管理";
    }else if (indexPath.row == 2) {
        
        self.titleLabel.text = @"地图管理";
    }else if (indexPath.row == 3) {
        
        self.titleLabel.text = @"扫码管理";
    }else if (indexPath.row == 4) {
        
        self.titleLabel.text = @"语音识别";
    }
}



@end
