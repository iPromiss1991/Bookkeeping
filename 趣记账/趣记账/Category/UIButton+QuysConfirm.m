//
//  UIButton+QuysConfirm.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "UIButton+QuysConfirm.h"
#import <objc/runtime.h>

@interface UIButton()
@property (nonatomic,assign) NSTimeInterval acceptEventTime;
@end



@implementation UIButton (QuysConfirm)


#pragma mark -延时响应
+ (void)load
{
    
    SEL oldSelector = @selector(sendAction:to:forEvent:);
    SEL newSelector = @selector(wxh_resume_sendAction:to:forEvent:);
    
    Method oldMethod = class_getInstanceMethod(self, oldSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    
    if (class_addMethod(self,
                        oldSelector,
                        method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod))) {
        class_replaceMethod(self,
                            newSelector,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}
- (void)wxh_resume_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([NSDate date].timeIntervalSince1970 - self.acceptEventTime  < self.resumeEventInterval)
    {
        return ;
    }
    
    
    if (self.resumeEventInterval > 0)
    {
        self.acceptEventTime = [NSDate date].timeIntervalSince1970;
    }
    [self wxh_resume_sendAction:action to:target forEvent:event];

}




- (void)setResumeEventInterval:(NSTimeInterval)resumeEventInterval
{
    objc_setAssociatedObject(self, @selector(resumeEventInterval), @(resumeEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)resumeEventInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}



- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime
{
    objc_setAssociatedObject(self, @selector(acceptEventTime), @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)acceptEventTime
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}


 

@end
