//
//  QuysIconModel.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WXHThirdPatrPlatformType) {
    WXHThirdPatrPlatformTypeQQ = 1,
    WXHThirdPatrPlatformTypeWeiXin
};//第三方平台

NS_ASSUME_NONNULL_BEGIN

@interface QuysIconModel : NSObject
@property (nonatomic,copy) NSString *platformName;
@property (nonatomic,copy) NSString *iconName;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,assign) WXHThirdPatrPlatformType platform;

@end

NS_ASSUME_NONNULL_END
