//
//  CostInfo.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "CostInfo.h"

@implementation CostInfo

@dynamic user;
@dynamic cost;
@dynamic costDescription;
@dynamic date;
@dynamic status;
@dynamic photo;

+ (NSString *)parseClassName {
    return @"CostInfo";
}

+ (void)load {
    [super load];
    [CostInfo registerSubclass];
}

@end
