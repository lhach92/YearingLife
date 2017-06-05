//
//  PersonalAccountInfo.m
//  YearningLife
//
//  Created by boxfish on 2017/6/5.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "PersonalAccountInfo.h"

@implementation PersonalAccountInfo

@dynamic totalCount;
@dynamic result;
@dynamic user;
@dynamic costList;

+ (NSString *)parseClassName {
    return @"PersonalAccountInfo";
}

+ (void)load {
    [super load];
    [PersonalAccountInfo registerSubclass];
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
