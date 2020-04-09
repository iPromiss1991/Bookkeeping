//
//  QuysWebviewVC.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/30.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysWebviewVC : UIViewController
- (instancetype)initWithUrl:(NSString *)requestUrl;

- (instancetype)initWithHtml:(NSString *)html;
@end

NS_ASSUME_NONNULL_END
