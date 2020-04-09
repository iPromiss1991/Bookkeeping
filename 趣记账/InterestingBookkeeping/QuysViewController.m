//
//  QuysViewController.m
//  趣记账
//
//  Created by quys on 2020/3/19.
//  Copyright © 2020 Quys. All rights reserved.
//

#import "QuysViewController.h"
#import "QuysRunloopObserver.h"
#import "QuysLoginWindow.h"
@interface QuysViewController ()
@property (nonatomic,strong) QuysLoginWindow *loginWindow;

@end

@implementation QuysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
 

    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    QuysLoginWindow *loginWindow = [QuysLoginWindow new];
    [loginWindow makeKeyAndVisible];
    self.loginWindow = loginWindow;
    
}

@end
