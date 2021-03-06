//
//  AccountInfo.m
//  YearningLife
//
//  Created by boxfish on 2017/6/5.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "AccountInfo.h"

@implementation AccountInfo

@dynamic totalCount;
@dynamic status;
@dynamic peronalAccountList;

+ (NSString *)parseClassName {
    return @"AccountInfo";
}

+ (void)load {
    [super load];
    [AccountInfo registerSubclass];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.totalCount = 0;
    }
    return self;
}


- (void)updateTotalCountByIncreaseCount:(CGFloat)increaseCount {
    [self incrementKey:@"totalCount" byAmount:@(increaseCount)];
}

@end
