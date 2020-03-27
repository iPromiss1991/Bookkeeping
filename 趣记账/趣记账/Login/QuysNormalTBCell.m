//
//  QuysNormalTBCell.m
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysNormalTBCell.h"
@interface QuysNormalTBCell()<UITextFieldDelegate>
@property (nonatomic,strong) UIView *viewContain;

@property (nonatomic,strong) UILabel *lblTitle;
@property (nonatomic,strong) UITextField *txtInput;
@property (nonatomic,strong) UIView *viewStrokeline;


@end


@implementation QuysNormalTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
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
    txtInput.maxInputLenth = 13;
    txtInput.textFieldType = WXHTextFieldStringTypePhoneNumber;
    txtInput.placeholder = @"";
    txtInput.delegate = self;
    [self.viewContain addSubview:txtInput];
    self.txtInput = txtInput;
    
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
        make.right.mas_equalTo(self.viewContain.mas_right).offset(-kScale_W(10));
        make.height.mas_equalTo(kScale_H(44)).priorityHigh();
    }];
    
    
    [self.viewStrokeline mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.txtInput.mas_bottom);
        make.left.mas_equalTo(self.lblTitle);
        make.right.mas_equalTo(self.txtInput);
        make.bottom.mas_equalTo(self.viewContain);
        make.height.mas_equalTo(1);
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return [textField valueChangeValueString:string shouldChangeCharactersInRange:range];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    NSLog(@"%s",__PRETTY_FUNCTION__);

    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%s",__PRETTY_FUNCTION__);

}


- (void)setModel:(QuysLoginConfigModel *)model
{
    _model = model ;
    self.lblTitle.text = model.desc;
    self.txtInput.placeholder = model.placeholder;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



@end
