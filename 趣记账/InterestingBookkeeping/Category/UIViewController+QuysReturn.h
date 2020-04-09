//
//  UIViewController+QuysReturn.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/31.
//  Copyright © 2020 Quys. All rights reserved.
//

 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (QuysReturn)
- (BOOL)goBack:(nullable void(^)(void))callBack;
@end

NS_ASSUME_NONNULL_END
