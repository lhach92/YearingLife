//
//  ViewController.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self checkIfHasLoggedIn];
}

- (void)checkIfHasLoggedIn {
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser) {
        [self performSegueWithIdentifier:@"showMainVC" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"showLoginVC" sender:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
