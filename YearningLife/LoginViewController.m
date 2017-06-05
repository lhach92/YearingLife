//
//  LoginViewController.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CostInfo.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender {
    [AVUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(AVUser * _Nullable user, NSError * _Nullable error) {
        if (user != nil) {
//            //登录成功
//            CostInfo *costInfo = [CostInfo object];
//            costInfo.user = [AVUser currentUser];
//            costInfo.cost = 0.1;
//            costInfo.costDescription = @"我的第一个购买项，测试数据";
//            costInfo.date = [NSDate date];
//            costInfo.status = 0;
//            [costInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                if (succeeded) {
//                    NSLog(@"第一条测试数据存储成功");
//                }
//            }];
            [self dismissViewControllerAnimated:NO completion:nil];
        } else {
            NSLog(@"登录失败， error info : %@", error);
        }
    }];
}


#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.usernameTextField]) {
        [self.passwordTextField resignFirstResponder];
    } else if ([textField isEqual:self.passwordTextField]) {
        [self loginButtonClicked:self.loginButton];
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
