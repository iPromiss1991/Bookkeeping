//
//  NSObject+QuysSwizzling.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QuysSwizzling)
+ (void)Wxh_swizzleInstanceMethodWithSrcClass:(Class)srcClass
                                      srcSel:(SEL)srcSel
                                 swizzledSel:(SEL)swizzledSel;
@end

NS_ASSUME_NONNULL_END
