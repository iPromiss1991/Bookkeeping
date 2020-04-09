//
//  QuysStatusManager.m
//  趣记账
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysStatusManager.h"
#import "QuysLoginWindow.h"
@interface QuysStatusManager()
@property (nonatomic,strong) QuysLoginWindow *loginWindow;

@end


@implementation QuysStatusManager

+ (instancetype)shareManager
{
    static QuysStatusManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    
    return manager;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [QuysStatusManager shareManager] ;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [QuysStatusManager shareManager] ;
}


#pragma mark - Priave Method


- (void)login
{
    
    kWeakSelf(self)
    if (self.currentUser)
    {
         //非第一次使用App
        switch (self.currentUser.loginStatus) {
            case QuysUserStatusNoneLogin:
                {
                    //未登录
                    QuysLoginWindow *loginWindow = [[QuysLoginWindow alloc] init];
                    [loginWindow makeKeyAndVisible];
                    weakself.loginWindow  =loginWindow;
                }
                break;
            case QuysUserStatusLogined:
                {
                    //账号密码登陆（未设置手势）
                    QuysLoginWindow *loginWindow = [[QuysLoginWindow alloc] init];
                    [loginWindow makeKeyAndVisible];
                    weakself.loginWindow  =loginWindow;
                }
                break;
            case QuysUserStatusGesture:
            {
                //登陆&设置手势
                QuysLoginWindow *loginWindow = [[QuysLoginWindow alloc] init];
                [loginWindow makeKeyAndVisible];
                weakself.loginWindow  =loginWindow;

            }
            break;
            default:
                break;
        }
        
    }else
    {
        //第一次使用App(去注册 Or 登陆)
        QuysLoginWindow *loginWindow = [[QuysLoginWindow alloc] init];
        [loginWindow makeKeyAndVisible];
        weakself.loginWindow  =loginWindow;
    }
    
}

- (void)saveUserLoginInfo:(QuysLoginModel *)loginInfo
{
    self.currentUser = loginInfo;
    //TODO:save to DB：进入主界面
    
    
}

- (void)logOutApp
{
    self.currentUser.loginStatus = QuysUserStatusNoneLogin;
    //TODO:退出APP账号==>进入登陆页
    
}


- (QuysLoginModel*)findUser
{
    QuysLoginModel *logingModel = nil;
    //TODO:数据库查询
    
    return logingModel;
}

- (QuysLoginModel *)currentUser
{
    if (_currentUser == nil) {
        _currentUser = [self findUser];
    }return _currentUser;
}

@end
