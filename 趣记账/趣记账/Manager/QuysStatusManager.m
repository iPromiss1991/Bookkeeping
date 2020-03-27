//
//  QuysStatusManager.m
//  趣记账
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysStatusManager.h"
@interface QuysStatusManager()

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
    
    if (self.currentUser)
    {
         //非第一次使用App
        switch (self.currentUser.loginStatus) {
            case QuysUserStatusNoneLogin:
                {
                    //未登录
                    
                }
                break;
            case QuysUserStatusLogined:
                {
                    //账号密码登陆
                }
                break;
            case QuysUserStatusGesture:
            {
                //登陆&设置手势
            }
            break;
            default:
                break;
        }
        
    }else
    {
        //第一次使用App(去注册 Or 登陆)
        
    }
    
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
