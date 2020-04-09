
//
//  UITextField+QuysPhoneNumFormat.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//
#define kDLETTER     @"abcdefghijklmnopqresuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define kDNUMBERS     @"0123456789"

static  NSInteger kMaxlenth = NSIntegerMax;

#import "UITextField+QuysFormat.h"
#import <objc/runtime.h>


@implementation UITextField (QuysFormat)


- (BOOL)valueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range
{
    switch (self.textFieldType)
    {
        case WXHTextFieldStringTypeNone:
        {
            [self textFieldStringTypeNone:string];
        }
            break;
        case WXHTextFieldStringTypePhoneNumber:
        {
            return  [self textFieldStringTypePhoneNumber:string inRange:range];
        }
            break;
        case WXHTextFieldStringTypeNumber:
        {
            return  [self textFieldStringTypeNumber:string];
        }
            break;
            
        case WXHTextFieldStringTypeLetter:
        {}
            break;
        default:
            break;
    }
    return YES;
}


/**
 输入类型验证
 
 @param aStr 输入字符串
 @param format 验证格式
 @return BOOL
 */
- (BOOL)inputTypeVerification:(NSString *)aStr format:(NSString *)format{
    NSCharacterSet* filterCS = [[NSCharacterSet characterSetWithCharactersInString:format] invertedSet];
    NSString *filterString = [[aStr componentsSeparatedByCharactersInSet:filterCS] componentsJoinedByString:@""];
    
    return [aStr isEqualToString:filterString];
}
//https://www.jianshu.com/p/5fb58dc73e7b



/**
 无限制（可以输入任何类型）
 */
- (BOOL)textFieldStringTypeNone:(NSString *)stringReplacement
{
    return YES;
}

/**
 只能输入电话号码（格式化电话号码）
 */
- (BOOL)textFieldStringTypePhoneNumber:(NSString *)stringReplacement inRange:(NSRange)range
{
    
    if ([self inputTypeVerification:stringReplacement format:kDNUMBERS])
    {
        NSMutableString *strTemp  = [self.text mutableCopy];
        
        if ([stringReplacement isEqualToString:@""])
        {
            strTemp = [[strTemp substringToIndex:range.location] mutableCopy];
            strTemp = [[strTemp stringRemoveSeparator:@"-"] mutableCopy];
                       if (strTemp.length <= 3)
                       {
                           self.text = strTemp;
                           return NO;
                       }else if (strTemp.length <= 7)
                       {
                           [strTemp insertString:@"-" atIndex:3];
                           self.text = strTemp;
                           return NO;
                       }else if (strTemp.length <= 11)
                       {
                           [strTemp insertString:@"-" atIndex:3];
                           [strTemp insertString:@"-" atIndex:8];
                           self.text = strTemp;
                           return NO;
                       }else
                       {
                           return NO;
                       }
        }else
        {
            [strTemp insertString:stringReplacement atIndex:range.location];
            
            strTemp = [[strTemp stringRemoveSeparator:@"-"] mutableCopy];
            if (strTemp.length <= 3)
            {
                self.text = strTemp;
                return NO;
            }else if (strTemp.length <= 7)
            {
                [strTemp insertString:@"-" atIndex:3];
                self.text = strTemp;
                return NO;
            }else if (strTemp.length <= 11)
            {
                [strTemp insertString:@"-" atIndex:3];
                [strTemp insertString:@"-" atIndex:8];
                self.text = strTemp;
                return NO;
            }else
            {
                return NO;
            }
        }
    }else
    {
        [MBProgressHUD showTipMessageInView:@"请输入正确的电话号码格式！"];
    }
    return NO;
}



/**
 只能输入数字
 */
- (BOOL)textFieldStringTypeNumber:(NSString *)stringReplacement
{
    return  [self inputTypeVerification:stringReplacement format:kDNUMBERS];
    
}

/**
 只能输入字母
 */
- (BOOL)textFieldStringTypeLetter:(NSString *)stringReplacement
{
    return  [self inputTypeVerification:stringReplacement format:kDLETTER];;
    
}



/**
 获取TextField输入范围
 @return 范围
 */
- (NSRange)getTextFieldRange:(UITextField *)textField
{
    NSInteger adaptedLength = textField.maxInputLenth > 0? MIN(textField.text.length, textField.maxInputLenth) : MIN(textField.text.length, MAXFLOAT);
    NSRange range = NSMakeRange(0, adaptedLength);
    
    return range;
}


/// 计算长度
/// @param textField 输入框
- (void)textFiledDidChange:(UITextField *)textField
{
    if (self.maxInputLenth == 0) return;
    
    NSString *toBeString = textField.text;
    
    NSLog(@" 打印信息toBeString:%@",toBeString);
    
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        //判断markedTextRange是不是为Nil，如果为Nil的话就说明你现在没有未选中的字符，
        //可以计算文字长度。否则此时计算出来的字符长度可能不正确
        
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分(感觉输入中文的时候才有)
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            //中文和字符一起检测  中文是两个字符
            if ([toBeString getStringLenthOfBytes] > self.maxInputLenth)
            {
                textField.text = [toBeString subBytesOfstringToIndex:self.maxInputLenth];
                
            }
        }
    }
    else
    {
        if ([toBeString getStringLenthOfBytes] > self.maxInputLenth)
        {
            textField.text = [toBeString subBytesOfstringToIndex:self.maxInputLenth];
        }
    }
}


- (NSInteger)maxInputLenth
{
    return  [objc_getAssociatedObject(self, _cmd) integerValue] > 0?[objc_getAssociatedObject(self, _cmd) integerValue]:kMaxlenth;
}

-(void)setMaxInputLenth:(NSInteger)maxInputLenth
{
    objc_setAssociatedObject(self, @selector(maxInputLenth), @(maxInputLenth), OBJC_ASSOCIATION_ASSIGN) ;
    [self addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (WXHTextFieldType)textFieldType
{
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setTextFieldType:(WXHTextFieldType)textFieldType
{
    if (textFieldType == WXHTextFieldStringTypePhoneNumber)
    {
        kMaxlenth = 13;
    }
    objc_setAssociatedObject(self, @selector(textFieldType), @(textFieldType), OBJC_ASSOCIATION_ASSIGN) ;
    
}


@end
