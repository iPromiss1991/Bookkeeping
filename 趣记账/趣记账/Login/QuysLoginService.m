//
//  QuysLoginService.m
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginService.h"
@interface QuysLoginService()

@property (nonatomic,assign) BOOL isLegalPhoneNum;
@property (nonatomic,assign) BOOL isLegalverificationCode;
@property (nonatomic,assign) BOOL isReadedUserAndPrivacyAgreement;//!<  是否勾选“用户&隐私协议”

@property (nonatomic,assign) NSInteger leftTimeIntervel;//!<  倒计时(默认 60s)
 
@end


@implementation QuysLoginService

- (void)loginByVerifyCode
{
    if (self.isLegalPhoneNum)
    {
        if (self.isReadedUserAndPrivacyAgreement)
        {
            //fire VerifyCode Api
            if (self.isLegalverificationCode)
                   {
                       //fire login Api
                       
                        
                   }else
                   {
                       //VerifyCode illegal
                   }
             
        }else
        {
            //ReadedUserAndPrivacyAgreement illegal
        }
         
    }else
    {
        //phone illegal
    }
    
}

- (void)loginByQuickPlatform:(QUYSLoginPlatformType)platform
{
    
}

-(void)readedUserAndPrivacyAgreement:(BOOL)status{
    self.isReadedUserAndPrivacyAgreement = status;
}


#pragma mark - Init

- (NSInteger)leftTimeIntervel
{
    if (_leftTimeIntervel <= 0) {
        _leftTimeIntervel = 60;
    }return _leftTimeIntervel;
}



@end
