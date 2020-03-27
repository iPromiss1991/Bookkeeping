//
//  NSString+QuysHelper.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (QuysHelper)

 


//是否是子串
- (BOOL)isContainSubString:(NSString *)subString;

//是否是表情
- (BOOL)stringContainsEmoji;

//是否是手机号
- (BOOL)isMobileNumber;

//是否是电话号码
//- (BOOL)isFixPhoneNumber;

//是否是邮箱
- (BOOL)isAvailableEmail;

//是否是纯数字
- (BOOL)isNumText;
/**
 是否是身份证
 */
- (BOOL)isIdentityNumber;

//最多显示两位小数
+(NSString *)returnActualFormatNumber:(double)number;

//保留几位小数
+(NSString *)returnDetailFormatNumber:(double)number leaveCount:(NSInteger)count;

//设置富文本
+ (NSMutableAttributedString *)setNbLabelTextProperty:(NSString *)text
                                               string:(NSString *)string
                                            textColor:(UIColor *)color
                                             textFont:(UIFont *)font;

+ (NSMutableAttributedString *)attributeStringWithText:(NSString *)text
                                         withLineSpace:(CGFloat )lineSpace
                                     withLineBreakMode:(NSLineBreakMode )lineBreakMode
                                              withFont:(UIFont *)font;

+ (NSMutableAttributedString *)attributebLabelText:(NSString *)text
                                        withTextColor:(UIColor *)textColor
                                        withLineSpace:(CGFloat)lineSpace
                                         withTextFont:(UIFont *)textFont
                                 withExtraStringArray:(NSArray *)extraStringArr
                                  withExtraColorArray:(NSArray *)extraColorArr
                                   withExtraFontArray:(NSArray *)extraFont;
/**
 是否是身份证
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

//是否有空格
- (BOOL)isHaveSpaceInString;

//是否有中文字符
- (BOOL)isHaveChineseInString;

//是否是url
- (BOOL)isWebUrlStr;


/// 移除空格
-(NSString *)stringRemoveBlank;


- (NSInteger)getStringLenthOfBytes;

- (NSString *)subBytesOfstringToIndex:(NSInteger)index;

@end

 
NS_ASSUME_NONNULL_END
