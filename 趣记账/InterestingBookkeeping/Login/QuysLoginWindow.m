
//
//  QuysLoginWindow.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/30.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginWindow.h"
#import "QuysLoginVC.h"

@interface QuysLoginWindow()
@property (nonatomic,strong) QuysLoginVC *rootVC;

@end


@implementation QuysLoginWindow

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
    
    QuysLoginVC *vc = [QuysLoginVC new];
    vc.parentWindow = self;
    self.rootVC = vc;
    self.rootViewController = vc;
    self.windowLevel = UIWindowLevelNormal +1;
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
