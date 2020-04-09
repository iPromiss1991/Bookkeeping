//
//  QuysLoginConfigModel.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysLoginConfigModel : NSObject
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *placeholder;

@property (nonatomic,strong) NSString *value;
@property (nonatomic,strong) NSString *key;

@property (nonatomic,assign) BOOL postVerifyCodeEnable;


@end

NS_ASSUME_NONNULL_END
