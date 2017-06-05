//
//  RegisterViewController.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "RegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface RegisterViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendCodeButtonClicked:(id)sender {
    [AVOSCloud requestSmsCodeWithPhoneNumber:self.phoneNumberTextField.text
                                    callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (!succeeded) {
            NSLog(@"Send verify code failed, error info:%@", error);
        }
    }];
}

- (IBAction)registerButtonClicked:(id)sender {
//    [AVOSCloud verifySmsCode:self.verifyCodeTextField.text
//           mobilePhoneNumber:self.passwordTextField.text
//                    callback:^(BOOL succeeded, NSError * _Nullable error) {
//        if (!succeeded) {
//            NSLog(@"Verify phone failed, error info:%@", error);
//        } else {
            AVUser *user = [AVUser user];
            user.username = self.phoneNumberTextField.text;
            user.password = self.passwordTextField.text;
//            user.mobilePhoneNumber = self.passwordTextField.text;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!succeeded) {
                    NSLog(@"Register failed, error info:%@", error);
                } else {
                    //注册成功
                    NSLog(@"\n\n注册成功！\n\n");
                }
            }];
//        }
//    }];
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.phoneNumberTextField]) {
        [self.verifyCodeTextField resignFirstResponder];
    } else if ([textField isEqual:self.verifyCodeTextField]) {
        [self.passwordTextField resignFirstResponder];
    } else if ([textField isEqual:self.passwordTextField]) {
        [self registerButtonClicked:self.registerButton];
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
