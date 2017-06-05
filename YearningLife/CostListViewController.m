//
//  CostListViewController.m
//  YearningLife
//
//  Created by boxfish on 2017/5/30.
//  Copyright © 2017年 LH. All rights reserved.
//

#import "CostListViewController.h"
#import "CostListTableViewCell.h"
#import "CostInfo.h"
#import "PersonalAccountInfo.h"
#import "AccountInfo.h"

@interface CostListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *personalAccountInfoArray;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CostListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Yearing Life";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    UIBarButtonItem *accountButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结算" style:UIBarButtonItemStylePlain target:self action:@selector(doAccountActions)];
    self.navigationItem.rightBarButtonItem = accountButtonItem;
    
    self.dataArray = [NSMutableArray array];
    
//    CostInfo *costInfo = [CostInfo object];
//    costInfo.user = [AVUser currentUser];
//    costInfo.cost = 126.8;
//    costInfo.costDescription = @"JiYeon的第三个购买项，测试数据";
//    costInfo.date = [NSDate date];
//    costInfo.status = 0;
//    [costInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            NSLog(@"第二条测试数据存储成功");
//            
//        }
//    }];
//
    __weak typeof(self) weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:@"CostInfo"];
    [query whereKey:@"status" equalTo:@(0)];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:objects];
        [weakSelf.tableView reloadData];
    }];
}

- (void)doAccountActions {
    
    __weak typeof(self) weakSelf = self;
    
    AVQuery *query = [AVQuery queryWithClassName:@"CostInfo"];
    [query whereKey:@"status" equalTo:@(0)];
//    [query includeKey:@"_User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [weakSelf handleDidGetCostInfoObjects:objects];
    }];
}

- (void)handleDidGetCostInfoObjects:(NSArray *)array {
    if (array.count > 0) {
        self.personalAccountInfoArray = [NSMutableArray array];
        CGFloat accountTotalCount = 0.f;
        for (CostInfo *costInfo in array) {
            costInfo.status = 1;
            PersonalAccountInfo *accountInfo = [self getPersonalInfoByUser:costInfo.user];
            [accountInfo updateTotalCountByIncreaseCount:costInfo.cost];
            [accountInfo.costList addObject:costInfo];
            accountTotalCount += costInfo.cost;
        }
        NSInteger userCount = self.personalAccountInfoArray.count;
        CGFloat averageCount = 0.f;
        if (userCount > 0) {
            averageCount = accountTotalCount / userCount;
        }
        for (PersonalAccountInfo *accountInfo in self.personalAccountInfoArray) {
            accountInfo.result = accountInfo.totalCount - averageCount;
        }
        
        [CostInfo saveAllInBackground:array block:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"\n\n\n\n\nCostInfo表更新成功.\n\n\n\n\n");
                
                [PersonalAccountInfo saveAllInBackground:self.personalAccountInfoArray block:^(BOOL succeeded, NSError * _Nullable error) {
                    if (succeeded) {
                        NSLog(@"\n\n\n\n\nPersonalAccountInfo表更新成功.\n\n\n\n\n");
                        AccountInfo *accountInfo = [[AccountInfo alloc] init];
                        accountInfo.status = 1;
                        for (PersonalAccountInfo *personalAccountInfo in self.personalAccountInfoArray) {
                            [accountInfo updateTotalCountByIncreaseCount:accountInfo.totalCount];
                            [accountInfo.peronalAccountList addObject:personalAccountInfo];
                        }
                        [accountInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            if (succeeded) {
                                NSLog(@"\n\n\n\n\nAccountInfo表更新成功\n本次结算成功.\n\n\n\n\n");
                            }
                        }];
                    }
                }];
            }
        }];
    } else {
        //没有可结算的数据
    }
}

- (PersonalAccountInfo *)getPersonalInfoByUser:(AVUser *)user {
    for (PersonalAccountInfo *accountInfo in self.personalAccountInfoArray) {
        if ([accountInfo.user.objectId isEqualToString:user.objectId]) {
            return accountInfo;
        }
    }
    PersonalAccountInfo *personalAccountInfo = [[PersonalAccountInfo alloc] init];
    personalAccountInfo.user = user;
    [self.personalAccountInfoArray addObject:personalAccountInfo];
    return personalAccountInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"costListCellId";
    CostListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CostListTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row < self.dataArray.count) {
        CostInfo *info = self.dataArray[indexPath.row];
        cell.costLabel.text = [NSString stringWithFormat:@"￥%.2f", info.cost];
        cell.despLabel.text = info.costDescription;
    }
    
    return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 97.f;
}


@end
