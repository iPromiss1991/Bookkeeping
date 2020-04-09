//
//  QuysNormalTBCell.h
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuysLoginConfigModel.h"
NS_ASSUME_NONNULL_BEGIN
///lbl + UITextField
@interface QuysNormalTBCell : UITableViewCell

@property (nonatomic,strong) QuysLoginConfigModel *model;
@property (nonatomic,copy) QuysCallbackBlock  endEditingBlock;
@end

NS_ASSUME_NONNULL_END
