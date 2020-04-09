//
//  QuysNormalTBCell.m
//  InterestingBookkeeping
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysVerifyTBCell.h"
#import "QuysTimerWeakTarget.h"

NSInteger countdownDefault = 60;
@interface QuysVerifyTBCell()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *viewContain;

@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UITextField *txtInput;

@property (nonatomic,strong) UIButton *btnVerify;
@property (nonatomic,strong) UIView *viewStrokeline;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) NSInteger countdown;

@end


@implementation QuysVerifyTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    self.countdown = countdownDefault;
    self.backgroundColor = [UIColor clearColor];
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:viewContain];
    self.viewContain = viewContain;
    
    UILabel *lblTitle = [UILabel new];
    [lblTitle setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    lblTitle.textAlignment = NSTextAlignmentLeft;
    lblTitle.font = kFont(17);
    lblTitle.textColor = kRGB16(kTextThemeColor1, 1);
    lblTitle.text = @"";
    self.lblTitle = lblTitle;
    [self.viewContain addSubview:lblTitle];
    
    UITextField *txtInput = [UITextField new ];
    [txtInput setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    txtInput.maxInputLenth = 6;
    txtInput.textColor = kRGB16(kTextThemeColor1, 1);
    txtInput.textFieldType = WXHTextFieldStringTypeNumber;
    txtInput.delegate = self;
    [self.viewContain addSubview:txtInput];
    self.txtInput = txtInput;
    
    UIButton *btnVerify = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnVerify setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [btnVerify setTitle:@"  发送验证码  " forState:UIControlStateNormal];
    [btnVerify setBackgroundColor:kRGB16(kAppThemeColor, 1)];
    [btnVerify addTarget:self action:@selector(verifyEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewContain addSubview:btnVerify];
    self.btnVerify = btnVerify;
    
    UIView *viewStrokeline = [[UIView alloc]init];
    viewStrokeline.backgroundColor = kRGB16(kStrokeLineColor1, 1);
    [self.viewContain addSubview:viewStrokeline];
    self.viewStrokeline = viewStrokeline;
    
}

- (void)updateConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.lblTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.viewContain);
        make.left.mas_equalTo(self.viewContain).offset(kScale_W(10));
    }];
    
    [self.txtInput mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.viewContain);
        make.left.mas_equalTo(self.lblTitle.mas_right).offset(kScale_W(2));
        make.height.mas_equalTo(kScale_H(44)).priorityHigh();
    }];
    
    [self.btnVerify mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.viewContain);
        make.left.mas_equalTo(self.txtInput.mas_right).offset(kScale_W(2));
        make.right.mas_equalTo(self.viewContain.mas_right).offset(-kScale_W(15));
    }];
    
    
    [self.viewStrokeline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.txtInput.mas_bottom);
        make.left.mas_equalTo(self.lblTitle);
        make.right.mas_equalTo(self.viewContain).offset(-kScale_W(10));
        make.bottom.mas_equalTo(self.viewContain);
        make.height.mas_equalTo(1);
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kViewRadius(self.btnVerify, kScale_W(10));
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOOL changeEnable = [textField valueChangeValueString:string shouldChangeCharactersInRange:range];
    if (changeEnable)
    {
        if (self.changeBlock)
        {
            self.changeBlock(changeEnable);
        }
    }else
    {
        if ([[textField.text stringRemoveSeparator:@" "] length] >= 6)
        {
            
        }else
        {
            [MBProgressHUD showTipMessageInView:@"请输入数字！"];
        }
    }
    return changeEnable;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    self.model.value = [[textField.text stringRemoveSeparator:@"-"] stringRemoveBlank];
    if (self.endEditingBlock) {
        self.endEditingBlock(self.model.value);
    }
}

#pragma mark - Private Method

- (void)verifyEvent:(UIButton*)sender
{
    [self endEditing:YES ];
    if (self.model.postVerifyCodeEnable)
    {
        sender.resumeEventInterval = countdownDefault;
        //倒计时 (默认：xx 秒)
        if (self.countdown <= 0)
        {
            self.countdown = countdownDefault;
        }
        [MBProgressHUD showTipMessageInView:@"验证码发送成功！"];
        
        self.countdown--;
        [self.btnVerify setTitle:[NSString stringWithFormat:@" %ld s ",self.countdown] forState:UIControlStateNormal];
        [self.btnVerify setTitle:[NSString stringWithFormat:@" %ld s ",self.countdown] forState:UIControlStateHighlighted];
        self.timer =  [QuysTimerWeakTarget scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdowntimer) userInfo:@{} repeats:YES];
        if (self.verifyCodeBlock)
        {
            self.verifyCodeBlock();
        }
        
    }else
    {
        [self.window makeKeyAndVisible];
        [MBProgressHUD showTipMessageInView:@"请核对电话号码！"];
    }
}

- (void)countdowntimer
{
    if (self.countdown >= 1)
    {
        {
            self.countdown--;
            [self.btnVerify setTitle:[NSString stringWithFormat:@" %ld s ",self.countdown] forState:UIControlStateNormal];
            [self.btnVerify setTitle:[NSString stringWithFormat:@" %ld s ",self.countdown] forState:UIControlStateHighlighted];
        }
    }else
    {
        [self.btnVerify setTitle:[NSString stringWithFormat:@" 点击获取验证码 "] forState:UIControlStateNormal];
        [self.btnVerify setTitle:[NSString stringWithFormat:@" 点击获取验证码 "] forState:UIControlStateHighlighted];
    }
}

- (void)setModel:(QuysLoginConfigModel *)model
{
    _model = model ;
    self.lblTitle.text = model.desc;
    self.txtInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:model.placeholder attributes:@{NSForegroundColorAttributeName:kRGB16(kMaskColor1, 1)}];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



@end
