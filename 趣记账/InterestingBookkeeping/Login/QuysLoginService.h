//
//  QuysLoginService.h
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>
//!<  登陆平台类型
typedef NS_ENUM(NSInteger,QUYSLoginPlatformType)
{
    QUYSLoginPlatformTypeQQ = 1,
    QUYSLoginPlatformTypeWEIXIN
};
NS_ASSUME_NONNULL_BEGIN

@interface QuysLoginService : NSObject
#pragma mark - Property
@property (nonatomic,copy) NSString *userPhoneNum;//!<   用户ID
@property (nonatomic,copy) NSString *verificationCode;//!<  验证码
@property (nonatomic,assign) BOOL isGoNextStep;


#pragma mark - Method

- (void)loginByVerifyCodeWithcurrentVC:(UIViewController*)loginVC callBack:(QuysLoginFinishBlock)loginFinishBlock;

- (void)loginByQuickPlatform:(QUYSLoginPlatformType)platform currentVC:(UIViewController*)loginVC callBack:(QuysLoginFinishBlock)loginFinishBlock;


- (void)readedUserAndPrivacyAgreement:(BOOL)status;


@end

NS_ASSUME_NONNULL_END
