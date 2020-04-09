
//
//  UIViewController+QuysReturn.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/31.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "UIViewController+QuysReturn.h"

 

@implementation UIViewController (QuysReturn)

- (BOOL)goBack:(void(^)(void))callBack
{
    if (self.navigationController.viewControllers.count > 1 )
    {
        [self.navigationController popToViewController:self animated:YES];
        if (callBack)
        {
            callBack();
        }
        return YES;
    }
    
    if (self.presentingViewController)
    {
        [self dismissViewControllerAnimated:YES completion:callBack];
        return YES;
    }
    
    return NO;//!< 说明当前控制器不是push 或者 model 出来的。（考虑：是否在其他window 上）
    
}
@end
