//
//  CostInfo.h
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface CostInfo : AVObject <AVSubclassing>

@property (nonatomic, strong) AVUser *user;
@property (nonatomic, assign) CGFloat cost;
@property (nonatomic, copy) NSString *costDescription;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) AVFile *photo;

@end
