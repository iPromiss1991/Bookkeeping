//
//  QuysLoginVC.h
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysLoginVC : UIViewController
@property (nonatomic,copy) QuysLoginFinishBlock  loginFinishBlock;
@property (nonatomic,weak) UIWindow  *parentWindow;
@end

NS_ASSUME_NONNULL_END
