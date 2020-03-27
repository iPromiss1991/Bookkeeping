
//
//  QuysLoginBottomView.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/27.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginBottomView.h"
#import "QuysIconView.h"
#import <YYText/YYText.h>
@interface QuysLoginBottomView()
@property (nonatomic,strong) UIButton *btnChoice;
@property (nonatomic,strong) YYLabel *lblCoreText;

@property (nonatomic,strong) QuysIconView *ucIconView;



@end


@implementation QuysLoginBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    
}

- (void)updateConstraints
{
    
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


@end
