//
//  AppDelegate.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "AppDelegate.h"
#import "QuysViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    QuysViewController *rootVC = [[QuysViewController alloc] init];
    self.window.rootViewController = rootVC;
    [self loginAndSetupConfig];
    [self keyboardSetting];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loginAndSetupConfig
{
    QuysStatusManager *manager = [QuysStatusManager shareManager];
    [manager login];
    
 }
 

- (void)keyboardSetting
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];

    //控制整个功能是否启用。

    manager.enable=YES;

    manager.overrideKeyboardAppearance=YES;

    //控制点击背景是否收起键盘

    manager.shouldResignOnTouchOutside=YES;

    //    //控制键盘上的工具条文字颜色是否用户自定义。注意这个颜色是指textfile的tintcolor

    //    manager.shouldToolbarUsesTextFieldTintColor = YES;

    //    //中间位置是否显示占位文字(默认是YES)

    //    manager.shouldShowTextFieldPlaceholder = YES;

    //    //设置占位文字的字体大小

    manager.placeholderFont= [UIFont boldSystemFontOfSize:18];


}

@end
