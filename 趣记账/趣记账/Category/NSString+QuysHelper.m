//
//  NSString+QuysHelper.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "NSString+QuysHelper.h"
@implementation NSString (QuysHelper)

 

- (BOOL)isContainSubString:(NSString *)subString{
    
    if([self rangeOfString:subString].location != NSNotFound)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    if ([@"➋➌➍➎➏➐➑➒" isContainSubString:self]) {
        
        returnValue = NO;
    }
    return returnValue;
}

//- (BOOL)isMobileNumber
//{
//    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
//    return [phoneTest evaluateWithObject:self];
//}

- (BOOL)isMobileNumber
{
    if (self.length != 11)
    {
        return NO;
    }
    return YES;
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|73||8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isWebUrlStr{
    
  
    if (self.length == 0)
    {
        return NO;
    }
    NSString * urlStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@;#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@;#$%^&*+?:_/=<>]*)?)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlStr];
    
    if ([regextestmobile evaluateWithObject:self] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
   
}

- (BOOL)isAvailableEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isIdentityNumber{
    NSString *phoneRegex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *identityTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [identityTest evaluateWithObject:self];
}


- (BOOL)isNumText{
    
    //判断是不是纯数字
    [NSCharacterSet decimalDigitCharacterSet];
    if ([[self stringByTrimmingCharactersInSet: [NSCharacterSet decimalDigitCharacterSet]] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]].length >0) {
        return NO;
    }else{
        return YES;
    }

}


+(NSString *)returnActualFormatNumber:(double)number
{
//    NSString *thirdNum = [NSString stringWithFormat:@"%0.3f",number];
//    number = [thirdNum doubleValue];
    
    //最多保留两位小数
    number = round(number*100)/100;
    
    NSArray *numArray =[[NSString stringWithFormat:@"%.2f",number] componentsSeparatedByString:@"."];
    
    NSString *firstNum =[numArray firstObject];
    NSString *secondNum =[numArray lastObject];
    
    if ([secondNum doubleValue] == 0) {
        
        return firstNum;
    }
    else
    {
        if ([[secondNum substringFromIndex:1] doubleValue] != 0) {
            
            return [NSString stringWithFormat:@"%.2f",number];
        }
        else{
            
            return [NSString stringWithFormat:@"%.1f",number];
        }
    }
    return nil;
}

+(NSString *)returnDetailFormatNumber:(double)number leaveCount:(NSInteger)count{

    number = round(number*100)/100;
    
    NSArray *numArray =[[NSString stringWithFormat:@"%@",@(number)] componentsSeparatedByString:@"."];
    
    NSString *firstNum =[numArray firstObject];
    NSString *secondNum =[numArray lastObject];
    
    if ([secondNum doubleValue] == 0) {
        
        return firstNum;
    }
    else{
    
        NSString *subSecondStr = [secondNum substringToIndex:count];
        
        return [NSString stringWithFormat:@"%@.%@",firstNum,subSecondStr];
    }
    return nil;
}


+ (NSMutableAttributedString *)setNbLabelTextProperty:(NSString *)text
                                               string:(NSString *)string
                                            textColor:(UIColor *)color
                                             textFont:(UIFont *)font
{
    NSRange range;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    
    if (string != nil && ![string isEqualToString:@""]) {
        range = [text rangeOfString:string];
    }else{
        range = NSMakeRange(0, 0);
    }
    
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    return str;
}

+ (NSMutableAttributedString *)attributeStringWithText:(NSString *)text withLineSpace:(CGFloat )lineSpace withLineBreakMode:(NSLineBreakMode )lineBreakMode withFont:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle =[[NSMutableParagraphStyle  alloc]init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    NSMutableAttributedString *attributeStr =[[NSMutableAttributedString alloc]initWithString:text
                                                                                   attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle}];
    return attributeStr;
}

+ (NSMutableAttributedString *)attributebLabelText:(NSString *)text
                                        withTextColor:(UIColor *)textColor
                                        withLineSpace:(CGFloat)lineSpace
                                         withTextFont:(UIFont *)textFont
                                 withExtraStringArray:(NSArray *)extraStringArr
                                  withExtraColorArray:(NSArray *)extraColorArr
                                   withExtraFontArray:(NSArray *)extraFont;
{
    if (!kISNullString(text)) {
        
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, text.length)];
        [attributeStr addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, text.length)];
        
        NSMutableParagraphStyle * paragraphStyle =[[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [paragraphStyle setLineSpacing:lineSpace];
        [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        
        for (int i=0; i< extraStringArr.count; i++) {
            
            NSString * str = extraStringArr[i];
            NSRange range = [text rangeOfString:str];
            [attributeStr addAttribute:NSForegroundColorAttributeName value:extraColorArr[i] range:range];
            [attributeStr addAttribute:NSFontAttributeName value:extraFont[i] range:range];
        }
        return attributeStr;
    }
    
    return nil;
}

+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (BOOL)isHaveSpaceInString
{
    NSRange _range = [self rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)isHaveChineseInString
{
    for(NSInteger i = 0; i < [self length]; i++){
        
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

-(NSString *)stringRemoveBlank{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (NSInteger)getStringLenthOfBytes
{
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s]) {
            
            NSLog(@" s 打印信息:%@",s);
            
            length +=2;
        }else{
            length +=1;
        }
        
        NSLog(@" 打印信息:%@  %ld",s,(long)length);
    }
    return length;
}

- (NSString *)subBytesOfstringToIndex:(NSInteger)index
{
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self validateChineseChar:s])
        {
            if (length + 2 > index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=2;
            
            chineseNum +=1;
        }
        else
        {
            if (length +1 >index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}

//检测中文或者中文符号
- (BOOL)validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


@end


