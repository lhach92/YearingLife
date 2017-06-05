//
//  CostListTableViewCell.h
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *despLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
