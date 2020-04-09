//
//  QuysLoginService.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginService.h"
#import "QuysLoginApi.h"
@interface QuysLoginService()

@property (nonatomic,assign) BOOL isReadedUserAndPrivacyAgreement;//!<  是否勾选“用户&隐私协议”
@property (nonatomic,assign) BOOL isLegelPhoneNum;
@property (nonatomic,assign) BOOL isLegelVerifyCode;

@property (nonatomic,assign) NSInteger leftTimeIntervel;//!<  倒计时(默认 60s)
 
@end


@implementation QuysLoginService

- (void)loginByVerifyCodeWithcurrentVC:(UIViewController *)loginVC callBack:(nonnull QuysLoginFinishBlock)loginFinishBlock
{
    if (self.isLegelPhoneNum )
    {
        if (self.isReadedUserAndPrivacyAgreement)
        {
            //fire VerifyCode Api
            if (self.isLegelVerifyCode)
                   {
                       //fire login Api
                       QuysLoginApi *api = [QuysLoginApi new];
                       
                       [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                           [MBProgressHUD showTipMessageInView:@"请求完成"];
                           
                       } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                            [MBProgressHUD showTipMessageInView:@"服务器异常，请稍后再试!"];
                       }];
                        
                   }else
                   {
                       //VerifyCode illegal
                       [MBProgressHUD showTipMessageInView:@"验证码格式错误!"];
                   }
             
        }else
        {
            //ReadedUserAndPrivacyAgreement illegal
            [MBProgressHUD showTipMessageInView:@"请阅读并勾选相关政策和隐私!"];

        }
         
    }else
    {
        //phone illegal
        [MBProgressHUD showTipMessageInView:@"手机号码格式错误!"];
    }
    
}

- (void)loginByQuickPlatform:(QUYSLoginPlatformType)platform currentVC:(nonnull UIViewController *)loginVC callBack:(nonnull QuysLoginFinishBlock)loginFinishBlock
{
    
}

-(void)readedUserAndPrivacyAgreement:(BOOL)status
{
    self.isReadedUserAndPrivacyAgreement = status;
    //TODO:登陆后需更新该字段到 userModel
}

- (BOOL)isLegelPhoneNum
{
    return [[[self userPhoneNum] stringRemoveSeparator:@"-"] isMobileNumber];
}


- (BOOL)isLegelVerifyCode
{
    return [[[self verificationCode] stringRemoveSeparator:@" "] length] == 6?1:0;

}

#pragma mark - Init

- (NSInteger)leftTimeIntervel
{
    if (_leftTimeIntervel <= 0) {
        _leftTimeIntervel = 60;
    }return _leftTimeIntervel;
}

- (BOOL)isGoNextStep
{
    return self.isReadedUserAndPrivacyAgreement & self.isLegelVerifyCode &self.isLegelPhoneNum;
}

@end
