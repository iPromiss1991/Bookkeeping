//
//  QuysLoadingIndicator.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/31.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoadingIndicator.h"
@implementation QuysLoadingIndicator

 - (void)requestWillStart:(id)request
{
    [MBProgressHUD showSuccessMessage:@"加载开始"];
}

- (void)requestWillStop:(id)request
{
    [MBProgressHUD showWarnMessage:@"显示警告"];

}

- (void)requestDidStop:(id)request
{
    [MBProgressHUD showInfoMessage:@"加载成功"];
}

@end
