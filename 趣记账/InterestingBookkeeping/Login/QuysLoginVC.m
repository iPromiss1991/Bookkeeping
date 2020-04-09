//
//  QuysLoginVC.m
//  趣记账
//
//  Created by quys on 2020/3/26.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysLoginVC.h"
#import "QuysNormalTBCell.h"
#import "QuysVerifyTBCell.h"
#import "QuysLoginConfigModel.h"
#import "QuysLoginBottomView.h"
#import "QuysLoginService.h"
#import "QuysWebviewVC.h"
 @interface QuysLoginVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton *btnClose;

@property (nonatomic,strong) UIView *viewContain;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIButton *btnLogin;

@property (nonatomic,strong) NSArray *arrSource;
@property (nonatomic,strong) QuysLoginBottomView *bottomView;
@property (nonatomic,strong) QuysLoginService *loginService;



@end

@implementation QuysLoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIView *viewContain = [[UIView alloc]init];
    viewContain.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewContain];
    self.viewContain = viewContain;
    
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnClose addTarget:self action:@selector(clickCloseBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnClose setTitle:@"返回" forState:UIControlStateNormal];
    [btnClose setTitle:@"返回" forState:UIControlStateHighlighted];
    [btnClose setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnClose setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.viewContain addSubview:btnClose];
    self.btnClose = btnClose;
    
    [self.tableview registerClass:[QuysNormalTBCell class] forCellReuseIdentifier:NSStringFromClass([QuysNormalTBCell class])];
    [self.tableview registerClass:[QuysVerifyTBCell class] forCellReuseIdentifier:NSStringFromClass([QuysVerifyTBCell class])];
    [self.tableview setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.bottomView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.viewContain addSubview:self.tableview];
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin addTarget:self action:@selector(clickLoginBtEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitle:@"登录" forState:UIControlStateHighlighted];
    kViewRadius(btnLogin, kScale_W(10));
    [btnLogin setBackgroundColor:kRGB16(kAppThemeColor, 1)];
    [self.viewContain addSubview:btnLogin];
    self.btnLogin = btnLogin;
    

    [self.view addSubview:self.bottomView];
    [self.tableview reloadData];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
}


- (void)updateViewConstraints
{
    [self.viewContain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(kScale_W(10));
        make.right.mas_equalTo(self.view).offset(kScale_W(-10));
     }];
    
    [self.btnClose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.viewContain).offset(0 );
        make.left.mas_equalTo(self.viewContain);
        make.right.mas_lessThanOrEqualTo(self.viewContain);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_greaterThanOrEqualTo(self.btnClose.mas_bottom).offset(kScale_H(30));
        make.left.right.mas_equalTo(self.viewContain);
        make.height.mas_equalTo(kScale_H(46 * 2));
    }];
    
    [self.btnLogin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableview.mas_bottom).offset(kScale_H(10));
        make.left.right.mas_equalTo(self.tableview);
        make.height.mas_equalTo(kScale_H(60));
        make.bottom.mas_equalTo(self.viewContain);
    }];
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_lessThanOrEqualTo(self.viewContain.mas_bottom).offset(kScale_H(50)).priorityLow();
        make.left.mas_equalTo(self.view).offset(kScale_W(10));
        make.right.mas_equalTo(self.view).offset(kScale_W(-10)).priorityHigh();
        make.bottom.mas_equalTo(self.view).priorityHigh();;
     }];
    
    [super updateViewConstraints];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kWeakSelf(self)
    if (indexPath.row == 0) {
         QuysNormalTBCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuysNormalTBCell class])];
         cell.model = self.arrSource[indexPath.row];
        cell.endEditingBlock = ^(NSString *txtString) {
            weakself.loginService.userPhoneNum = txtString;
            QuysLoginConfigModel *modelCode = weakself.arrSource[1];
            modelCode.postVerifyCodeEnable = [[txtString stringRemoveSeparator:@"-"] isMobileNumber];
        };
         return cell;
    }else
    {
        QuysVerifyTBCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuysVerifyTBCell class])];
        cell.model = self.arrSource[indexPath.row];
        cell.endEditingBlock = ^(NSString *txtString) {
             weakself.loginService.verificationCode = txtString;
        };
        return cell;
    }
}

#pragma mark - Private Method

- (void)clickLoginBtEvent:(UIButton*)sender
{
    [self.view endEditing:YES ];
    [self.parentWindow makeKeyAndVisible];
    QuysLoginConfigModel *modelPhoneNum = self.arrSource[0];
    QuysLoginConfigModel *modelCode = self.arrSource[1];

    self.loginService.userPhoneNum = modelPhoneNum.value;
    self.loginService.verificationCode = modelCode.value;
    [self.loginService loginByVerifyCodeWithcurrentVC:self callBack:self.loginFinishBlock];
}

- (void)clickCloseBtEvent:(UIButton*)sender
{
    if (![self goBack:nil])
    {
        self.parentWindow.hidden = YES;
    };
}

#pragma mark - Init

- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }return _tableview;
}


-(NSArray *)arrSource
{
    if (_arrSource == nil)
    {
        QuysLoginConfigModel *modelPhoneNum = [QuysLoginConfigModel new ];
        modelPhoneNum.desc = @"手机";
        modelPhoneNum.placeholder = @"请输入手机号码";
        modelPhoneNum.key = @"手机";
        modelPhoneNum.value = @"";
        
        QuysLoginConfigModel *modelVerify = [QuysLoginConfigModel new ];
        modelVerify.desc = @"验证码";
        modelVerify.placeholder = @"请输入验证码";
        modelVerify.key = @"手机";
        modelVerify.value = @"";
        _arrSource = @[modelPhoneNum,modelVerify];
    }return _arrSource;
};


- (QuysLoginBottomView *)bottomView
{
    kWeakSelf(self)
    if (_bottomView == nil) {
        _bottomView = [[QuysLoginBottomView alloc] init];
        _bottomView.clickPrivacyBlock = ^(NSString *txtString) {
            //隐私政策
            QuysWebviewVC *vc = [[QuysWebviewVC alloc] initWithUrl:txtString];
            [weakself presentViewController:vc animated:YES completion:nil];
        };
        
        _bottomView.clickUserProrocolBlock = ^(NSString *txtString) {
            //用户协议
            QuysWebviewVC *vc = [[QuysWebviewVC alloc] initWithUrl:txtString];
            [weakself presentViewController:vc animated:YES completion:nil];
        };
        
        _bottomView.clickBlock = ^(BOOL choose) {
            //是否阅读：协议& 隐私
            [weakself.loginService readedUserAndPrivacyAgreement:choose];
        };
        
        _bottomView.clickCellBlock = ^(NSIndexPath *indexPath)
        {
            if (indexPath.row == 0)
            {
                 [weakself.loginService loginByQuickPlatform:QUYSLoginPlatformTypeQQ currentVC:weakself callBack:weakself.loginFinishBlock];
            }else if (indexPath.row == 1)
            {
                [weakself.loginService loginByQuickPlatform:QUYSLoginPlatformTypeWEIXIN currentVC:weakself callBack:weakself.loginFinishBlock];
            }
        };
    }return _bottomView;
}

- (QuysLoginService *)loginService
{
    if (_loginService == nil) {
        _loginService = [QuysLoginService new];
    }return _loginService;
}
@end
