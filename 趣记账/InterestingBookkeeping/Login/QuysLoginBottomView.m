
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
    kWeakSelf(self)
    UIButton *btnChoice = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnChoice addTarget:self action:@selector(clickChoiceBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnChoice setImage:[UIImage imageNamed:@"login_xuanze_none"] forState:UIControlStateNormal];
    [btnChoice setImage:[UIImage imageNamed:@"login_xuanze_none"] forState:UIControlStateHighlighted];
    [self addSubview:btnChoice];
    self.btnChoice = btnChoice;
    
    YYLabel *lblCoreText = [[YYLabel alloc] init];
     [self addSubview:lblCoreText];
    self.lblCoreText = lblCoreText;
    
    NSString *strMessage = @"登录需同意《用户协议》和《隐私协议》";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:strMessage];
    [attr addAttribute:NSForegroundColorAttributeName value:kRGB16(kAppThemeColor, 1) range:[strMessage rangeOfString:@"《用户协议》"]];
    [attr addAttribute:NSForegroundColorAttributeName value:kRGB16(kAppThemeColor, 1) range:[strMessage rangeOfString:@"《隐私协议》"]];
    [attr yy_setTextHighlightRange:[strMessage rangeOfString:@"《用户协议》"] color:kRGB16(kAppThemeColor, 1) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"click  用户协议");
        if (weakself.clickUserProrocolBlock) {
            weakself.clickUserProrocolBlock(QuysUserProtocolURL);
        }
    }];
    
    [attr yy_setTextHighlightRange:[strMessage rangeOfString:@"《隐私协议》"] color:kRGB16(kAppThemeColor, 1) backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
          NSLog(@"click  隐私协议");
        if (weakself.clickPrivacyBlock) {
            weakself.clickPrivacyBlock(QuysPrivacyURL);
        }
     }];
    
    lblCoreText.attributedText = attr;
    QuysIconView *ucIconView = [QuysIconView new];
    [ucIconView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:ucIconView];
    self.ucIconView = ucIconView;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [self.btnChoice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kScale_H(15));
        make.left.mas_equalTo(self).offset(kScale_W(20));
        make.height.mas_equalTo(kScale_H(25));
        make.width.mas_equalTo(kScale_W(25));

    }];
    
    [self.lblCoreText mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnChoice);
        make.left.mas_equalTo(self.btnChoice.mas_right).offset(kScale_H(5));
        make.right.mas_equalTo(self).offset(kScale_W(-5)).priorityHigh();
        make.height.mas_equalTo(kScale_H(30));

    }];
    
    [self.ucIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lblCoreText.mas_bottom).offset(kScale_H(5)) ;
        make.left.mas_equalTo(self).offset(kScale_W(15))  ;
        make.right.mas_equalTo(self).offset(kScale_W(-15)).priorityHigh(); ;
        make.bottom.mas_equalTo(self).offset(kScale_H(-5)).priorityHigh();
      }];

    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}


#pragma mark - Private Mehtod

- (void)clickChoiceBtEvent:(UIButton*)sender
{
    sender.selected = ! sender.selected;
    if (sender.selected)
    {
         [self.btnChoice setImage:[UIImage imageNamed:@"login_xuanze_selected"] forState:UIControlStateNormal];
         [self.btnChoice setImage:[UIImage imageNamed:@"login_xuanze_selected"] forState:UIControlStateHighlighted];
 
    }else
    {
        [self.btnChoice setImage:[UIImage imageNamed:@"login_xuanze_none"] forState:UIControlStateNormal];
        [self.btnChoice setImage:[UIImage imageNamed:@"login_xuanze_none"] forState:UIControlStateHighlighted];
    }
    
    if (self.clickBlock) {
         self.clickBlock(sender.selected);
     }
}

 
- (void)setClickCellBlock:(QuysTableCellEventClickBlock)clickCellBlock
{
    _clickCellBlock = clickCellBlock;
    self.ucIconView.clickBlock = clickCellBlock;
}


- (void)setClickBlock:(QuysBtnEventClickBlock)clickBlock
{
    _clickBlock = clickBlock;
    
}

@end
