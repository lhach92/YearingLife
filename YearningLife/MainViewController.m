//
//  MainViewController.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "MainViewController.h"
#import "CostListViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) CostListViewController *costListViewController;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.costListViewController) {
        self.costListViewController = [[CostListViewController alloc] init];
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.costListViewController];
    self.viewControllers = @[ nav ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
