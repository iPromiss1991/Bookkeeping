//
//  UITextField+QuysPhoneNumFormat.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//



#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,WXHTextFieldType) {
    WXHTextFieldStringTypeNone = 0,            // 不限制
    WXHTextFieldStringTypePhoneNumber = 1,         // 电话
    WXHTextFieldStringTypeNumber = 2,         // 数字
    WXHTextFieldStringTypeLetter = 3         // 字母
};

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (QuysFormat)


@property (nonatomic,assign) NSInteger maxInputLenth;//!<  最大输入长度
@property (nonatomic,assign) WXHTextFieldType textFieldType;//!<  键盘类型

#warning 在 textField: shouldChangeCharactersInRange:replacementString:中调用
/// 验证输入内容是否合规
/// @param string 当前字符串
/// @param range 变化范围
- (BOOL)valueChangeValueString:(NSString *)string shouldChangeCharactersInRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
