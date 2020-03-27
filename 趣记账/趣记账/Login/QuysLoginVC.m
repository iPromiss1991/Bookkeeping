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
@interface QuysLoginVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *arrSource;

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
    [self.tableview registerClass:[QuysNormalTBCell class] forCellReuseIdentifier:NSStringFromClass([QuysNormalTBCell class])];
    [self.tableview registerClass:[QuysVerifyTBCell class] forCellReuseIdentifier:NSStringFromClass([QuysVerifyTBCell class])];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
//    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableview];
    [self.tableview reloadData];
 }


- (void)updateViewConstraints
{
    [self.tableview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(kNavBarHeight + 20);
        make.left.mas_equalTo(self.view).offset(kScale_W(10));
        make.right.mas_equalTo(self.view).offset(kScale_W(-10));
        make.bottom.mas_equalTo(self.view);
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
    if (indexPath.row == 0) {
         QuysNormalTBCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuysNormalTBCell class])];
         cell.model = self.arrSource[indexPath.row];
         return cell;
    }else
    {
        QuysVerifyTBCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QuysVerifyTBCell class])];
        cell.model = self.arrSource[indexPath.row];
        return cell;
    }
}


#pragma mark - Init

- (UITableView *)tableview
{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        kViewRadius(_tableview, 20);
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

@end
