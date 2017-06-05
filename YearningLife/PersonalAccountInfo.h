//
//  PersonalAccountInfo.h
//  YearningLife
//
//  Created by boxfish on 2017/6/5.
//  Copyright © 2017年 LH. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface PersonalAccountInfo : AVObject <AVSubclassing>

@property (nonatomic, assign) CGFloat totalCount;
@property (nonatomic, assign) CGFloat result;
@property (nonatomic, strong) AVUser *user;
@property (nonatomic, strong) AVRelation *costList;

- (void)updateTotalCountByIncreaseCount:(CGFloat)increaseCount;

@end
