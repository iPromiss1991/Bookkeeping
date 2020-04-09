//
//  QuysLoginModel.h
//  趣记账
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,QuysUserStatus) {
    QuysUserStatusNoneRigester,//!<  未注册
    QuysUserStatusNoneLogin, //!<  未登录
    QuysUserStatusLogined,//!<  账号密码登陆
    QuysUserStatusGesture //!<  登陆且设置了手势密码
};

NS_ASSUME_NONNULL_BEGIN

@interface QuysLoginModel : NSObject
@property (nonatomic,assign) QuysUserStatus loginStatus;//!<  用户状态
@property (nonatomic,copy) NSString *gesture;//!<  手势
@property (nonatomic,copy) NSString *userID;//!<  用户ID
 


 
@end

NS_ASSUME_NONNULL_END
