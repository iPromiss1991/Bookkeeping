//
//  QuysIconView.h
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysIconModel.h"
NS_ASSUME_NONNULL_BEGIN
///登陆、分享点击icons
@interface QuysIconView : UIView
@property (nonatomic,strong) NSArray <QuysIconModel*> *model;
@property (nonatomic,copy) QuysTableCellEventClickBlock  clickBlock;

 @end

NS_ASSUME_NONNULL_END
