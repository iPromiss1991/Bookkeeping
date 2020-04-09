//
//  QuysLoginBottomView.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuysLoginBottomView : UIView
@property (nonatomic,copy) QuysBtnEventClickBlock  clickBlock;
@property (nonatomic,copy) QuysTableCellEventClickBlock  clickCellBlock;

@property (nonatomic,copy) QuysCallbackBlock  clickUserProrocolBlock;
@property (nonatomic,copy) QuysCallbackBlock  clickPrivacyBlock;

 @end

NS_ASSUME_NONNULL_END
