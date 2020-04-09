//
//  QuysVerifyTBCell.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysLoginConfigModel.h"
typedef void(^QuysGetVerifyCodeBlock)(void);//!<  获取验证码

NS_ASSUME_NONNULL_BEGIN
///lbl + UITextField +verifyCode
@interface QuysVerifyTBCell : UITableViewCell
@property (nonatomic,strong) QuysLoginConfigModel *model;
@property (nonatomic,copy) QuysTextFieldShouldChangeCharactersInRangeBlock  changeBlock;
@property (nonatomic,copy) QuysCallbackBlock  endEditingBlock;
@property (nonatomic,copy) QuysGetVerifyCodeBlock  verifyCodeBlock;
@end

NS_ASSUME_NONNULL_END
