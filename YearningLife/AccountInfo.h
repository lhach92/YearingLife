//
//  AccountInfo.h
//  YearningLife
//
//  Created by boxfish on 2017/6/5.
//  Copyright © 2017年 LH. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface AccountInfo : AVObject

@property (nonatomic, assign) CGFloat totalCount;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) AVRelation *peronalAccountList;

- (void)updateTotalCountByIncreaseCount:(CGFloat)increaseCount;

@end
