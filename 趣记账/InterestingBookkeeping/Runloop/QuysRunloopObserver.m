//
//  QuysRunloopObserver.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/20.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysRunloopObserver.h"

@implementation QuysRunloopObserver


- (void)addRunloopObserver:(CFRunLoopRef )runloopRef activity:(CFRunLoopActivity)activity
{
    /*
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),
     kCFRunLoopBeforeTimers = (1UL << 1),
     kCFRunLoopBeforeSources = (1UL << 2),
     kCFRunLoopBeforeWaiting = (1UL << 5),
     kCFRunLoopAfterWaiting = (1UL << 6),
     kCFRunLoopExit = (1UL << 7),
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, activity, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
            {
                NSLog(@"kCFRunLoopEntry");
            }
                break;
            case kCFRunLoopBeforeTimers:
            {
                NSLog(@"kCFRunLoopBeforeTimers");
            }
                break;
            case kCFRunLoopBeforeSources:
            {
                NSLog(@"kCFRunLoopBeforeSources");
            }
                break;
            case kCFRunLoopBeforeWaiting:
            {
                NSLog(@"kCFRunLoopBeforeWaiting");
            }
                break;
            case kCFRunLoopAfterWaiting:
            {
                NSLog(@"kCFRunLoopAfterWaiting");
            }
                break;
            case kCFRunLoopExit:
            {
                NSLog(@"kCFRunLoopExit");
            }
                break;
            case kCFRunLoopAllActivities:
            {
                NSLog(@"kCFRunLoopAllActivities");
            }
                break;
            default:
                break;
        }
    });
    CFRunLoopAddObserver( runloopRef, observer, kCFRunLoopCommonModes);
}

- (void)dealloc
{
    NSLog(@"<<<%@ delloc",[self class]);
}
@end
