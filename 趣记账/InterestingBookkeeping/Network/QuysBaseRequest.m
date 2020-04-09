//
//  QuysBaseRequest.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/31.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysBaseRequest.h"
#import "QuysLoadingIndicator.h"
@implementation QuysBaseRequest
- (void)start
{
    [self addIndicator];
    [super start];
}

-(void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
    [self addIndicator];
    [super startWithCompletionBlockWithSuccess:success failure:failure];
}

- (void)addIndicator
{
    QuysLoadingIndicator *indicator = [QuysLoadingIndicator new];
    [self addAccessory:indicator];
}
@end
