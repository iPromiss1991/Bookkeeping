//
//  AppDelegate.m
//  趣记账
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
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setUpConfig
{
    QuysStatusManager *manager = [QuysStatusManager shareManager];
    [manager login];
 }
 

@end
