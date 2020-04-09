//
//  QuysStatusManager.h
//  趣记账
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuysLoginModel.h"
NS_ASSUME_NONNULL_BEGIN


/// 用户状态记录管理
@interface QuysStatusManager : NSObject

@property (nullable,nonatomic,strong)  QuysLoginModel *currentUser;





+ (instancetype)shareManager;


/// 登陆
- (void)login;


- (void)saveUserLoginInfo:(QuysLoginModel*)loginInfo;


- (void)logOutApp;


 @end

NS_ASSUME_NONNULL_END
