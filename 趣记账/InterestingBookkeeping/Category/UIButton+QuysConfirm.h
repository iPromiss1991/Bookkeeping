//
//  UIButton+QuysConfirm.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define defaultInterval .5//默认时间间隔
@interface UIButton (QuysConfirm)
@property (nonatomic, assign) NSTimeInterval resumeEventInterval;//延时时间(单位:s)
 @end

NS_ASSUME_NONNULL_END
