//
//  QuysRunloopObserver.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/20.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysRunloopObserver : NSObject
- (void)addRunloopObserver:(CFRunLoopRef )runloopRef activity:(CFRunLoopActivity)activity;

@end

NS_ASSUME_NONNULL_END
